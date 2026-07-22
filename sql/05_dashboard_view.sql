CREATE OR ALTER VIEW dbo.vw_InsuranceOperationsDashboard
AS
SELECT
    WorkOrderID,
    ReceivedDate,
    CompletedDate,
    DATEFROMPARTS(YEAR(CompletedDate), MONTH(CompletedDate), 1) AS CompletionMonth,
    ClientID,
    ServiceLine,
    Department,
    EmployeeID,
    Priority,
    ProductionCount,
    BillableHours,
    QualityScore,
    ReworkFlag,
    SLATargetHours,
    CAST(BillableHours / NULLIF(ProductionCount, 0) * 60.0 AS decimal(12,2)) AS AHTMinutes,
    CAST(DATEDIFF(MINUTE, ReceivedDate, CompletedDate) / 60.0 AS decimal(12,2)) AS TATHours,
    CASE
        WHEN DATEDIFF(MINUTE, ReceivedDate, CompletedDate) / 60.0 <= SLATargetHours THEN 'Met'
        ELSE 'Not Met'
    END AS SLAMet
FROM dbo.InsuranceOperations;
GO

SELECT TOP (100) *
FROM dbo.vw_InsuranceOperationsDashboard
ORDER BY CompletedDate DESC;
GO
