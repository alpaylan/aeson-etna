{-# LANGUAGE OverloadedStrings #-}

module Etna.Properties where

import qualified Data.Text as T
import Data.Time.Calendar.Quarter.Compat (QuarterOfYear(..))
import Data.Time.FromText (parseQuarterOfYear)

import Etna.Result

------------------------------------------------------------------------------
-- Variant 1: parse_qoy_lowercase_only_f625f493_1
-- Historical bug: FromJSON QuarterOfYear had a typo (`"e4 "` instead of
-- `"q4"`) that rejected valid Q4 values. The modern `parseQuarterOfYear`
-- in text-iso8601 accepts both `Q1..Q4` and `q1..q4`. The injected bug
-- drops the `'Q' == c ||` clause, so uppercase forms are rejected.
------------------------------------------------------------------------------

-- | A quarter and a case (upper or lower). The property: the parser
-- accepts both forms.
data QoyArgs = QoyArgs
  { qoyValue :: !QuarterOfYear
  , qoyUpper :: !Bool
  } deriving (Show, Eq)

-- | Property: parsing the canonical text form of a 'QuarterOfYear' (in
-- either case) yields back the original value. RFC 3339 / ISO 8601
-- quarters are written as @Qn@ or @qn@; the parser must accept both.
property_quarter_of_year_case_insensitive :: QoyArgs -> PropertyResult
property_quarter_of_year_case_insensitive (QoyArgs q upper) =
  let prefix = if upper then 'Q' else 'q'
      digit = case q of
        Q1 -> '1'
        Q2 -> '2'
        Q3 -> '3'
        Q4 -> '4'
      input = T.pack [prefix, digit]
  in case parseQuarterOfYear input of
       Right q' | q' == q -> Pass
       Right q' -> Fail $
         "parseQuarterOfYear " ++ show input ++ " = Right " ++ show q' ++
         "; expected Right " ++ show q
       Left e -> Fail $
         "parseQuarterOfYear " ++ show input ++ " = Left " ++ show e ++
         "; expected Right " ++ show q
