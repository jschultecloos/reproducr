#' Knit function to add a datestamp to the name of the Rmd output
#'
#'
#' @param input A .Rmd file
#'
#' @references See https://jschultecloos.github.io/reproducr/ for examples.
#' @export


knit_with_datestamp <- function(input, ...) {
  rmarkdown::render(
    input,
    output_file = paste0(
      xfun::sans_ext(input), '-', Sys.Date(), '.',
      xfun::file_ext(input)
    ),
    envir = globalenv()
    )
}
