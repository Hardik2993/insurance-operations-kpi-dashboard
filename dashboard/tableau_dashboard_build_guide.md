# Tableau Dashboard Build Guide

## Recommended Dashboard Size

- Fixed size: 1,400 × 850 pixels
- Layout: tiled containers
- Primary colors: navy `#153A5B`, blue `#2F6B8A`, light blue `#E8F1F8`
- Exception color: red `#C43D3D`
- Success color: green `#2E7D32`

## Filters

Place the following filters in a horizontal panel at the top:

- Completion Month
- Client ID
- Service Line
- Department
- Priority

Apply each filter to all worksheets using the related data source.

## Calculated Fields

### Work Orders

```text
COUNTD([WorkOrderID])
```

### Production

```text
SUM([ProductionCount])
```

### Billable Hours

```text
SUM([BillableHours])
```

### AHT Minutes

```text
SUM([BillableHours]) / SUM([ProductionCount]) * 60
```

### Average TAT Hours

```text
AVG([TATHours])
```

### SLA Met Percentage

```text
SUM(IIF([SLAMet] = "Met", 1, 0)) / COUNTD([WorkOrderID])
```

### Rework Rate

```text
SUM(IIF([ReworkFlag] = "Yes", 1, 0)) / COUNTD([WorkOrderID])
```

## Dashboard Worksheets

1. **KPI Cards** – Work Orders, Production, Billable Hours, AHT, TAT, SLA Met %, Quality, and Rework Rate.
2. **Monthly SLA Trend** – Line chart using Completion Month and SLA Met Percentage.
3. **Production by Service Line** – Horizontal bar chart sorted descending.
4. **AHT by Service Line** – Horizontal bar chart with an overall AHT reference line.
5. **Client Performance** – Highlight table containing Work Orders, Production, AHT, TAT, and SLA Met %.
6. **Quality and Rework** – Scatter plot or compact service-line table comparing Quality Score and Rework Rate.

## Formatting Guidance

- Use whole numbers for work orders and production.
- Display billable hours, AHT, and TAT with one or two decimals.
- Display SLA and rework as percentages with one decimal.
- Use red only for SLA or quality exceptions.
- Keep tooltips short and include definitions for AHT, TAT, and SLA.
- Add the note: `Portfolio project using synthetic data` beneath the dashboard title.

## Export for GitHub

After completing the Tableau dashboard:

1. Export the full dashboard as PNG.
2. Save it as `dashboard/insurance_operations_dashboard.png`.
3. Do not upload a `.twbx` containing an extract.
4. If sharing a Tableau workbook, save a `.twb` file connected to the public CSV and verify that it contains no credentials or local confidential paths.

