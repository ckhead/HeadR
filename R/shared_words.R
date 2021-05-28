#' Count (or obtain fraction of) shared words in a sentence
#'
#' @description
#'
#' @param x character vector
#' @param y character vector
#' @param sep character such as "_", defaults to " "
#' @param rm character vector consisting of "punct" and/or "digit"
#' @param frac logical, if TRUE function returns fraction of common words, with the longer sentence length as the denominator
#' @param common character vector of words that are so common they should not be used  
#'
#' @details
#' The typical use of this function is to determine whether two vectors of names are close to each other.
#' The function assumes that each element of each vector is a sentence with " " or some other separator, 
#' I recommend sep = "_" which is what my st_standard creates. 
#' Warning: same sets of common words still have frac of shared=1, but count of shared = 0
#' @examples
#' shared_words(c("HEFEI","I KNOW","GAS","GAS"),c("HEFEI II","I KNOW","GAS-LIGHT","GAS LIGHT"))
#' shared_words(c("HEFEI","I_KNOW","NO"),c("HEFEI_II","I_KNOW","GAS_LIGHT"),sep = "_",rm="digit",frac=TRUE)
#' cw <- c("NORTH","SOUTH")
#' shared_words(c("HEFEI","I_KNOW","NORTH_DAKOTA"),c("HEFEI_II","I_KNOW","NORTH_CAROLINA"),sep = "_",rm="digit",frac=TRUE,common=cw)
#' @export
shared_words <- function(x,y,sep=" ",rm=c("punct","digit"),frac=FALSE,common = NULL){
  if("punct" %in% rm) { #get rid of punctuation marks 
    x <- gsub("[[:punct:]]","",x)
    y <- gsub("[[:punct:]]","",y)
  }
  if("digit" %in% rm){ #get rid of numbers
    x <- gsub("[[:digit:]]","",x)
    y <- gsub("[[:digit:]]","",y)
  }
   split_intersect_count <- function(a,b,s) { #scalar defined function
 # split the sentences into character vectors    
    a_split <- unlist(strsplit(a,split=s))
    b_split <- unlist(strsplit(b,split=s))
#count the number of elements common to both vectors    
    n.shared <- length(setdiff(intersect(a_split, b_split),common))
    n.max <- max(length(setdiff(a_split,common)),length(setdiff(b_split,common)),1) #no div by zero
    if(a==b) shr.shared =1 else shr.shared = n.shared/n.max  
    #note: same sets of common words still have shr.shared=1, but they have n.shared = 0
    if(frac) return(shr.shared)    else return(n.shared) 
  }
  as.vector(mapply(split_intersect_count,x,y,list(s=sep)))  
}

