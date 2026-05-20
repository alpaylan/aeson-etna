module Etna.Gens.QuickCheck where

import qualified Test.QuickCheck as QC
import Data.Time.Calendar.Quarter.Compat (QuarterOfYear(..))

import Etna.Properties (QoyArgs(..))

-- | Library-faithful generator for the case-insensitive QoY parsing
-- property. Upstream's @text-iso8601@ test exercises this path via
-- @roundtrip (==) buildQuarterOfYear parseQuarterOfYear@; the encoder
-- (@buildQuarterOfYear@) emits only the canonical lowercase @qN@ form.
-- We follow that bias here: the canonical (lowercase) form is sampled
-- the vast majority of the time, with a small frequency reserved for
-- the rarer uppercase @QN@ alias that the parser must also accept.
--
-- The 'QuarterOfYear' value is sampled uniformly across @{Q1..Q4}@
-- mirroring the default 'Arbitrary' instance shipped by
-- @quickcheck-instances@.
gen_quarter_of_year_case_insensitive :: QC.Gen QoyArgs
gen_quarter_of_year_case_insensitive = do
  q <- QC.elements [Q1, Q2, Q3, Q4]
  upper <- QC.frequency
             [ (15, pure False)  -- canonical lowercase 'q' form
             , ( 1, pure True)   -- rare uppercase 'Q' alias
             ]
  pure (QoyArgs q upper)
