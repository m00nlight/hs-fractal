{-# LANGUAGE UnicodeSyntax #-}

module Math.Haskell.Fractal.LinearRegression where

import Math.Haskell.Fractal.Utils
import Data.List
import Prelude.Unicode

data Result = Result { val ∷ Double     -- ^ the estimate value
                     , moe ∷ Double     -- ^ margin of error of 95% confident
                     }

instance Show Result where
    show (Result {val = v, moe = m}) = (show v) ++ " ± " ++ (show m)

{-|
  The 'linearRegression' function calculate the linear regression coefficient
  of the sample (x₁, x₂, ..., xₙ) and (y₁, y₂, ..., yₙ).
  The linear regression result is y = β₀ + β₁ * x. The function will return
  the coefficient of β₀ and β₁ with 95% confidence intervals.
-}
linearRegression ∷ [Double] → [Double] → (Result, Result)
linearRegression xs ys = (Result {val = β₀, moe = 1.96 ⋅ σ₀},
                          Result {val = β₁, moe = 1.96 ⋅ σ₁} )
    where α = average xs
          β = average ys
          θ = average $ zipWith (*) xs ys
          γ = average $ zipWith (*) xs xs
          n = (fromIntegral (length xs))
          β₁ = ((θ ⋅ n - α ⋅ β ⋅ n) /
               (γ ⋅ n - α ⋅ α ⋅ n))
          β₀ = β - β₁ ⋅ α
          sse = foldl' (\ acc x → acc + x ⋅ x) 0.0
                (zipWith (-) (map (\ x → β₀ + β₁ ⋅ x) xs) ys)
          tmp = foldl' (\ acc x → acc + x ⋅ x) 0.0 (map (\ x → x - α) xs)
          σ = sse / (n - 2)
          σ₀ = σ ⋅ sqrt(1.0/ n + (α ⋅ α) / tmp)
          σ₁ = σ ⋅ sqrt(1.0 / tmp)
