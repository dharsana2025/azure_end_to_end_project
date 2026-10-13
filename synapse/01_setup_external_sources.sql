-- Run in the Synapse serverless SQL pool (Built-in), inside your gold database.
-- Creates the external data sources and file format used by the Gold layer.

-- Credential used to read and write the data lake.
-- Adjust this block to match how cred_dhars was created in your workspace.
-- CREATE MASTER KEY ENCRYPTION BY PASSWORD = '<strong-password>';
-- CREATE DATABASE SCOPED CREDENTIAL cred_dhars
-- WITH IDENTITY = 'Managed Identity';

CREATE EXTERNAL DATA SOURCE SOURCE_SILVER
WITH (
    LOCATION = 'https://adventworksdatalake.dfs.core.windows.net/silver',
    CREDENTIAL = cred_dhars
);

CREATE EXTERNAL DATA SOURCE SOURCE_GOLD
WITH (
    LOCATION = 'https://adventworksdatalake.dfs.core.windows.net/gold',
    CREDENTIAL = cred_dhars
);

CREATE EXTERNAL FILE FORMAT format_parquet
WITH (
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
);
