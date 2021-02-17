# HeadR
my package has 16 functions and 5 binary operators
## Stata-like functions
There are five functions that have their inspiration in Stata command
- merge_stata  counts the number of _1 _2 and _3 merges
- duplicates counts duplicate observations and, optionally tags them
- distinct returns number of unique values in a numeric or string vector
- ipolate: this function has hardly been tested so risky to use.
- scatter: unlike R plot or Stata scatter defaults, it uses transparent circles, which is better for showing density of large numbers of points

## String utility functions
- st_all  this is useful if you want to collapse to one row per group but not lose the information on what elements were included in the collapse
- st_range creates a string of "min--max"
- st_left this command and st_right are especially useful after fixest because you can recover the components of the fixed effect.
- st_right  extracts the part of a string to the right of the delimiter

## Binary operators
- %ni%  the reverse of %in% I use it in the DT[i] position to select only those cases that do not have the offending attribute. thus it is kind of like a "drop if" in Stata
- %+%  equivalent of paste0(x,y)
- %+na% vector sum with na.rm=TRUE, used in merge_stata
- %contains%  this seems to be about the same as %like% but it is intuitive
- %excludes% not be confused with %ni%, this operator does the reverse of %contains% 

## Warnings
- Many of the functions have only limited testing in special situations
- HeadR "depends" on data.table. 
- merge_stata, duplicates, where_missing, and texout are designed only for data.table users. These do not work unless you library(HeadR). That is while you can use HeadR::distinct(x) without library(HeadR), you cannot use HeadR::duplicates(DT) without doing the library(HeadR) first. 
- when you install HeadR it will require you to install data.table and may prompt you to update data.table. Be careful what options you chose.
