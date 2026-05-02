{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module Etna.Gens.SmallCheck where

import qualified Test.SmallCheck.Series as SC
import Data.Time.Calendar.Quarter.Compat (QuarterOfYear(..))

import Etna.Properties (QoyArgs(..))

series_quarter_of_year_case_insensitive :: Monad m => SC.Series m QoyArgs
series_quarter_of_year_case_insensitive = do
  q <- SC.generate (\_ -> [Q1, Q2, Q3, Q4])
  upper <- SC.generate (\_ -> [True, False])
  pure (QoyArgs q upper)
