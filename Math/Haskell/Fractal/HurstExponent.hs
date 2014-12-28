{-# LANGUAGE UnicodeSyntax #-}

module Math.Haskell.Fractal.HurstExponent where

import Math.Haskell.Fractal.LinearRegression
import Math.Haskell.Fractal.Utils
import Data.List
import Prelude.Unicode
import Data.List.Split


{-|
  The 'hurstExponent' function is used to estimate the
  <http://en.wikipedia.org/wiki/Hurst_exponent Hurst_Expoennt> of a
  time series data (v₁, v₂, ..., vₙ). n should be exponent of 2.
  The value  can be late used to calculate the fractal dimension of
  the time series data.
-}
hurstExponent ∷ [Double] → Result
hurstExponent vs = fst res
    where
      n = length vs
      chunkSizes = nestWhile (>4) (\ x → x `div` 2) n
      help ∷ [Double] → Int → (Double, Double)
      help vs size = (average $ map average (chunksOf size vs),
                      (log (fromIntegral size)) / (log (exp 1)))
      tmp = map (\ x → help vs x) chunkSizes
      res = linearRegression (map fst tmp) (map snd tmp)
