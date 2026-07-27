-- Task 1 stage 2
-- Create table statement site_capacities.
-- Capacity stored in MW and converted to kW during reliability calculations.
CREATE TABLE site_capacities (
    site_id     INT           PRIMARY KEY,
    capacity_mw NUMERIC(18,2) NOT NULL
);

-- Telemetry measurements for multiple sites.
-- A foreign key to site_capacities is not enforced to allow telemetry to be ingested even when reference data is missing or delayed.
-- This enables data quality issues to be identified and investigated (via NULLs) rather than rejecting measurements during the load process.
CREATE TABLE multi_site_measurements (
    "timestamp"  TIMESTAMP     NOT NULL,
    site_id      INT           NOT NULL,
    active_power NUMERIC(18,2) NOT NULL,
    setpoint     NUMERIC(18,2) NOT NULL
);

INSERT INTO site_capacities (site_id, capacity_mw) VALUES
(1, 100.00),
(2, 50.00),
(3, 75.00);

INSERT INTO multi_site_measurements ("timestamp", site_id, active_power, setpoint)
VALUES ('2026-07-24 00:00:00', 1, 19850.00, 20000.00),
('2026-07-24 00:30:00', 1, 22100.00, 22000.00),
('2026-07-24 01:00:00', 1, 17750.00, 18000.00),
('2026-07-24 01:30:00', 1, 24400.00, 25000.00),
('2026-07-24 00:00:00', 2, 14800.00, 15000.00),
('2026-07-24 00:30:00', 2, 15250.00, 15000.00),
('2026-07-24 01:00:00', 2, 19850.00, 20000.00),
('2026-07-24 01:30:00', 2, 24200.00, 25000.00),
('2026-07-24 00:00:00', 3, 29800.00, 30000.00),
('2026-07-24 00:30:00', 3, 30550.00, 30000.00),
('2026-07-24 01:00:00', 3, 34750.00, 35000.00),
('2026-07-24 01:30:00', 3, 39250.00, 40000.00);


