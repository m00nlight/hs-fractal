{-# LANGUAGE UnicodeSyntax #-}

module Math.Haskell.Fractal.Utils where


-- | average calculate the average value of an list
average ∷ Fractional a ⇒ [a] → a
average [] = 0.0
average xs = (sum xs) / fromIntegral (length xs)
