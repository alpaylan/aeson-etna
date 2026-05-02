module Etna.Gens.QuickCheck where

import qualified Test.QuickCheck as QC
import Data.Time.Calendar.Quarter.Compat (QuarterOfYear(..))

import Etna.Properties (QoyArgs(..))

gen_quarter_of_year_case_insensitive :: QC.Gen QoyArgs
gen_quarter_of_year_case_insensitive = do
  q <- QC.elements [Q1, Q2, Q3, Q4]
  upper <- QC.arbitrary
  pure (QoyArgs q upper)
