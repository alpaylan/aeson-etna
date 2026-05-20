module Etna.Gens.Hedgehog where

import           Hedgehog (Gen)
import qualified Hedgehog.Gen as Gen
import Data.Time.Calendar.Quarter.Compat (QuarterOfYear(..))

import Etna.Properties (QoyArgs(..))

-- | Library-faithful generator: the canonical text form emitted by
-- @buildQuarterOfYear@ is lowercase @qN@, so we sample that the vast
-- majority of the time and reserve a small frequency for the
-- uppercase @QN@ alias the parser is contracted to accept. The
-- 'QuarterOfYear' value is sampled uniformly across @{Q1..Q4}@.
gen_quarter_of_year_case_insensitive :: Gen QoyArgs
gen_quarter_of_year_case_insensitive = do
  q <- Gen.element [Q1, Q2, Q3, Q4]
  upper <- Gen.frequency
             [ (15, pure False)  -- canonical lowercase 'q' form
             , ( 1, pure True)   -- rare uppercase 'Q' alias
             ]
  pure (QoyArgs q upper)
