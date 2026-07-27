## Task 1 Stage 4 - Scalability
As data volumes grow, the focus shifts to reducing the amount of data scanned, separating analytical workloads from ingestion, and making efficient use of the underlying technology stack.

### OLAP Pre-Aggregated Reporting
The architecture described in Stages 2 and 3 primarily supports an OLTP workload with frequent telemetry data inserts. As data volumes increase, KPI calculations and analytical queries become increasingly expensive if they repeatedly scan raw telemetry data.

To address this, an OLAP reporting layer could be introduced containing pre-aggregated reporting tables (e.g. daily or monthly reliability) that are refreshed incrementally. These tables contain significantly fewer rows than `multi_site_measurements`, reducing query execution times and compute costs.

### Partitioning
Partition the high-volume `multi_site_measurements` table by measurement date (a commonly queried time frequency e.g. daily or monthly). This enables partition pruning so queries scan only the required time ranges rather than the entire dataset.

### Incremental Processing
Rather than repeatedly recalculating historical KPIs, process only newly arrived telemetry data and update the reporting tables incrementally. This keeps processing times and compute costs predictable as data volumes increase.

### Indexing
Create indexes in line with common query patterns, e.g. (site_id, timestamp) for `multi_site_measurements`.
Indexes improve read performance but should be limited to common access patterns because they increase storage and write overhead.

### Data Modelling
Keep high-volume telemetry separate from relatively static reference data such as site metadata and capacity history. This reduces duplication, simplifies maintenance and keeps ingestion performant.

### Retention and Storage Tiers
Retain recent operational data in high-performance storage while archiving older telemetry to lower-cost storage.

### Applying the Statera Technology Stack
Based on the technologies discussed during the first-stage interview, Databricks, ClickHouse and Grafana could be used to support this architecture.

**Databricks** could be used to process and aggregate incoming telemetry. Raw telemetry could be stored in Delta Lake partitioned by measurement date, with optimisation techniques such as compaction and Z-Ordering on `site_id` and `timestamp` used to improve query performance.

**ClickHouse** is designed for OLAP workloads and high-performance analytical queries across large time-series datasets. Pre-aggregated KPI tables, such as daily and monthly reliability, could be loaded into ClickHouse to provide fast analytical querying without repeatedly scanning raw telemetry.

**Grafana** dashboards could then query ClickHouse directly, providing low-latency KPI visualisation while reducing load on the underlying telemetry platform.