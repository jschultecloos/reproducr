% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/reproducr_draft.R
\name{reproducr_draft}
\alias{reproducr_draft}
\title{Reproducr draft output format (HTML) based on R Markdown and Distill}
\usage{
reproducr_draft(
  toc = FALSE,
  toc_depth = 3,
  toc_float = TRUE,
  fig_width = 7,
  fig_height = 4,
  fig_retina = 5,
  fig_caption = TRUE,
  dev = "ragg_png",
  fig_showtext = TRUE,
  smart = TRUE,
  code_folding = TRUE,
  self_contained = TRUE,
  highlight = "default",
  highlight_downlit = TRUE,
  mathjax = "default",
  extra_dependencies = NULL,
  theme = NULL,
  css = NULL,
  includes = NULL,
  keep_md = FALSE,
  lib_dir = NULL,
  md_extensions = NULL,
  pandoc_args = NULL,
  ...
)
}
\arguments{
\item{toc}{Table of contents (defaults to \code{FALSE}).}

\item{toc_depth}{Depth of headers to include in table of contents (defaults to 3).}

\item{toc_float}{Float the table of contents to the left when the article
is displayed at widths > 1000px. If set to \code{FALSE} or the width is less
than 1000px the table of contents will be placed above the article body.}

\item{fig_retina}{globally sets the \code{fig.retina} chunk option (defaults to 5)}

\item{dev}{Graphics device to use for figure output (defaults to 'ragg_png')
from the \pkg{ragg} package}

\item{fig_showtext}{globally sets the \code{fig.showtext} chunk option
(defaults to \code{TRUE}). Use the \pkg{showtext} package to rely on custom fonts for
graphs.}

\item{smart}{Produce typographically correct output, converting straight
quotes to curly quotes, \verb{---} to em-dashes, \verb{--} to en-dashes, and
\code{...} to ellipses.}

\item{code_folding}{Include code blocks hidden, and allow users to
optionally display the code by clicking a "Show code" button just above
the output. Pass a character vector to customize the text of the
"Show code" button. \code{code_folding} is set to \code{TRUE} as default chunk option
in the \code{reproducr::reproducr_draft}.}

\item{highlight}{Syntax highlighting style. Supported styles include
"default", "rstudio", "tango", "pygments", "kate", "monochrome", "espresso",
"zenburn", "breezedark", and  "haddock". Pass NULL to prevent syntax
highlighting.}

\item{highlight_downlit}{Use the \pkg{downlit} package to highlight
R code (including providing hyperlinks to function documentation).}

\item{keep_md}{Keep the markdown file that is generated in the knitting process? (defaults to \code{FALSE})}
}
\description{
Creating and publishing reproducible scientific documents in draft (HTML) mode
}
\details{
\code{reproducr_draft()} provides the HTML format
}
\examples{
\dontrun{
# devtools::install_github("jschultecloos/reproducr")
library(reproducr)
rmarkdown::render("reproducr-file.Rmd", "reproducr::reproducr_draft")
}
}
