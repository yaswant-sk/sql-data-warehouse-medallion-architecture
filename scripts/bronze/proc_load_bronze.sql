/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `COPY FROM` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    CALL bronze.load_bronze();
===============================================================================
*/
CREATE OR REPLACE PROCEDURE bronze.load_bronze()
LANGUAGE plpgsql
AS $$
DECLARE
	start_time TIMESTAMP;
	end_time TIMESTAMP;
	batch_start_time TIMESTAMP;
	batch_end_time TIMESTAMP;
BEGIN
    RAISE NOTICE '==================================================';
    RAISE NOTICE 'STARTING BRONZE LOAD';
    RAISE NOTICE '==================================================';

    RAISE NOTICE '==================================================';
    RAISE NOTICE 'Loading CRM Tables';
    RAISE NOTICE '==================================================';

	batch_start_time := CURRENT_TIMESTAMP;
	start_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '>> Preparing to truncate: crm_cust_info';
    TRUNCATE TABLE bronze.crm_cust_info;
    RAISE NOTICE '>> Truncated: crm_cust_info';
	
    RAISE NOTICE '>> Loading: crm_cust_info';
    COPY bronze.crm_cust_info
    FROM 'C:/datasets/source_crm/cust_info.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',');
    RAISE NOTICE '>> Loaded: crm_cust_info';
	end_time := CURRENT_TIMESTAMP; 
	RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM (end_time - start_time))::INTEGER;

	start_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '>> Preparing to truncate: crm_prd_info';
    TRUNCATE TABLE bronze.crm_prd_info;
    RAISE NOTICE '>> Truncated: crm_prd_info';
	
    RAISE NOTICE '>> Loading: crm_prd_info';
    COPY bronze.crm_prd_info
    FROM 'C:/datasets/source_crm/prd_info.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',');
    RAISE NOTICE '>> Loaded: crm_prd_info';
	end_time := CURRENT_TIMESTAMP; 
	RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM (end_time - start_time))::INTEGER;

	start_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '>> Preparing to truncate: crm_sales_details';
    TRUNCATE TABLE bronze.crm_sales_details;
    RAISE NOTICE '>> Truncated: crm_sales_details';
	
    RAISE NOTICE '>> Loading: crm_sales_details';
    COPY bronze.crm_sales_details
    FROM 'C:/datasets/source_crm/sales_details.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',');
    RAISE NOTICE '>> Loaded: crm_sales_details';
	end_time := CURRENT_TIMESTAMP; 
	RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM (end_time - start_time))::INTEGER;

    RAISE NOTICE '==================================================';
    RAISE NOTICE 'Loading ERP Tables';
    RAISE NOTICE '==================================================';

	start_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '>> Preparing to truncate: erp_cust_az12';
    TRUNCATE TABLE bronze.erp_cust_az12;
    RAISE NOTICE '>> Truncated: erp_cust_az12';
	
    RAISE NOTICE '>> Loading: erp_cust_az12';
    COPY bronze.erp_cust_az12
    FROM 'C:/datasets/source_erp/cust_az12.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',');
    RAISE NOTICE '>> Loaded: erp_cust_az12';
	end_time := CURRENT_TIMESTAMP; 
	RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM (end_time - start_time))::INTEGER;

	start_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '>> Preparing to truncate: erp_loc_a101';
    TRUNCATE TABLE bronze.erp_loc_a101;
    RAISE NOTICE '>> Truncated: erp_loc_a101';
	
    RAISE NOTICE '>> Loading: erp_loc_a101';
    COPY bronze.erp_loc_a101
    FROM 'C:/datasets/source_erp/loc_a101.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',');
    RAISE NOTICE '>> Loaded: erp_loc_a101';
	end_time := CURRENT_TIMESTAMP; 
	RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM (end_time - start_time))::INTEGER;

	start_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '>> Preparing to truncate: erp_px_cat_g1v2';
    TRUNCATE TABLE bronze.erp_px_cat_g1v2;
    RAISE NOTICE '>> Truncated: erp_px_cat_g1v2';
	
    RAISE NOTICE '>> Loading: erp_px_cat_g1v2';
    COPY bronze.erp_px_cat_g1v2
    FROM 'C:/datasets/source_erp/px_cat_g1v2.csv'
    WITH (FORMAT csv, HEADER true, DELIMITER ',');
    RAISE NOTICE '>> Loaded: erp_px_cat_g1v2';
	end_time := CURRENT_TIMESTAMP; 
	RAISE NOTICE '>> Load Duration: % seconds', EXTRACT(EPOCH FROM (end_time - start_time))::INTEGER;

	batch_end_time := CURRENT_TIMESTAMP;
    RAISE NOTICE '==================================================';
    RAISE NOTICE 'BRONZE LOAD COMPLETED SUCCESSFULLY';
    RAISE NOTICE '==================================================';
	RAISE NOTICE '>> Total Load Duration: % seconds', EXTRACT(EPOCH FROM (batch_end_time - batch_start_time))::INTEGER;
EXCEPTION
	WHEN OTHERS THEN
		RAISE NOTICE 'Error occurred during bronze load: %', SQLERRM;
		RAISE NOTICE 'Error Detail: %', PG_EXCEPTION_DETAIL;
		RAISE;
END;
$$;
