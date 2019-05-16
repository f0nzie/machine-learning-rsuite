
<!-- README.md is generated from README.Rmd. Please edit that file -->

# machine-learning-rsuite

<!-- badges: start -->

<!-- badges: end -->

The goal of `machine-learning-rsuite` is:

1.  Providing a compilation of interesting machine learning applications
    that I found in the web. They will be usually be self-explanatory,
    practical and straight to the point.

2.  A demonstration of the use of the R package `rsuite` in complex
    projects.

3.  Providing four different levels of machine learning packages while
    building a book using `bookdown`.

4.  The four package levels that come included with this project are:

<!-- end list -->

  - `ml.core`
  - `ml.ahead`
  - `ml.pro`
  - `ml.advanced`

You will see that each of them contains packages applicable to a given
level of expertise in machine learning. Take a look at the `DESCRIPTION`
file to find out what packages correspond to each level. For instance,
we will find `stan` related packages for Bayesian statistics in the
package `ml.advanced`, or `h2o` associated packages under the `ml.pro`
package.

The nice thing about `rsuite` is that allow us to add lots of complexity
to a project and at the same time making it simpler to develop and
maintain. Additionally, it freezes your project in time by isolating the
packages that we used druing development. This totally prevents common
issues with automatic updates that have conflict with other packages. In
other words, your R application will always work.
