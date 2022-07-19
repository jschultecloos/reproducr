#' Reproducr manuscript output format based on R Markdown and Bookdown
#'
#' Creating and publishing reproducible scientific documents in manuscript (PDF) mode
#'
#' Available metadata variables include:
#'
#' \describe{
#'    \item{\code{fontsize}}{Font size (e.g. 10pt, 11pt, 12pt)}
#'    \item{\code{documentclass}}{LaTeX document class (currently supported: article or scrartcl)}
#'    \item{\code{classoption}}{Option for \code{documentclass} (e.g. DIV=calc); may be repeated}
#'    \item{\code{mainfont, sansfont, monofont, mathfont}}{Document fonts (works only with xelatex and lualatex, see the \code{latex_engine} option)}
#'    \item{\code{linkcolor, urlcolor, citecolor}}{Color for internal, external, and citation links (red, green, magenta, cyan, blue, black)}
#'    \item{\code{linestretch}}{Options for line spacing (e.g. 1, 1.25, 1.5)}
#'    \item{\code{indent}}{if true, pandoc will use document class settings for indentation (the default LaTeX template otherwise removes indentation and adds space between paragraphs)}
#' }
#'
#'
#' \code{reproducr_manuscript()} is a PDF output format function that is optimised for
#' reproducible scientific research and is based on R Markdown and Bookdown.
#' Learn more about how to use \code{reproducr_manuscript} here: \link{https://jschultecloos.github.io/reproducr/}.
#' @param blinded \code{TRUE} to remove any author information from the title page (defaults to \code{FALSE})
#' @param fig_showtext globally sets the `fig.showtext` chunk option (defaults to \code{TRUE})
#'   (defaults to `TRUE`). Use the \pkg{showtext} package to rely on custom fonts for
#'   graphs.
#' @param dev Graphics device to use for figure output (defaults to 'ragg_png')
#'   from the \pkg{ragg} package
#' @param colorlinks should cross-references and links be colored (defaults to \code{TRUE})
#' @param highlight syntax highlighting style in your document (defaults to \code{'tango'}).
#'   Other available code highlighting options are all options currently supported by
#'   \code{rmarkdown::pdf_document}: "pygments", "kate", "monochrome", "espresso",
#'   "zenburn", "haddock", "breezedark". Pass \code{NULL} to prevent syntax highlighting.
#' @inheritParams bookdown::pdf_document2
#' @param ... Other arguments to be passed to \code{\link{reproducr_manuscript}}
#' @references See https://jschultecloos.github.io/reproducr/ for examples.
#' @export
#' @examples
#' \dontrun{
#' # devtools::install_github("jschultecloos/reproducr")
#' library(reproducr)
#' rmarkdown::render("reproducr-file.Rmd", "reproducr::reproducr_manuscript")
#' }

reproducr_manuscript <- function(
  blinded = FALSE,
  toc = FALSE,
  number_sections = FALSE,
  extra_dependencies = NULL,
  fig_width = 7,
  fig_height = 4,
  fig_crop = TRUE,
  fig_align = 'center',
  fig_showtext = TRUE,
  dev = 'ragg_png',
  dpi = 500,
  highlight = 'default',
  colorlinks = TRUE,
  ...
) {


  # resolve default highlight
  if (identical(highlight, 'default')) highlight <- 'tango'


  # call the base pdf_document format with the appropriate options
  format <- bookdown::pdf_document2(
    toc = toc,
    number_sections = number_sections,
    fig_width = fig_width, fig_height = fig_height, fig_crop = fig_crop,
    dev = dev, highlight = highlight,
  )



  # add the preamble and the docprefix
  format$pandoc$args <- c(format$pandoc$args,
                          '--include-in-header', latex_files("reproducr_preamble.tex"),
                          '--include-before-body', latex_files("reproducr_docprefix.tex")
  )


  # Lua filters
  format$pandoc$lua_filters <- c(
    format$pandoc$lua_filters,
    lua_filter("not-in-format.lua"),
    lua_filter("abstract-to-meta.lua"),
    lua_filter("section-refs.lua")
  )

  # scholarly meta information only if blinded = FALSE
  if (isFALSE(blinded)) {
    format$pandoc$lua_filters <- c(
      format$pandoc$lua_filters,
      lua_filter("scholarly-metadata.lua"),
      lua_filter("author-info-blocks.lua")
    )
  } else if (isTRUE(blinded)) {
    format$pandoc$lua_filters <- c(
      format$pandoc$lua_filters,
      lua_filter("blinded.lua")
    )
  }



  # create knitr options (ensure opts and hooks are non-null)
  knitr_options <- rmarkdown::knitr_options_pdf(fig_width, fig_height, fig_crop, dev)
  if (is.null(knitr_options$opts_knit))  knitr_options$opts_knit <- list()
  if (is.null(knitr_options$knit_hooks)) knitr_options$knit_hooks <- list()


  # set options
  knitr_options$opts_chunk <- list(
    echo = FALSE,
    tidy = TRUE,
    message = FALSE,
    warning = FALSE,
    dev = dev,
    dpi = dpi,
    fig.path = 'figs/fig-',
    fig.showtext = fig_showtext,
    fig.align = fig_align
  )

  # override the knitr settings of the base format and return the format
  format$knitr <- knitr_options
  format$inherits <- 'pdf_document'
  format


}


