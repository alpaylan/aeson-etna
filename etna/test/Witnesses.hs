module Main where

import Etna.Result (PropertyResult(..))
import Etna.Witnesses
  ( witness_quarter_of_year_case_insensitive_case_upper_q4
  , witness_quarter_of_year_case_insensitive_case_upper_q1
  )
import System.Exit (exitFailure, exitSuccess)

cases :: [(String, PropertyResult)]
cases =
  [ ("witness_quarter_of_year_case_insensitive_case_upper_q4",
       witness_quarter_of_year_case_insensitive_case_upper_q4)
  , ("witness_quarter_of_year_case_insensitive_case_upper_q1",
       witness_quarter_of_year_case_insensitive_case_upper_q1)
  ]

main :: IO ()
main = do
  let failures =
        [ (n, msg) | (n, Fail msg) <- cases ] ++
        [ (n, "discard") | (n, Discard) <- cases ]
  if null failures
    then do
      putStrLn $ "OK: all " ++ show (length cases) ++ " witnesses passed"
      exitSuccess
    else do
      mapM_ (\(n, m) -> putStrLn (n ++ ": FAIL: " ++ m)) failures
      exitFailure
