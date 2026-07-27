-- Task 1 Stage 1
-- Calculate the daily average Active Power Reliability for a single site.
-- Site capacity = 100 MW = 100,000 kW.
-- All power values in kW.

WITH cte_reliability AS (
    SELECT
        CAST("timestamp" AS DATE) AS measurement_date,
        1 - (
            ABS(setpoint - active_power) / 100000.0
        ) AS reliability
    FROM measurements
)
SELECT
    measurement_date,
    AVG(reliability) AS avg_reliability
FROM cte_reliability
GROUP BY measurement_date
ORDER BY measurement_date;