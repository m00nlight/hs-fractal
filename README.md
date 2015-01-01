# Haskell fractal modeling package

This is a haskell library for [fractal](http://en.wikipedia.org/wiki/fractal)
modeling. 

## Install

TODO

## Usage


### Estimate of hurst exponent

Under the *resources* directory, there are several test time series datas.

For example, the following is an example to estimate the Hurst Exponent of
day return and five days return of America S&P 500 index in the ghci repl.


```haskell
Prelude> :l Math/Haskell/Fractal/
HurstExponent.hs      HurstExponent.hs~     LinearRegression.hs
Utils.hs              Utils.hs~             LinearRegression.hs~
Prelude> :l Math/Haskell/Fractal/HurstExponent.hs
...
*Math.Haskell.Fractal.HurstExponent> a <- readFile "resources/en-stock-series-by-day.txt" 
*Math.Haskell.Fractal.HurstExponent> let b = map (\x -> read x :: Double) (splitOn "\n" a)
Loading package split-0.2.2 ... linking ... done.
*Math.Haskell.Fractal.HurstExponent> hurstExponent b
Loading package base-unicode-symbols-0.2.2.4 ... linking ... done.
0.505542130763361 ± 3.389969928369392e-3
*Math.Haskell.Fractal.HurstExponent> c <- readFile "resources/en-stock-series-by-week.txt" 
*Math.Haskell.Fractal.HurstExponent> let d = map (\ x -> read x :: Double) (splitOn "\n" c)
*Math.Haskell.Fractal.HurstExponent> hurstExponent d
0.5937906151301361 ± 4.2617283110814586e-3
```

The return value is the Hurst Exponent value with its 95% confident intervals.
Hurst Exponent value 0.5 means the data is no long term dependence, which means
previous data will not affect later data. 

We can see from the above example, that every day's return rate is no long
term dependence, while 5 day's compound return rate is a long memory process.


## License
This software is distributed under the BSD3 license.See the LICENSE file
for more details.
