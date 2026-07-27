## Task 1 Stage 3 - historic capacity records

Reliability calculations must use the capacity that was valid when each telemetry measurement was recorded. The `site_capacities` table from Stage 2 stores only the current capacity, meaning historical values would be overwritten following a site augmentation in a slowly changing dimensions type 1 approach.

To ensure reliability calculations always use the capacity that was valid when each telemetry measurement was recorded, implement a slowly changing dimension type 2 design: site capacity stored as historical data with effective date ranges using 'from' and 'to' date columns. 

## Data model
To enact the above, replace `site_capacities` with a historical `site_capacities_history` table.

site_capacities_history
(
    site_id      INT            NOT NULL,
    capacity_mw  NUMERIC(18,2)  NOT NULL,
    date_from    TIMESTAMP      NOT NULL,
    date_to      TIMESTAMP      NULL,

    PRIMARY KEY (site_id, date_from),
    CHECK (date_to IS NULL OR date_to > date_from)
)
- `date_from` records when a capacity becomes effective 
- `date_to` records when a capacity ceases to be effective.
- Current capacity record has `date_to = NULL`.

## Design considerations
- Capacity periods should never overlap for the same site (can add validation logic or exclusion constraints to enforce this), and each telemetry measurement should match exactly one capacity record.
- Since capacity changes are expected to occur infrequently, the additional storage requirements would be minimal.
- TIMESTAMP datatype matches the precision of `multi_site_measurements` and allows capacity changes to take effect partway through a day, compared to only using date.
- `site_capacity_history` could be related to a parent `sites` table via `site_id`.

## Updating capacity values
- Capacity records should be treated as immutable historical records. 
- When a site's capacity changes update the active record's `date_to` and insert a new record with the new capacity and the `date_from`.
- Can be done as one transaction through stored procedure so as to prevent overlapping capacity periods if one fails.

## Stage 2 reliability calculation changes
For the reliability calculation in stage 2, the tables must now have a temporal join (in addition to joining on site_id) such that the relevant capacity based on the measurement date and site_id is selected dynamically.

Modified join:
LEFT JOIN site_capacities_history c
    ON m.site_id = c.site_id
   AND m."timestamp" >= c.date_from
   AND (
        m."timestamp" < c.date_to
        OR c.date_to IS NULL
   )