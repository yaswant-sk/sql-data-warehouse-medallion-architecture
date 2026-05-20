/*
=============================================================
Create Database and Schemas (PostgreSQL)
=============================================================
Script Purpose:
    This script creates a new database named 'MedallionDataWarehouse' and sets up 
    three schemas within the database following the Medallion Architecture pattern:
    - bronze: Raw data layer (ingested data)
    - silver: Cleaned/transformed data layer
    - gold: Business-ready, aggregated data layer
	
WARNING:
    If the 'MedallionDataWarehouse' database already exists, you must manually 
    drop it before running this script. All data in the database will be 
    permanently deleted. Proceed with caution and ensure you have proper 
    backups before dropping the database.
    
NOTES FOR POSTGRES:
    - PostgreSQL database names are case-insensitive when unquoted but stored in lowercase
    - Using double quotes preserves the exact casing and spelling
    - This script should be run as a superuser (typically 'postgres')
    - Execute in two phases as noted below
=============================================================
*/

-- ============================================================
-- PHASE 1: Create the Database
-- ============================================================
-- Step 1: Connect to the default 'postgres' database
--         If using pgAdmin: 
--         - Right-click on 'postgres' server in Object Explorer
--         - Select 'Query Tool'
--         
--         If using psql command line:
--         - Connect with: psql -U postgres
--         - Then run: \c postgres

-- Step 2: Create the 'MedallionDataWarehouse' database
--         Double quotes preserve the exact name and capitalization
CREATE DATABASE "MedallionDataWarehouse";

-- ============================================================
-- PHASE 2: Create the Schemas
-- ============================================================
-- Step 1: Switch connection to the 'MedallionDataWarehouse' database
--         If using pgAdmin:
--         - Right-click on 'MedallionDataWarehouse' in Object Explorer
--         - Select 'Query Tool'
--         
--         If using psql command line:
--         - Run: \c "MedallionDataWarehouse"

-- Step 2: Create the bronze schema
--         Purpose: Raw data layer
--         Contains: Unmodified data ingested from source systems
--         Retention: Keeps raw data for audit trail and reprocessing
CREATE SCHEMA IF NOT EXISTS bronze;

-- Step 3: Create the silver schema
--         Purpose: Cleaned and standardized data layer
--         Contains: Data that has been cleaned, validated, and transformed
--         Retention: Intermediate processed data for analytics
CREATE SCHEMA IF NOT EXISTS silver;

-- Step 4: Create the gold schema
--         Purpose: Business-ready, aggregated data layer
--         Contains: Fully processed, aggregated data ready for reporting and BI tools
--         Retention: Final analytical datasets for dashboards and business intelligence
CREATE SCHEMA IF NOT EXISTS gold;

-- ============================================================
-- Verification (Optional)
-- ============================================================
-- Run these queries in the MedallionDataWarehouse database to verify setup:
--
-- -- List all schemas in the database
-- SELECT schema_name 
-- FROM information_schema.schemata 
-- WHERE schema_name NOT LIKE 'pg_%' 
-- AND schema_name != 'information_schema'
-- ORDER BY schema_name;
--
-- -- Show schema owner and access information
-- SELECT pg_namespace.nspname AS schema_name, pg_namespace.nspowner as owner
-- FROM pg_catalog.pg_namespace 
-- WHERE pg_namespace.nspname NOT LIKE 'pg_%' 
-- AND pg_namespace.nspname != 'information_schema'
-- ORDER BY schema_name;
-- ============================================================
