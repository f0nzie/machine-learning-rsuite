# Utilities

[TOC]

## BioConductor packages





## Compile book from prompt

```
rmarkdown::render_site(output_format = 'bookdown::pdf_book', encoding = 'UTF-8')
```



## Packages not in CRAN

* <https://github.com/vqv/ggbiplot>
* <https://github.com/cran/data.tree>



### Changing the path of data files and images in notebooks

```
emails_full <- get(load(file.path(data_raw_dir,"the_data.Rdata")))
```

```
load(file.path(data_raw_dir,"the_data.rda"))
```

```
knitr::include_graphics(file.path(assets_dir, "the_figure.png"))
```

```
# read CSV file as matrix
probs_t <- as.vector(as.matrix(read.csv(file.path(data_raw_dir, "the_data.csv"),
                                        header = F)))
```

```
# just read a CSV file
read.csv(file = file.path(data_raw_dir, "the_data.csv"))
```



## Knitr header

Your typical `knitr` header:

```R
​```{r setup, include=FALSE, error=TRUE, message=FALSE, warning=FALSE} 
knitr::opts_chunk$set(echo = TRUE, 
                      comment = "#>", 
                      error = TRUE, 
                      warning = FALSE, 
                      message = FALSE, 
                      fig.align = 'center'
                      )
​```
```





## Call to exclusive library path (rsuite)

To enable the use of dated libraries from MRAN, we have to indicate the new library path using a command to call the definitions by `rsuite`. Include the following chunk at the beginning of any notebook.

```
​```{r echo=FALSE}
# first line kind of optional; for me it will provide the project folders
load(file.path(rprojroot::find_rstudio_root_file(), "workspace.RData"))
# this line is key; it will point to the location of user packages
.libPaths(c(normalizePath(sbox_path), normalizePath(lib_path), .libPaths()))
​```
```



## `_output.yml` for multidocument

```
bookdown::gitbook:
  css: style.css
  config:
    toc:
      before: |
        <li><a href="./">A Minimal Book Example</a></li>
      after: |
        <li><a href="https://github.com/rstudio/bookdown" target="blank">Published with bookdown</a></li>
    download: ["pdf", "epub"]
bookdown::pdf_book:
  includes:
   in_header: preamble.tex
   latex_engine: xelatex
   citation_package: natbib
   keep_tex: yes
 bookdown::epub_book: default

```

## `_output.yml` for html

```
bookdown::gitbook:
  css: style.css
  config:
    toc:
      before: |
        <li><a href="./">A Minimal Book Example</a></li>
      after: |
        <li><a href="https://github.com/rstudio/bookdown" target="blank">Published with bookdown</a></li>
    download: ["pdf", "epub"]
```



## `_output.yml` for PDF

```
bookdown::pdf_book:
  includes:
    in_header: preamble.tex
  latex_engine: xelatex
  citation_package: natbib
  keep_tex: yes
```





## `_output.yml` for HTML and PDF

```
bookdown::gitbook:
  css: style.css
  config:
    toc:
      before: |
        <li><a href="./">A Minimal Book Example</a></li>
      after: |
        <li><a href="https://github.com/rstudio/bookdown" target="blank">Published with bookdown</a></li>
    download: ["pdf", "epub"]
bookdown::pdf_book:
  includes:
    in_header: preamble.tex
  latex_engine: xelatex
  citation_package: natbib
  keep_tex: yes
# bookdown::epub_book: default
```





## Bookdown and rsuite

Sometimes we could find a little trouble compiling notebooks using rsuite and the packages provided in user environment through the folder in `deployment`. No discard is not rsuite, it is better to test a demo bookdown sample first and see it compiles alright.

Just ensure that the `libPaths` is pointing to the right location of all packages. **This is essential.**

1. Start by creating a bookdown book at any folder under the project. Preferably, under `work`.
2. Test that the demo works
3. Remove most of the demo notebooks and replace them with your own.
4. Delete or rename the project `.Rproj` file. Otherwise, it will confuse `rsuite`
5. Change the default `yaml` file `_bookdown.yml` if needed. For instance, I added:

```
new_session: yes
```

to prevent collision of chunk labels.

6. Simplify the file `_output.yml` to generate one type of output. By default, it creates `html`, `pdf` and `ebook`, one after the other. I selected only to generate a `html` book.
7. Do not use notebooks as symbolic links. It will confuse `rmarkdown` or `bookdown`. It is better to make a dry run of the standalone notebooks in another folder, such as `RMD`, and then move the notebook to the `book` folder after it passed all the tests.
8. To reduce the time of bookdown compilation, only include the notebooks that require testing using the parameter `rmd_files`. When the book is in the final status you can enable all of the notebooks for compilation.



```
rmd_files: [
  "index.Rmd",

  # Algorithms comparison
  "classification_907-bad_loans-h2o.Rmd",
  "comparison_312-classification-diabetes-multi.Rmd",
  "comparison_320-classification_iris-multi.Rmd",
  "comparison_321-regression_boston-multi.Rmd",
  "comparison_322-classification_BreastCancer-mlbench-multi.Rmd",
  "comparison_330-classification_flu_outcome-multi-sglander.Rmd",

  # Classification
  "classification_109a-gentle_intro_to_SVM.Rmd",
  "classification_112-social_networks-SVM.Rmd",
  "classification_113-broad_view-SVM.Rmd",
  "classification_115-standalone_model-rf.Rmd",
  "classification_116-glass-svm.Rmd",
  "classification_117-ozone_nlr-svm.Rmd",
  "classification_118-gentle_intro_to_SVM.Rmd",
  "classification_225-sms_spam-tm-nb.Rmd",
  "classification_226-vehicle-mlbench-tree.Rmd",
  "classification_227-bike_sharing_demand-rf.Rmd",
  "classification_229-breast_cancer_ga-sglander.Rmd",
  "classification_252a-titanic-naives_bayes.Rmd",
  "classification_252b-iris-naive_bayes.Rmd",
  "meta_137-logistic_regression-diabetes.Rmd",

  # Feature Engineering
  "comparison_342-classification_employee_attrition-lime-multi.Rmd",
  "meta_131-dealing_with_unbalanced_data-sglander.Rmd",
  "meta_133-variable_importance.Rmd",
  "meta_230-missing_flu_prediction_micex5-sglander.Rmd",

  # Linear Regression
  "misc_906-visualizing_residuals.Rmd",
  "regression_114-nested_temperature.Rmd",
  "regression_136-happiness.Rmd",
  "regression_138-advertising.Rmd",
  "regression_141.1-3a-iris_dataset.Rmd",
  "regression_141.2-3b-rates_dataset.Rmd",
  "regression_921-nn_lm_vs_nn.Rmd",
  "regression-diamonds_nn.Rmd",

  # ML meta
  "meta_110a-PCA-prcomp_vs_princomp.Rmd",
  "meta_110b-PCA-Principal_Component_Methods_in_R.Rmd",
  "meta_110c-PCA-Phan_2016-Introduction_To_PCA_with_examples_in_R.Rmd",
  "misc_111b-what_is_dot_hat.Rmd",
  "misc_111c-comparing_distributions_with_qq_plot.Rmd",
  "misc_111d-qq_plots_pp_plots.Rmd",
  "misc_140-data_visualization-modeling.Rmd",


  # Neural Networks
  "classification_239b-deeplearning_h2o_arrhythmia-sglander.Rmd",
  "classification_900-credit_neuralnet.Rmd",
  "classification_904-wine_selection_nn.Rmd",
  "clssification-901-build_fully_connected_nn_from_scratch-nnet.Rmd",
  "comparison-classification_regression_with_h2o_deep_learning.Rmd",
  "meta_905-regression_-sensitivity_analysis_nn.Rmd",
  "regression_142-neural_network_yacht.Rmd",
  "regression_144-nn_cereals_neuralnet.Rmd",
  "regression_902-fitting_neural_network.Rmd",
  "regression_903-visualization_nn.Rmd"
]
```

