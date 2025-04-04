#' Standardize a name following set of procedures
#'
#' @description
#'
#' @param x string vector
#'
#' @details
#' st_standard capitalizes and trims leading and following white space
#' It replaces a single "-" and multiple internal spaces between words with a single "_"
#' It also eliminates all other punctuation
#' The current version does not replace accented characters but i would like to do so later.
#' @examples
#' st_standard(c("General Pacheko #2","B.M.W.","Fiat-Chrysler","Fiat Chrysler","Fiat chrysler","Austin, TX (USA)"))
#' @export

st_standard <- function(x) {
  y <- toupper(x) # all upper case
  accented <- "çáéíóúàèìòùäëïöüÿâêîôûåøØÅÁÀÂÄÈÉÊËÍÎÏÌÒÓÔÖÚÙÛÜŸÇãñ"
  normal <- "caeiouaeiouaeiouyaeiouaoOAAAAAEEEEIIIIOOOOUUUUYCan"
  # (incomplete) set of accented characters and their unaccented counterparts
   y <- chartr(accented,normal,y)
   # another option, but i think i worked out the chartr is better: iconv("jörgen",to="ASCII//TRANSLIT")
    y <- gsub("-"," ",y) # replace dashes with spaces
  #  y <- gsub(",","",y)  #just get rid of commas
  y <- gsub("[[:punct:]]","",y)  # (or) get rid of ALL punctuation
  y <- gsub("^\\s+|\\s+$", "",y) # get rid of all leading or trailing white space
  y <- gsub("\\s+","_",y)  # replace one or more white spaces in between words with _
  return(y)
}

