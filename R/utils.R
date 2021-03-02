#' @import stats utils
#'
#'


# reproducr Lua filters paths
lua_filter = function (filters = NULL) {
  rmarkdown::pkg_file_lua(filters, package = 'reproducr')
}


# devtools metadata -------------------------------------------------------

# from pkgdown
# https://github.com/r-lib/pkgdown/blob/77f909b0138a1d7191ad9bb3cf95e78d8e8d93b9/R/utils.r#L52

devtools_meta <- function(package) {
  ns <- .getNamespace(package)
  ns[[".__DEVTOOLS__"]]
}

# reproducr LaTeX preamble and doc-prefix paths
pkg_file <- function(..., package = "reproducr", mustWork = FALSE) {
  if (is.null(devtools_meta(package))) {
    system.file(..., package = package, mustWork = mustWork)
  } else {
    # used only if package has been loaded with devtools or pkgload
    file.path(getNamespaceInfo(package, "path"), "inst", ...)
  }
}


pkg_file_latex <- function (latexfiles = NULL,
                            package = "reproducr") {
  files <- pkg_file("rmarkdown",
                    "latex",
                    if (is.null(latexfiles))
                      "."
                    else latexfiles, package = package, mustWork = TRUE)
  if (is.null(latexfiles)) {
    files <- list.files(dirname(files), "[.]tex$", full.names = TRUE)
    }
  rmarkdown::pandoc_path_arg(files)
  }


# reproducr LaTeX filters paths
latex_files = function (latexfiles = NULL) {
  pkg_file_latex(latexfiles, package = 'reproducr')
}







