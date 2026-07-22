# Data Dictionary

The dataset contains one row per completed synthetic work order.

| Field | Type | Description |
|---|---|---|
| `WorkOrderID` | Text | Synthetic unique work-order identifier |
| `ReceivedDate` | Datetime | Date and time the work order entered operations |
| `CompletedDate` | Datetime | Date and time the work order was completed |
| `ClientID` | Text | Synthetic client identifier with no real-world mapping |
| `ServiceLine` | Text | Insurance operations service category |
| `Department` | Text | Synthetic operational department |
| `EmployeeID` | Text | Synthetic employee identifier with no real-world mapping |
| `Priority` | Text | Standard or Rush processing priority |
| `ProductionCount` | Integer | Number of completed transactions or units |
| `BillableHours` | Decimal | Synthetic billable hours associated with production |
| `QualityScore` | Decimal | Synthetic quality score on a 0–100 scale |
| `ReworkFlag` | Text | `Yes` when correction effort was required |
| `SLATargetHours` | Integer | Target elapsed hours based on service and priority |
| `AHTMinutes` | Decimal | Billable hours divided by production, multiplied by 60 |
| `TATHours` | Decimal | Elapsed hours from receipt to completion |
| `SLAMet` | Text | `Met` when TAT is less than or equal to the SLA target |
| `CompletionMonth` | Text | Completion month in `YYYY-MM` format |

