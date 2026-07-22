# Methodology and Assumptions

## Scope

- 1,800 synthetic completed work orders
- Completion period: January 2025 through June 2026
- 15 synthetic clients
- 36 synthetic employees
- Three synthetic operational departments
- Five insurance operations service lines

## Service Lines

- Certificate Issuance
- Policy Checking
- Document Retrieval
- Direct Bill Posting
- Policy Administration

## Metric Rules

### Average Handle Time

```text
AHT Minutes = SUM(BillableHours) / SUM(ProductionCount) × 60
```

The aggregate formula uses total hours and total production rather than averaging row-level AHT values.

### Turnaround Time

```text
TAT Hours = CompletedDate - ReceivedDate
```

TAT represents elapsed clock hours. Weekends and holidays are not removed in this portfolio version.

### SLA Performance

A work order is classified as `Met` when its elapsed TAT is less than or equal to its assigned SLA target. Targets vary by service line and priority.

### Quality and Rework

Quality scores and rework flags are synthetic scenario variables created to support exception analysis. They do not represent a real quality-assurance program.

## Data-Generation Notes

- Random generation is deterministic so the same project version produces consistent results.
- IDs are anonymous and do not map to real organizations or individuals.
- Work volumes, AHT, TAT, quality, and SLA values were generated within reasonable demonstration ranges.
- The dataset is intended for portfolio learning, SQL practice, dashboard development, and interview discussion.

## Limitations

- The project does not model weekends, holidays, employee schedules, or time zones.
- Service-level production units are simplified into a common count field.
- Correlations in the synthetic data should not be interpreted as real operational causation.

