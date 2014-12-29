{-# LANGUAGE UnicodeSyntax #-}

module Math.Haskell.Fractal.Utils where


-- |The 'average' calculate the average value of a list
average ∷ Fractional a ⇒ [a] → a
average [] = 0.0
average xs = (sum xs) / fromIntegral (length xs)

-- | The 'sd' function calculate the standard deviation of a list
sd ∷ Floating a ⇒ [a] → a
sd [] = 0.0
sd xs = sqrt $ average (map (\ x → (x - avg)^2) xs)
    where avg = average xs


-- |The 'nestWhile' generate a list from initial value and
-- some function to generate new value. until some condition
-- does not satisfy.
--
-- >>> nestWhile (>10) (\ x → x `div` 2) 64
-- [64, 32, 16]
nestWhile ∷ (a → Bool) → (a → a) → a → [a]
nestWhile p f val = nestWhile' p f val []
    where
      nestWhile' p f val acc =
          if not (p val)
          then reverse acc
          else nestWhile' p f (f val) (val : acc)


-- | 'accumulateList' accumulate the sum of a list
--
-- >>> accumulateList [1,2,3,5]
-- [1,3,6,11]
accumulateList xs = aux xs 0
    where aux [] a = []
          aux (x:xs) a = (a + x) : aux xs (a + x)
