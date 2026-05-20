module Etna.Gens.Falsify where

import           Data.List.NonEmpty (NonEmpty(..))
import qualified Test.Falsify.Generator as F
import Data.Time.Calendar.Quarter.Compat (QuarterOfYear(..))

import Etna.Properties (QoyArgs(..))

-- | Library-faithful generator: the canonical text form emitted by
-- @buildQuarterOfYear@ is lowercase @qN@, so we sample that the vast
-- majority of the time and reserve a small frequency for the
-- uppercase @QN@ alias the parser is contracted to accept. The
-- 'QuarterOfYear' value is sampled uniformly across @{Q1..Q4}@.
gen_quarter_of_year_case_insensitive :: F.Gen QoyArgs
gen_quarter_of_year_case_insensitive = do
  q <- F.elem (Q1 :| [Q2, Q3, Q4])
  upper <- F.frequency
             [ (15, pure False)  -- canonical lowercase 'q' form
             , ( 1, pure True)   -- rare uppercase 'Q' alias
             ]
  pure (QoyArgs q upper)
