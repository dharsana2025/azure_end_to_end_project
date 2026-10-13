-- Gold layer: expose the Silver Parquet data through Synapse serverless SQL.

-- 1. Quick check that Synapse can read the Silver layer
SELECT TOP 10 *
FROM OPENROWSET(
    BULK 'https://adventworksdatalake.dfs.core.windows.net/silver/calendar/',
    FORMAT = 'PARQUET'
) AS query1;
GO

-- 2. Gold schema
CREATE SCHEMA gold;
GO

-- 3. View over the Silver sales data
CREATE VIEW gold.sales AS
SELECT *
FROM OPENROWSET(
    BULK 'https://adventworksdatalake.dfs.core.windows.net/silver/sales',
    FORMAT = 'PARQUET'
) AS q1;
GO

-- 4. Materialize the view as an external table (Parquet) in the Gold container
CREATE EXTERNAL TABLE gold.extsales
WITH (
    LOCATION = 'extsales',
    DATA_SOURCE = SOURCE_GOLD,
    FILE_FORMAT = format_parquet
)
AS
SELECT * FROM gold.sales;
GO
