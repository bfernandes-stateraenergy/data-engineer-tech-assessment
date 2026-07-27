-- Task 1 stage 2
-- Calculate the daily average Active Power Reliability for multiple sites.
-- All power is in kW.
-- Left join with capacities table so null values are identified - change to inner if dataset requires no null values
WITH cte_site_reliability AS (
    SELECT
        CAST(m."timestamp" AS DATE) AS measurement_date,
        m.site_id,
        1 - (ABS(m.setpoint - m.active_power)/ (c.capacity_mw * 1000.0)) AS reliability
    FROM multi_site_measurements m
    LEFT JOIN site_capacities c
        ON m.site_id = c.site_id
)
SELECT
    measurement_date,
    site_id,
    AVG(reliability) AS avg_reliability
FROM cte_site_reliability
GROUP BY
    measurement_date,
    site_id
ORDER BY
    measurement_date,
    site_id;
