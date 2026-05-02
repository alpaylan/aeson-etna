# text-iso8601 — ETNA Tasks

Total tasks: 4

## Task Index

| Task | Variant | Framework | Property | Witness |
|------|---------|-----------|----------|---------|
| 001 | `parse_qoy_lowercase_only_f625f493_1` | quickcheck | `QuarterOfYearCaseInsensitive` | `witness_quarter_of_year_case_insensitive_case_upper_q4` |
| 002 | `parse_qoy_lowercase_only_f625f493_1` | hedgehog | `QuarterOfYearCaseInsensitive` | `witness_quarter_of_year_case_insensitive_case_upper_q4` |
| 003 | `parse_qoy_lowercase_only_f625f493_1` | falsify | `QuarterOfYearCaseInsensitive` | `witness_quarter_of_year_case_insensitive_case_upper_q4` |
| 004 | `parse_qoy_lowercase_only_f625f493_1` | smallcheck | `QuarterOfYearCaseInsensitive` | `witness_quarter_of_year_case_insensitive_case_upper_q4` |

## Witness Catalog

- `witness_quarter_of_year_case_insensitive_case_upper_q4` — parseQuarterOfYear "Q4" must equal Right Q4
- `witness_quarter_of_year_case_insensitive_case_upper_q1` — parseQuarterOfYear "Q1" must equal Right Q1
