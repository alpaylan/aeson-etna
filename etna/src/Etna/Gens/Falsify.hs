module Etna.Gens.Falsify where

import           Data.List.NonEmpty (NonEmpty(..))
import qualified Test.Falsify.Generator as F
import Data.Time.Calendar.Quarter.Compat (QuarterOfYear(..))

import Etna.Properties (QoyArgs(..))

gen_quarter_of_year_case_insensitive :: F.Gen QoyArgs
gen_quarter_of_year_case_insensitive = do
  q <- F.elem (Q1 :| [Q2, Q3, Q4])
  upper <- F.bool True
  pure (QoyArgs q upper)
