DECLARE @StartDate   date         = '2025-01-01';
DECLARE @EndDate     date         = '2026-06-30';
DECLARE @ClientID    varchar(10)  = '';
DECLARE @ServiceLine varchar(100) = '';
DECLARE @Department  varchar(100) = '';
DECLARE @Priority    varchar(20)  = '';

;WITH FilteredData AS
(
    SELECT *
    FROM dbo.InsuranceOperations
    WHERE CompletedDate >= @StartDate
      AND CompletedDate < DATEADD(DAY, 1, @EndDate)
      AND (@ClientID = '' OR ClientID = @ClientID)
      AND (@ServiceLine = '' OR ServiceLine = @ServiceLine)
      AND (@Department = '' OR Department = @Department)
      AND (@Priority = '' OR Priority = @Priority)
)
/* Overall KPIs */
SELECT
    COUNT(DISTINCT WorkOrderID) AS WorkOrders,
    SUM(ProductionCount) AS Production,
    CAST(SUM(BillableHours) AS decimal(14,2)) AS BillableHours,
    CAST(SUM(BillableHours) / NULLIF(SUM(ProductionCount), 0) * 60.0 AS decimal(12,2)) AS AHTMinutes,
    CAST(AVG(TATHours) AS decimal(12,2)) AS AverageTATHours,
    CAST(AVG(CASE WHEN SLAMet = 'Met' THEN 1.0 ELSE 0.0 END) * 100.0 AS decimal(6,2)) AS SLAMetPercent,
    CAST(AVG(QualityScore) AS decimal(5,2)) AS AverageQualityScore,
    CAST(AVG(CASE WHEN ReworkFlag = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 AS decimal(6,2)) AS ReworkPercent
FROM FilteredData;

;WITH FilteredData AS
(
    SELECT *
    FROM dbo.InsuranceOperations
    WHERE CompletedDate >= @StartDate
      AND CompletedDate < DATEADD(DAY, 1, @EndDate)
      AND (@ClientID = '' OR ClientID = @ClientID)
      AND (@ServiceLine = '' OR ServiceLine = @ServiceLine)
      AND (@Department = '' OR Department = @Department)
      AND (@Priority = '' OR Priority = @Priority)
)
/* Monthly trend */
SELECT
    DATEFROMPARTS(YEAR(CompletedDate), MONTH(CompletedDate), 1) AS CompletionMonth,
    COUNT(DISTINCT WorkOrderID) AS WorkOrders,
    SUM(ProductionCount) AS Production,
    CAST(SUM(BillableHours) / NULLIF(SUM(ProductionCount), 0) * 60.0 AS decimal(12,2)) AS AHTMinutes,
    CAST(AVG(TATHours) AS decimal(12,2)) AS AverageTATHours,
    CAST(AVG(CASE WHEN SLAMet = 'Met' THEN 1.0 ELSE 0.0 END) * 100.0 AS decimal(6,2)) AS SLAMetPercent
FROM FilteredData
GROUP BY DATEFROMPARTS(YEAR(CompletedDate), MONTH(CompletedDate), 1)
ORDER BY CompletionMonth;

;WITH FilteredData AS
(
    SELECT *
    FROM dbo.InsuranceOperations
    WHERE CompletedDate >= @StartDate
      AND CompletedDate < DATEADD(DAY, 1, @EndDate)
      AND (@ClientID = '' OR ClientID = @ClientID)
      AND (@ServiceLine = '' OR ServiceLine = @ServiceLine)
      AND (@Department = '' OR Department = @Department)
      AND (@Priority = '' OR Priority = @Priority)
)
/* Service-line comparison */
SELECT
    ServiceLine,
    COUNT(DISTINCT WorkOrderID) AS WorkOrders,
    SUM(ProductionCount) AS Production,
    CAST(SUM(BillableHours) / NULLIF(SUM(ProductionCount), 0) * 60.0 AS decimal(12,2)) AS AHTMinutes,
    CAST(AVG(TATHours) AS decimal(12,2)) AS AverageTATHours,
    CAST(AVG(CASE WHEN SLAMet = 'Met' THEN 1.0 ELSE 0.0 END) * 100.0 AS decimal(6,2)) AS SLAMetPercent,
    CAST(AVG(QualityScore) AS decimal(5,2)) AS AverageQualityScore,
    CAST(AVG(CASE WHEN ReworkFlag = 'Yes' THEN 1.0 ELSE 0.0 END) * 100.0 AS decimal(6,2)) AS ReworkPercent
FROM FilteredData
GROUP BY ServiceLine
ORDER BY Production DESC;

;WITH FilteredData AS
(
    SELECT *
    FROM dbo.InsuranceOperations
    WHERE CompletedDate >= @StartDate
      AND CompletedDate < DATEADD(DAY, 1, @EndDate)
      AND (@ClientID = '' OR ClientID = @ClientID)
      AND (@ServiceLine = '' OR ServiceLine = @ServiceLine)
      AND (@Department = '' OR Department = @Department)
      AND (@Priority = '' OR Priority = @Priority)
)
/* Client performance */
SELECT
    ClientID,
    COUNT(DISTINCT WorkOrderID) AS WorkOrders,
    SUM(ProductionCount) AS Production,
    CAST(SUM(BillableHours) / NULLIF(SUM(ProductionCount), 0) * 60.0 AS decimal(12,2)) AS AHTMinutes,
    CAST(AVG(TATHours) AS decimal(12,2)) AS AverageTATHours,
    CAST(AVG(CASE WHEN SLAMet = 'Met' THEN 1.0 ELSE 0.0 END) * 100.0 AS decimal(6,2)) AS SLAMetPercent
FROM FilteredData
GROUP BY ClientID
ORDER BY WorkOrders DESC, ClientID;

