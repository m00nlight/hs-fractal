# Haskell fractal modeling package

This is a haskell library for [fractal](http://en.wikipedia.org/wiki/fractal)
modeling. 

## Install

TODO

## Usage


### Estimate of hurst exponent 

```haskell
GHCi, version 7.6.3: http://www.haskell.org/ghc/  :? for help
Loading package ghc-prim ... linking ... done.
Loading package integer-gmp ... linking ... done.
Loading package base ... linking ... done.
Prelude> :l Math/Haskell/Fractal/HurstExponent.hs
[1 of 3] Compiling Math.Haskell.Fractal.Utils ( Math/Haskell/Fractal/Utils.hs, interpreted )
[2 of 3] Compiling Math.Haskell.Fractal.LinearRegression ( Math/Haskell/Fractal/LinearRegression.hs, interpreted )
[3 of 3] Compiling Math.Haskell.Fractal.HurstExponent ( Math/Haskell/Fractal/HurstExponent.hs, interpreted )
Ok, modules loaded: Math.Haskell.Fractal.HurstExponent, Math.Haskell.Fractal.LinearRegression, Math.Haskell.Fractal.Utils.
*Math.Haskell.Fractal.HurstExponent> hurst
hurstExponent  hurstR         hurstRS        hurstS
*Math.Haskell.Fractal.HurstExponent> hurstExponent [1..1024]
Loading package split-0.2.2 ... linking ... done.
Loading package base-unicode-symbols-0.2.2.4 ... linking ... done.
0.9988591483483 ± 2.7370006799661586e-6
```

The return value is the hurst exponent estimation with 95% confident interval.
In this example is 0.9988591483483 ± 2.7370006799661586e-6.


## License
This software is distributed under the BSD3 license.See the LICENSE file
for more details.
