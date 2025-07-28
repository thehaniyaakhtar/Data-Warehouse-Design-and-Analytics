SELECT 
	TABLE_SCHEMA,
    TABLE_NAME,
    TABLE_TYPE
FROM
	information_schema.TABLES
WHERE
	TABLE_SCHEMA = 'datawarehouseanalytics'
;

SELECT 
	COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    CHARACTER_MAXIMUM_LENGTH
FROM
	information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'datawarehouseanalytics'
AND TABLE_NAME = 'gold_dim_customers'
;
