/*
    Project: Insurance Operations KPI Dashboard
    Purpose: Create the destination table for the synthetic portfolio dataset.
*/

DROP TABLE IF EXISTS dbo.InsuranceOperations;
GO

CREATE TABLE dbo.InsuranceOperations
(
    WorkOrderID       varchar(20)   NOT NULL,
    ReceivedDate      datetime2(0)  NOT NULL,
    CompletedDate     datetime2(0)  NOT NULL,
    ClientID          varchar(10)   NOT NULL,
    ServiceLine       varchar(100)  NOT NULL,
    Department        varchar(100)  NOT NULL,
    EmployeeID        varchar(10)   NOT NULL,
    Priority          varchar(20)   NOT NULL,
    ProductionCount   int           NOT NULL,
    BillableHours     decimal(12,2) NOT NULL,
    QualityScore      decimal(5,1)  NOT NULL,
    ReworkFlag        varchar(3)    NOT NULL,
    SLATargetHours    int           NOT NULL,
    AHTMinutes        decimal(12,2) NOT NULL,
    TATHours          decimal(12,2) NOT NULL,
    SLAMet            varchar(10)   NOT NULL,
    CompletionMonth   char(7)       NOT NULL,
    CONSTRAINT PK_InsuranceOperations PRIMARY KEY (WorkOrderID),
    CONSTRAINT CK_InsuranceOperations_Priority
        CHECK (Priority IN ('Standard', 'Rush')),
    CONSTRAINT CK_InsuranceOperations_ReworkFlag
        CHECK (ReworkFlag IN ('Yes', 'No')),
    CONSTRAINT CK_InsuranceOperations_SLAMet
        CHECK (SLAMet IN ('Met', 'Not Met')),
    CONSTRAINT CK_InsuranceOperations_Counts
        CHECK (ProductionCount > 0 AND BillableHours >= 0)
);
GO

CREATE INDEX IX_InsuranceOperations_CompletedDate
    ON dbo.InsuranceOperations (CompletedDate);

CREATE INDEX IX_InsuranceOperations_ServiceLine
    ON dbo.InsuranceOperations (ServiceLine, CompletedDate);
GO

