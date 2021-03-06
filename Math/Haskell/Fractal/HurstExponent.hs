{-# LANGUAGE UnicodeSyntax #-}

{-|
  Module        : Math.Haskell.Fractal.HurstExponent
  Description   : Calculate Hurst Exponent of timer series data
  Copyright     : (c) m00nlight, 2014-2015
  License       : BSD3
  Stability     : experimental

This exponent calculate the Hurst Exponent of time series data using
the <http://en.wikipedia.org/wiki/Rescaled_range Rescale_Range> methods.

Briefly speaking, the function will calculate the R/S score of the time
series data with different chunck size, and using linear regression to
calculate the slope in log-log coordinates of the R/S average value and
chunk size. The series data had better be of length of exponent of 2,
but it does not need to satisfy.

More details of how to calculate the Hurst Exponent, please see the
<http://en.wikipedia.org/wiki/Hurst_exponent wikipedia> page .
 -}

module Math.Haskell.Fractal.HurstExponent
    (hurstExponent) where

import Math.Haskell.Fractal.LinearRegression
import Math.Haskell.Fractal.Utils
import Data.List
import Prelude.Unicode
import Data.List.Split


-- | The function 'hurstR' calculate the R value of a series data
hurstR ∷ (Fractional a, Ord a) ⇒ [a] → a
hurstR xs = maximum zs - minimum zs
    where μ  = average xs
          ys = map (\ x → x - μ) xs
          zs = accumulateList ys

-- | The function 'hurstS' calculate the S value of a series data
hurstS = sd

-- | The function 'hurstRS' calculate the R/S value of a seris data
hurstRS ∷ [Double] → Double
hurstRS xs = if s ≡ 0.0 then 1.0 else r / s
    where r = hurstR xs
          s = hurstS xs

{-|
  The 'hurstExponent' function is used to estimate the
  <http://en.wikipedia.org/wiki/Hurst_exponent Hurst_Expoennt> of a
  time series data (v₁, v₂, ..., vₙ). n had better be exponent of 2.
  If n is not the exponent of 2, we will take as many elements as
  possible from the tail of the list to form an list of length of 2^m.
  The value  can be late used to calculate the fractal dimension of
  the time series data.
-}
hurstExponent ∷ [Double] → Result
hurstExponent vs = snd res
    where
      len = length vs
      n = last $ takeWhile (<len) [2^i | i ← [1..]]
      vs' = drop (len - n) vs
      chunkSizes = nestWhile (>4) (\ x → x `div` 2) n
      help ∷ [Double] → Int → (Double, Double)
      help vs size = (log (average $ map hurstRS (chunksOf size vs)) / log 2.0,
                      log (fromIntegral size) / log 2.0)
      tmp = map (\ x → help vs' x) chunkSizes
      res = linearRegression (map snd tmp) (map fst tmp)
