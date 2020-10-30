#############################################################################################
# WORKSHOP TASK 2
#############################################################################################
file <- "http://www.ndbc.noaa.gov/view_text_file.php?filename=44025h2011.txt.gz&dir=data/historical/stdmet/"

# use readLines to preview first few lines to determine how to read data in
readLines(file, n = 4)

buoy44025 <- read_table(file,
                        col_names = FALSE,
                        skip = 2)

# why use read_table
?read_table
# read_table() & read_table2() read data where each column seperated by 1 or more columns of space
# read_table() each line must be same length & each field same position in every line
# read_table2() allows any number of whitespace characters between columns & lines different lengths

#############################################################################################
# tidy data
?scan
# scan() reads in appropriate lines

# rename the columns to measure_unit (row1_row2)
unit <- scan(file = file, what = character(), skip = 1, nlines = 1) %>% 
  str_remove("#")

measure_unit <- scan(file = file, what = character(), nlines = 1) %>% 
  str_remove("#") %>% 
  paste(unit, sep = "_")
  
names(buoy44025) <- measure_unit
names(buoy44025)

buoy44025
