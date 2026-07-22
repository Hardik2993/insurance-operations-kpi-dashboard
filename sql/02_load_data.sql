/*
    Update the file path below before running this script.
    SQL Server must be able to access the selected path.
*/

TRUNCATE TABLE dbo.InsuranceOperations;
GO

BULK INSERT dbo.InsuranceOperations
FROM 'C:\replace-with-your-path\insurance_operations_synthetic.csv'
WITH
(
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK,
    CODEPAGE = '65001'
);
GO

SELECT
    COUNT(*) AS LoadedRows,
    MIN(CompletedDate) AS FirstCompletedDate,
    MAX(CompletedDate) AS LastCompletedDate
FROM dbo.InsuranceOperations;
GO

