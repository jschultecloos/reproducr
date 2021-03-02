#' Drafting and publishing reproducible scientific articles with R Markdown
#'
#' @details The \pkg{reproducr} package allows users without any prior knowledge of R Markdown
#'   to implement reproducible research practices in their scientific workflows.
#'   It provides a single Rmd-template that is fully optimized for two different output formats,
#'   HTML and PDF.
#'   \preformatted{
#' reproducr_manuscript("researchpaper.Rmd")
#' reproducr_draft("researchpaper.Rmd")
#' }
#' @seealso The \pkg{reproducr} package builds on the \pkg{bookdown} and \pkg{rmarkdown} package
#'  for the manuscript PDF output.
#'  The \pkg{reproducr} package builds on the \pkg{distill} package
#'  for the draft HTML output.
#' @name reproducr-package
#' @aliases reproducr
#' @docType package
#'
#'
#' @keywords internal
"_PACKAGE"
