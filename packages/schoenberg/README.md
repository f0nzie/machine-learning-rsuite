# schoenberg

The *schoenberg* package for R provides ggplot-based graphics and useful functions for GAMs fitted using the mgcv package.

[![Project Status: Abandoned – Initial development has started, but there has not yet been a stable, usable release; the project has been abandoned and the author(s) do not intend on continuing development.](http://www.repostatus.org/badges/latest/abandoned.svg)](http://www.repostatus.org/#abandoned)

I've abondonded this project, moving development to the [gratia](https://github.com/gavinsimpson/gratia) package because the name "schoenberg" has recently been taken by another package on CRAN. I'm leaving this repo up though as I know some people were using it in scripts, I was using it in a preprint of a GAM paper that is under review, and I have blog posts using it.

## Build status

[![Build Status](https://travis-ci.org/gavinsimpson/schoenberg.svg?branch=master)](https://travis-ci.org/gavinsimpson/schoenberg) [![Build status](https://ci.appveyor.com/api/projects/status/w7pj8773t5b8fxkb/branch/master?svg=true)](https://ci.appveyor.com/project/gavinsimpson/schoenberg/branch/master) [![codecov](https://codecov.io/gh/gavinsimpson/schoenberg/branch/master/graph/badge.svg)](https://codecov.io/gh/gavinsimpson/schoenberg)

## Features

The main features of *schoenberg* are currently

* A *ggplot2*-based replacement for `mgcv:::plot.gam()`: `draw(gam_model)`.

    Note specialist smoothers (`bs %in% c("re","fs","mrf","so")`) are not supported, but univariate, *factor* and *continuous* `by`-variable smooths, and bivariate tensor product smooths are supported,

* Estimatation of derivatives of fitted smoothers: `fderiv(gam_model)`,

* Estimation of point-wise across-the-function confidence intervals and simultaneous intervals for smooths: `confint(gam_model)`.

## Installing *schoenberg*

*schoenberg* is under active development and has not yet had its first release to CRAN. The easiest way to install the package is via the `install_github()` function from package *devtools*. Make sure you have *devtools* installed, then run

```r
devtools::install_github("gavinsimpson/schoenberg")
```

to install the package.

## History

*schoenberg* grew out of an earlier package, *tsgam*, which was originally intended to be used with GAMs fitted to time series. As I was developing *tsgam* however it became clear that the package could be used more generally and that the name "tsgam" was no longer appropriate. To avoid breaking blog posts I had written using *tsgam* I decided to copy the git repo and all the history to a new repo for the package under the name *schoenberg*.

## Why *schoenberg*?

In naming his [*greta*](https://github.com/greta-dev/greta) package, Nick Golding observed the recent phenomena of naming statistical modelling software, such as Stan or Edward, after individuals that played a prominent role in the development of the field. This lead Nick to name his Tensor Flow-based package *greta* after [*Grete Hermann*](https://greta-dev.github.io/greta/why_greta.html).

In the same spirit, *schoenberg* is named in recognition of the contributions of Grace Wahba, who did pioneering work on the penalised spline models that are at the foundation of the way GAMs are estimated in *mgcv*. I wanted to name the package *grace*, to more explicitly recognise Grace's contributions, but unfortunately there was already a package named *Grace* on CRAN. So I looked elsewhere for inspiration.

[Grace Wahba](https://en.wikipedia.org/wiki/Grace_Wahba) is the IJ Schoenberg-Hilldale Professor of Statistics at the University of Wisconsin-Madison, where she has worked since 1967. The chair is named after [Isaac J Schoenberg](https://en.wikipedia.org/wiki/Isaac_Jacob_Schoenberg), a former University Madison-Wisconsin Professor of Mathematics, who in a 1946 paper provided the first mathematical reference to "splines".

The name *schoenberg* links and recognises two pioneers in the field of splines.
