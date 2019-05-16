# Utilities



```
rmarkdown::render_site(output_format = 'bookdown::pdf_book', encoding = 'UTF-8')
```





## Packages

* <https://github.com/vqv/ggbiplot>
* 



### Changing the path of data and images in notebooks

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
probs_t <- as.vector(as.matrix(read.csv(file.path(data_raw_dir, "the_data.csv"),
                                        header = F)))
```

```
read.csv(file = file.path(data_raw_dir, "the_data.csv"))
```



## Knitr header

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

To enable the use of dated libraries, we have to indicate the new library path using a command to call the definitions by `rsuite`. Include the following chunk at the beginning of any notebook.

```
​```{r echo=FALSE}
load(file.path(rprojroot::find_rstudio_root_file(), "workspace.RData"))
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



## _output.yml` for PDF

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

1. Start by creating a bookdown book at any folder under the project. Preferably, under `work`.
2. Test that the demo works
3. Remove most of the demo notebooks and replace them with your own.
4. Delete or rename the project `.Rproj` file. Otherwise, it will confuse `rsuite`
5. Change the default `yaml` file `_bookdown.yml` if needed. For instance, I added:

```
new_session: yes
```

to prevent collision of chunk labels.

6. Simplify the file `_output.yml` to generate one type of output. By default, it creates html, pdf and ebook one after the other. I selected only to generate a `html` book.
7. Do not use notebooks as symbolic links. It will confuse `rmarkdown` or `bookdown`. It is better to make a dry run of the standalone notebooks in another folder, such as `RMD`, and then move the notebook to `book` after it passed the tests.
8. 





