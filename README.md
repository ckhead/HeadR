# HeadR

my package has 16 functions and 5 binary operators
## Stata-like functions
There are five functions that have their inspiration in Stata command (also one binary operator below %+% that pastes together strings the same way "+" works in Stata)
- merge_stata  counts the number of _1 _2 and _3 merges
- duplicates counts duplicate observations, returning a table of the frequency of repeated data, optionally the function can return a new data.table, which adds the variable tagging duplicates. Note that there are related functions duplicated(DT), which returns a logical the same length as the rows in DT and anyDuplicated(DT) which returns the first row of the first duplicate and 0 if all unique.
- distinct returns number of unique values in a numeric or string vector. Note this function might not be needed since data.table has uniqueN() which seems to do the same thing.
- ipolate: interpolates to replace missing data based on a linear function of the observed data and a variable (usually time). In the case I tested, it did the same thing as Stata's ipolate.
- scatter: unlike R plot or Stata scatter defaults, it uses transparent circles, which is better for showing density of large numbers of points
- strpos: as with Stata's strpos, gives the position of line of text

## String utility functions
- st_all  this is useful if you want to collapse to one row per group but not lose the information on what elements were included in the collapse
- st_range creates a string of "min--max"
- st_left this command and st_right are especially useful after fixest because you can recover the components of an interactive fixed effect (e.g. origin-dest). this function had a glitch in previous version because strpos could not handle vectors properly
- st_right  extracts the part of a string to the right of the delimiter
- st_standard  creates a standardized version of a name

## Binary operators
- x %ni% y returns TRUE for each element x that is not one of set specified in y. Thus, it is the reverse of R base operator %in%. I use it in the DT[i] position to select only those cases that do not have the offending attribute. thus it is kind of like a "drop if" in Stata.
- x %+% y is the equivalent of paste0(x,y). one nice use is to create a file name by combining strings ".pdf" with variables, e.g. year (which can take on different values)
-  x %+na% y returns x if y is NA or y if x is NA. Thus, it is a vector sum with na.rm=TRUE, used in merge_stata
- %contains%  this operator may not add much relative to  %like% but it is intuitive.
- %excludes% not be confused with %ni%, this operator does the reverse of %contains% 

## Warnings
- Many of the functions have only limited testing in special situations
- HeadR "depends" on data.table. 
- merge_stata, duplicates, where_missing, and texout are designed only for data.table users. These do not work unless you library(HeadR). That is while you can use HeadR::distinct(x) without library(HeadR), you cannot use HeadR::duplicates(DT) without doing the library(HeadR) first. 
- when you install HeadR it will require you to install data.table and may prompt you to update data.table. Be careful what options you chose.
