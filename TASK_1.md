# Background

You are working on a data platform that ingests telemetry data from Battery Energy Storage System (BESS) sites.

Every thirty minutes, a site reports:

- The active power being delivered.
- The requested setpoint.
- The timestamp of the measurement.

One of the operational KPIs calculated by the business is **Active Power Reliability**, which measures how closely a site's output follows its requested setpoint.

It should return a value of `1` when the measured power exactly matches the setpoint, with the score decreasing proportionally as the deviation increases relative to the site's installed capacity.

Active power may be greater or lower than the setpoint, and reliability should decrease in proportion to the magnitude of the deviation, regardless of whether the site is over- or under-delivering.

The reliability calculation is defined as:

$$
	
\text{Reliability} = 1 - \frac{\text{Deviation from Setpoint}}{\text{Site Capacity}}

$$

Where:

- **Deviation from Setpoint** is the difference between the measured Active Power and the requested Setpoint.
- **Site Capacity** is the maximum rated power output of the site.

Your task is to calculate the daily average reliability from telemetry stored in a SQL database.


## Stage 1 - Calculate Daily Reliability

The database `measurements` table contains telemetry data for a single site at 30-minute intervals.

### Telemetry

| Column | Description |
| --- | --- |
| `timestamp` | Measurement timestamp |
| `active_power` | Measured active power (kW) |
| `setpoint` | Requested active power (kW) |

The Site Capacity is given as `100 MW`.

### Task

Write the SQL to calculate the daily average Active Power Reliability.


## Stage 2 - Supporting Multiple Sites

The platform has now expanded to support multiple sites.

Telemetry now includes a `site_id` field, and site capacities are stored in a separate table:

`multi_site_measurements`

| Column | Description |
| --- | --- |
| `timestamp` | Measurement timestamp |
| `site_id` | Site identifier |
| `active_power` | Measured active power (kW) |
| `setpoint` | Requested active power (kW) |


`site_capacities`

| Column | Description |
| --- | --- |
| `site_id` | Site identifier |
| `capacity_mw` | Installed site capacity (MW) |

### Task

Write the SQL to calculate the daily average reliabilities for each site.


## Stage 3 - Managing Capacity Changes

Occasionally, a site is augmented to increase its MW capacity.


### Task

Describe the adaptations you would make so that reliability calculations always use the capacity that was valid when each telemetry measurement was recorded. Assume that these augmentations happen to a site infrequently (no more often than once every couple of years).

You are not required to write any full SQL queries. Explain your approach, including any changes you would make to the data model and SQL logic required to calculate daily reliability correctly.


## Stage 4 - Scaling

The platform now stores many years of data from tens of sites.

Measurements are collected more frequently, additional metrics have been introduced, and analytical queries are becoming increasingly slow and expensive.

### Task

Assume the ingestion pipelines have proven capable of handling the increased data volumes. Explain how you would optimise the storage, organisation, and querying of historical data to ensure the platform remains scalable, performant, and cost-effective as data scales from a few GBs to 100s and beyond.
