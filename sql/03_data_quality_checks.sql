/* Row count and uniqueness */
SELECT
    COUNT(*) AS TotalRows,
    COUNT(DISTINCT WorkOrderID) AS DistinctWorkOrders,
    COUNT(*) - COUNT(DISTINCT WorkOrderID) AS DuplicateRows
FROM dbo.InsuranceOperations;

/* Critical null checks */
SELECT
    SUM(CASE WHEN WorkOrderID IS NULL THEN 1 ELSE 0 END) AS MissingWorkOrderID,
    SUM(CASE WHEN CompletedDate IS NULL THEN 1 ELSE 0 END) AS MissingCompletedDate,
    SUM(CASE WHEN ServiceLine IS NULL THEN 1 ELSE 0 END) AS MissingServiceLine,
    SUM(CASE WHEN ProductionCount IS NULL THEN 1 ELSE 0 END) AS MissingProduction,
    SUM(CASE WHEN BillableHours IS NULL THEN 1 ELSE 0 END) AS MissingBillableHours
FROM dbo.InsuranceOperations;

/* Invalid values */
SELECT *
FROM dbo.InsuranceOperations
WHERE CompletedDate < ReceivedDate
   OR ProductionCount <= 0
   OR BillableHours < 0
   OR QualityScore NOT BETWEEN 0 AND 100
   OR Priority NOT IN ('Standard', 'Rush')
   OR ReworkFlag NOT IN ('Yes', 'No')
   OR SLAMet NOT IN ('Met', 'Not Met');

/* Recalculate and compare the derived KPIs */
SELECT *
FROM dbo.InsuranceOperations
WHERE ABS(AHTMinutes - (BillableHours / NULLIF(ProductionCount, 0) * 60.0)) > 0.75
   OR ABS(TATHours - DATEDIFF(MINUTE, ReceivedDate, CompletedDate) / 60.0) > 0.05
   OR SLAMet <> CASE WHEN TATHours <= SLATargetHours THEN 'Met' ELSE 'Not Met' END;

