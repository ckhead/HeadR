# HeadR

my package has about 20 functions and 5 binary operators. 
## Installation
```r
install.packages("remotes")
remotes::install_github("ckhead/HeadR")
```
## Stata-like functions
There are five functions that have their inspiration in Stata command (also one binary operator below %+% that pastes together strings the same way "+" works in Stata)
- merge_stata  counts the number of _1 _2 and _3 merges. it creates a new variable in your data.table stata_merge which you can use to filter the data set in two steps rather than all.x =TRUE or all.y=TRUE.
- duplicates counts duplicate observations, returning a table of the frequency of repeated data, optionally the function can return a new data.table, which adds the variable tagging duplicates. Note that there are related functions duplicated(DT), which returns a logical the same length as the rows in DT and anyDuplicated(DT) which returns the first row of the first duplicate and 0 if all unique.
- distinct returns number of unique values in a numeric or string vector. Note this function might not be needed since data.table has uniqueN() which seems to do the same thing.
- ipolate(x,y,extrapolate=TRUE): interpolates to replace missing data based on a linear function of the observed data and a variable (usually time). ipolate(x,y) used to only interpolate, nows an option extrapolate=TRUE.  this will carry forward the last non-missing observation to replace subsequent NA. And it carries backward non-missing observations to replace preceding missings. ipolate() behaves this way because it is based on an R function called approx() that does it this way. ipolate() is different from the data.table nafill() function which does either locf or nocb but does not do linear interpolation between observed values.
- ipolate_stata(x,y,epolate=TRUE). for linear extrapolation as an option in addition to linear interpolation,  a new function that has been tested and compared with Stata's ipolate command. the only important difference is Stata ipolate expects the yvar before the xvar to 
- scatter: unlike R plot or Stata scatter defaults, it uses transparent circles, which is better for showing density of large numbers of points
- strpos: as with Stata's strpos, gives the position of line of text

## String utility functions
- st_all  this is useful if you want to collapse to one row per group but not lose the information on what elements were included in the collapse
- st_range creates a string of "min--max"
- st_left this command and st_right are especially useful after fixest because you can recover the components of an interactive fixed effect (e.g. origin-dest). this function had a glitch in previous version because strpos could not handle vectors properly
- st_right  extracts the part of a string to the right of the delimiter
- st_standard  creates a standardized version of a name
- shared_words takes two character vectors. It divides them into strings using a delimiter (such as space or underscore) and counts common quasi-words in each quasi-sentence.
- str2tex_col() is a replacement for texout(). It is more flexible and eliminates some undesirable behaviours.

## Binary operators
- x %ni% y returns TRUE for each element x that is not one of set specified in y. Thus, it is the reverse of R base operator %in%. I use it in the DT[i] position to select only those cases that do not have the offending attribute. thus it is kind of like a "drop if" in Stata.
- x %+% y is the equivalent of paste0(x,y). one nice use is to create a file name by combining strings ".pdf" with variables, e.g. year (which can take on different values)
-  x %+na% y returns x if y is NA or y if x is NA. Thus, it is a vector sum with na.rm=TRUE, used in merge_stata
- %contains%  this operator may not add much relative to  %like% but it is intuitive.
- %excludes% not be confused with %ni%, this operator does the reverse of %contains% 

## Warnings
- Many of the functions have only limited testing in special situations
- HeadR "depends" on data.table. 
- merge_stata, duplicates, where_missing, str2tex_col and texout are designed only for data.table users. These do not work unless you library(HeadR). That is while you can use HeadR::distinct(x) without library(HeadR), you cannot use HeadR::duplicates(DT) without doing the library(HeadR) first. 
- when you install HeadR it will require you to install data.table and may prompt you to update data.table. Be careful what options you chose.
