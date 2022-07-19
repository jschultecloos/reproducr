#' Reproducr draft output format (HTML) based on R Markdown and Distill
#'
#' Creating and publishing reproducible scientific documents in draft (HTML) mode
#'
#'
#'
#' \code{reproducr_draft()} provides the HTML format
#' @param fig_retina globally sets the `fig.retina` chunk option (defaults to 5)
#' @param fig_showtext globally sets the `fig.showtext` chunk option
#'   (defaults to `TRUE`). Use the \pkg{showtext} package to rely on custom fonts for
#'   graphs.
#' @param dev Graphics device to use for figure output (defaults to 'ragg_png')
#'   from the \pkg{ragg} package
#' @param toc Table of contents (defaults to `FALSE`).
#' @param toc_depth Depth of headers to include in table of contents (defaults to 3).
#' @param toc_float Float the table of contents to the left when the article
#'   is displayed at widths > 1000px. If set to `FALSE` or the width is less
#'   than 1000px the table of contents will be placed above the article body.
#' @param smart Produce typographically correct output, converting straight
#'   quotes to curly quotes, `---` to em-dashes, `--` to en-dashes, and
#'   `...` to ellipses.
#' @param code_folding Include code blocks hidden, and allow users to
#'   optionally display the code by clicking a "Show code" button just above
#'   the output. Pass a character vector to customize the text of the
#'   "Show code" button. `code_folding` is set to \code{TRUE} as default chunk option
#'   in the \code{reproducr::reproducr_draft}.
#' @param highlight Syntax highlighting style. Supported styles include
#'   "default", "rstudio", "tango", "pygments", "kate", "monochrome", "espresso",
#'   "zenburn", "breezedark", and  "haddock". Pass NULL to prevent syntax
#'   highlighting.
#' @param highlight_downlit Use the \pkg{downlit} package to highlight
#'   R code (including providing hyperlinks to function documentation).
#' @param keep_md Keep the markdown file that is generated in the knitting process? (defaults to `FALSE`)
#'
#' @import rmarkdown
#' @import distill
#'
#' @export
#' @examples
#' \dontrun{
#' # devtools::install_github("jschultecloos/reproducr")
#' library(reproducr)
#' rmarkdown::render("reproducr-file.Rmd", "reproducr::reproducr_draft")
#' }

reproducr_draft <- function(toc = FALSE,
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
                            ...) {


  # call the base distill_article format with the appropriate options
  format <- distill::distill_article(
    toc = toc,
    toc_depth = toc_depth,
    toc_float = toc_float,
    code_folding = code_folding,
    fig_width = fig_width,
    fig_height = fig_height,
    fig_retina = fig_retina,
    dev = dev,
    fig_caption = fig_caption,
    smart = smart,
    self_contained = self_contained,
    highlight = "default",
    highlight_downlit = highlight_downlit,
    mathjax = "default",
    extra_dependencies = extra_dependencies,
    theme = theme,
    css = css,
    includes = includes,
    keep_md = keep_md,
    lib_dir = lib_dir,
    md_extensions = md_extensions,
    pandoc_args = pandoc_args
  )


  # Lua filters
  format$pandoc$lua_filters <- c(
    lua_filter("not-in-format.lua"),
    format$pandoc$lua_filters
  )

  # Knitr options
  format$knitr$opts_chunk$echo <- TRUE
  format$knitr$opts_chunk$fig.path <- 'figs/fig-'
  format$knitr$opts_chunk$fig.showtext <- fig_showtext
  format$knitr$opts_chunk$dev <- dev
  format$knitr$opts_chunk$fig.retina <- fig_retina


  format

}
