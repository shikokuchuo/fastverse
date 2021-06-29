msg <- function(..., startup = FALSE) {
  if (startup) {
    if (!isTRUE(getOption("fastverse.quiet"))) {
      packageStartupMessage(...)
    }
  } else {
    message(...)
  }
}


#' List all packages in the fastverse
#'
#' @param include_self Include fastverse in the list?
#' @export
#' @examples
#' fastverse_packages()
fastverse_packages <- function(include_self = TRUE) {
  raw <- utils::packageDescription("fastverse")$Imports
  imports <- strsplit(raw, ",")[[1]]
  parsed <- gsub("^\\s+|\\s+$", "", imports)
  names <- vapply(strsplit(parsed, "\\s+"), "[[", 1, FUN.VALUE = character(1))
  
  if (include_self) {
    names <- c(names, "fastverse")
  }
  
  names
}

invert <- function(x) {
  if (length(x) == 0) return()
  stacked <- utils::stack(x)
  tapply(as.character(stacked$ind), stacked$values, list)
}


package_version <- function(x) paste(unclass(packageVersion(x))[[1]], collapse = ".")

green <- function(x) paste0("\033[32m", x, "\033[39m")
blue <- function(x) paste0("\033[34m", x, "\033[39m")
cyan <- function(x) paste0("\033[36m", x, "\033[39m")
magenta <- function(x) paste0("\033[35m", x, "\033[39m")
magenta2 <- function(x) paste0("\033[38;5;198m", x, "\033[39m")  #ff0066
gold <- function(x) paste0("\033[38;5;214m", x, "\033[39m") #fa9c19
lightblue <- function(x) paste0("\033[38;5;45m", x, "\033[39m")                                    # 12b8ff
kingsblue <- function(x) paste0("\033[38;5;33m", x, "\033[39m")                                      #0062ff
grey09 <- function(x) paste0("\033[38;5;253m", x, "\033[39m") 
red <- function(x) paste0("\033[31m", x, "\033[39m")
yellow <- function(x) paste0("\033[33m", x, "\033[39m")
bold <- function(x) paste0("\033[1m", x, "\033[22m")

rule <- function(left, right = NULL) {
  n <- .Options$width
  left <- as.character(left)
  if(length(right)) {
    right <- as.character(right)
    w <- n - nchar(left) - nchar(right) - 8L
    cat("-- ", left, " ", rep("-", w), " ", right, " --", sep = "")
  } else {
    w <- n - nchar(left) - 4L
    cat("-- ", left, " ", rep("-", w), sep = "")
  }
}