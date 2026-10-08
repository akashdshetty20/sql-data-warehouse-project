create or alter PROCEDURE bronze.load_bronze AS
begin
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME 
    begin try
        PRINT '==========================================' ;
        PRINT 'Loading Bronze Layer' ;
        PRINT '==========================================' ;
        
        PRINT '------------------------------------------' ;
        PRINT 'Loading CRM Tables' ;
        PRINT '------------------------------------------' ;

    SET @batch_start_time = GETDATE()

    SET @start_time = getdate();
    PRINT '>> Truncating Table: bronze.crm_cust_info' ;
    truncate table bronze.crm_cust_info;

    PRINT '>> Inserting Table: bronze.crm_cust_info' ;

    BULK INSERT bronze.crm_cust_info
    FROM '/var/opt/mssql/datasets/source_crm/cust_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    SET @end_time = getdate();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'; 

    SET @start_time = getdate();
    PRINT '>> Truncating Table: bronze.crm_prd_info' ;

    truncate table bronze.crm_prd_info;

    PRINT '>> Inserting Table: bronze.crm_prd_info' ;

    BULK INSERT bronze.crm_prd_info
    FROM '/var/opt/mssql/datasets/source_crm/prd_info.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    SET @end_time = getdate();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'; 

    SET @start_time = getdate();
    PRINT '>> Truncating Table: bronze.crm_sales_details' ;

    truncate table bronze.crm_sales_details;

    SET @end_time = getdate();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'; 

    SET @start_time = getdate();
    PRINT '>> Inserting Table: bronze.crm_sales_details' ;

    BULK INSERT bronze.crm_sales_details
    FROM '/var/opt/mssql/datasets/source_crm/sales_details.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @end_time = getdate();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'; 


    PRINT '------------------------------------------' ;
        PRINT 'Loading ERP Tables' ;
        PRINT '------------------------------------------' ;

    SET @start_time = getdate();
    PRINT '>> Truncating Table: bronze.erp_cust_az12' ;
    
    truncate table bronze.erp_cust_az12;

    PRINT '>> Inserting Table: bronze.erp_cust_az12'

    BULK INSERT bronze.erp_cust_az12
    FROM '/var/opt/mssql/datasets/source_erp/CUST_AZ12.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    SET @end_time = getdate();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'; 

    SET @start_time = getdate();
    PRINT '>> Truncating Table: bronze.erp_loc_a101' ;

    truncate table bronze.erp_loc_a101;

    PRINT '>> Inserting Table: bronze.erp_loc_a101';    

    BULK INSERT bronze.erp_loc_a101
    FROM '/var/opt/mssql/datasets/source_erp/LOC_A101.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );

    SET @end_time = getdate();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'; 

    SET @start_time = getdate();
    PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2' ;

    truncate table bronze.erp_px_cat_g1v2;

    PRINT '>> Inserting Table: bronze.erp_px_cat_g1v2';  

    BULK INSERT bronze.erp_px_cat_g1v2
    FROM '/var/opt/mssql/datasets/source_erp/PX_CAT_G1V2.csv'
    WITH (
        FIRSTROW = 2,
        FIELDTERMINATOR = ',',
        TABLOCK
    );
    SET @end_time = getdate();
    PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'; 

    SET @batch_end_time = GETDATE()
    PRINT '====================================='
    PRINT 'Loading Bronze Layer is Completed' ;
    PRINT ' Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds'; 
    PRINT '====================================='

    END TRY
    BEGIN CATCH
        
        PRINT '============================='
        PRINT 'ERROR OCCURED DURING LOADIGN BRONZE LAYER'
        PRINT 'Error Message' + ERROR_MESSAGE();
        PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
        PRINT '============================='
    END CATCH

end;


exec bronze.load_bronze;
