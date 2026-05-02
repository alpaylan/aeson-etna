module Etna.Witnesses where

import Data.Time.Calendar.Quarter.Compat (QuarterOfYear(..))

import Etna.Properties
import Etna.Result

witness_quarter_of_year_case_insensitive_case_upper_q4 :: PropertyResult
witness_quarter_of_year_case_insensitive_case_upper_q4 =
  property_quarter_of_year_case_insensitive (QoyArgs Q4 True)

witness_quarter_of_year_case_insensitive_case_upper_q1 :: PropertyResult
witness_quarter_of_year_case_insensitive_case_upper_q1 =
  property_quarter_of_year_case_insensitive (QoyArgs Q1 True)
