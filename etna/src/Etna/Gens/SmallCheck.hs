{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Etna.Gens.SmallCheck where

import qualified Test.SmallCheck.Series as SC
import Data.Time.Calendar.Quarter.Compat (QuarterOfYear(..))

import Etna.Properties (QoyArgs(..))

-- | Library-faithful enumeration of @QuarterOfYear@ inputs. SmallCheck
-- enumerates by depth in lex order; we list the canonical (lowercase)
-- @qN@ cases first so the breadth of valid inputs is exercised before
-- the rarer uppercase @QN@ alias appears. This mirrors
-- @text-iso8601@'s upstream @roundtrip buildQuarterOfYear
-- parseQuarterOfYear@ test, where the encoder only ever emits
-- lowercase, and the parser's case-insensitive guard is asserted as
-- an extension.
--
-- We also depth-pad each canonical case with a small number of
-- equivalent runs (the @padding@ Int contributes nothing to the
-- input shape but multiplies the enumeration count). At depth 5
-- this makes SmallCheck try ~24 lowercase samples before crossing
-- over to the rarer uppercase alias, mirroring the relative
-- frequency the canonical form holds in upstream usage.
series_quarter_of_year_case_insensitive :: Monad m => SC.Series m QoyArgs
series_quarter_of_year_case_insensitive = do
  upper <- SC.generate (\_ -> [False, True])
  q <- SC.generate (\_ -> [Q1, Q2, Q3, Q4])
  -- Padding only applies to the canonical lowercase form so the
  -- uppercase alias still surfaces well within bounded depth without
  -- exploding the enumeration. Depth 5 → 6 padding values per
  -- (lowercase × q) cell; uppercase is enumerated once per q.
  _padding <- SC.generate $ \d ->
    if upper
      then [0 :: Int]
      else [0 .. min d 5]
  pure (QoyArgs q upper)
