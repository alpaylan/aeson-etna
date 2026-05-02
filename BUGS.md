# aeson — Injected Bugs

Fast JSON parsing and encoding (haskell/aeson). This workload narrows cabal.project to the text-iso8601 sub-package — that's where the QuarterOfYear bug lives. Bug fixes mined from upstream history; modern HEAD is the base, each patch reverse-applies a fix to install the original bug.

Total mutations: 1

## Bug Index

| # | Variant | Name | Location | Injection | Fix Commit |
|---|---------|------|----------|-----------|------------|
| 1 | `parse_qoy_lowercase_only_f625f493_1` | `parseQuarterOfYear_lowercase_only` | `text-iso8601/src/Data/Time/FromText.hs:365` | `patch` | `f625f493ba6ee1356f00e32baa2aa2ed772d858d` |

## Property Mapping

| Variant | Property | Witness(es) |
|---------|----------|-------------|
| `parse_qoy_lowercase_only_f625f493_1` | `QuarterOfYearCaseInsensitive` | `witness_quarter_of_year_case_insensitive_case_upper_q4`, `witness_quarter_of_year_case_insensitive_case_upper_q1` |

## Framework Coverage

| Property | quickcheck | hedgehog | falsify | smallcheck |
|----------|---------:|-------:|------:|---------:|
| `QuarterOfYearCaseInsensitive` | ✓ | ✓ | ✓ | ✓ |

## Bug Details

### 1. parseQuarterOfYear_lowercase_only

- **Variant**: `parse_qoy_lowercase_only_f625f493_1`
- **Location**: `text-iso8601/src/Data/Time/FromText.hs:365` (inside `parseQuarterOfYear_`)
- **Property**: `QuarterOfYearCaseInsensitive`
- **Witness(es)**:
  - `witness_quarter_of_year_case_insensitive_case_upper_q4` — parseQuarterOfYear "Q4" must equal Right Q4
  - `witness_quarter_of_year_case_insensitive_case_upper_q1` — parseQuarterOfYear "Q1" must equal Right Q1
- **Source**: internal — Fix bug in FromJSON QuarterOfYear instance
  > parseQuarterOfYear_ accepts both 'Q' and 'q' as the prefix character. The original aeson bug typo'd 'q4' as 'e4 ' rejecting all Q4 inputs; the modern text-iso8601 implementation uses a single guard `'Q' == c || 'q' == c`. The injected bug drops the `'Q' == c ||` clause so uppercase variants are rejected.
- **Fix commit**: `f625f493ba6ee1356f00e32baa2aa2ed772d858d` — Fix bug in FromJSON QuarterOfYear instance
- **Invariant violated**: parseQuarterOfYear accepts both `Qn` and `qn` for n in {1,2,3,4}, returning the corresponding QuarterOfYear value.
- **How the mutation triggers**: Reverse-applying the patch removes the `'Q' == c ||` clause from parseQuarterOfYear_'s guard. parseQuarterOfYear "Q1" then returns Left "Unexpected character ..." instead of Right Q1.
