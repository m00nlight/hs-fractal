{-# LANGUAGE UnicodeSyntax #-}

module Math.Haskell.Fractal.HurstExponent where

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
  time series data (v₁, v₂, ..., vₙ). n should be exponent of 2.
  The value  can be late used to calculate the fractal dimension of
  the time series data.
-}
hurstExponent ∷ [Double] → Result
hurstExponent vs = snd res
    where
      n = length vs
      chunkSizes = nestWhile (>4) (\ x → x `div` 2) n
      help ∷ [Double] → Int → (Double, Double)
      help vs size = (log (average $ map hurstRS (chunksOf size vs)) / log 2.0,
                      log (fromIntegral size) / log 2.0)
      tmp = map (\ x → help vs x) chunkSizes
      res = linearRegression (map snd tmp) (map fst tmp)
