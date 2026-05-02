module Etna.Gens.Hedgehog where

import           Hedgehog (Gen)
import qualified Hedgehog.Gen as Gen
import Data.Time.Calendar.Quarter.Compat (QuarterOfYear(..))

import Etna.Properties (QoyArgs(..))

gen_quarter_of_year_case_insensitive :: Gen QoyArgs
gen_quarter_of_year_case_insensitive = do
  q <- Gen.element [Q1, Q2, Q3, Q4]
  upper <- Gen.bool
  pure (QoyArgs q upper)
