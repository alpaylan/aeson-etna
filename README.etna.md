# aeson — ETNA workload

This is the [aeson](https://github.com/haskell/aeson) monorepo forked into
an ETNA workload. Aeson ships several sibling cabal packages
(`attoparsec-aeson`, `attoparsec-iso8601`, `text-iso8601`, the main aeson
package, `examples`, `benchmarks`); for this workload we narrow
`cabal.project` to just the `text-iso8601` sub-package plus our `etna/`
runner. That's where the historical QuarterOfYear bug lives, and it's
the fastest sub-package to build.

The upstream files are untouched; the workload-specific additions live in:

- `etna.toml` — manifest (single source of truth).
- `cabal.project` — narrowed to `text-iso8601/` + `etna/` (rest of aeson
  is intentionally not part of this workload's build closure).
- `patches/*.patch` — bug-injection patches. Reverse-applying any patch
  re-introduces the original bug.
- `etna/` — runner package (cabal). Defines `property_<snake>` functions,
  per-framework generators, witnesses, and the `etna-runner` CLI.
- `BUGS.md` / `TASKS.md` — generated. Regenerate with `etna workload doc .`.

## Why a monorepo workload

The historical aeson bug we mine (commit `f625f493`, "Fix bug in
FromJSON QuarterOfYear instance") was originally a typo (`"e4 "`
instead of `"q4"`) in `Data/Aeson/Types/FromJSON.hs`. After aeson 2.x's
refactor, the QuarterOfYear parser moved into the `text-iso8601`
sub-package as `parseQuarterOfYear_`. We synthesize a parallel bug
against modern HEAD: drop the `'Q' == c ||` clause so only lowercase
forms are accepted. Same user-visible failure (uppercase `Q4` rejected),
modern code structure.

## Frameworks

QuickCheck, Hedgehog, Falsify, SmallCheck — plus a witness-replay tool
`etna` for fidelity checks.

## Quickstart

```sh
ghcup install ghc 9.6.6   # falsify needs base >= 4.18
ghcup set ghc 9.6.6

cabal build etna-runner
cabal test etna-witnesses

# Base (fixed): all four backends pass.
for tool in quickcheck hedgehog falsify smallcheck; do
  cabal run -v0 etna-runner -- "$tool" QuarterOfYearCaseInsensitive
done

# Reverse-apply the patch (install the bug); all four detect it.
git apply -R --whitespace=nowarn patches/parse_qoy_lowercase_only_f625f493_1.patch
cabal run -v0 etna-runner -- quickcheck QuarterOfYearCaseInsensitive
git apply --whitespace=nowarn patches/parse_qoy_lowercase_only_f625f493_1.patch
```
