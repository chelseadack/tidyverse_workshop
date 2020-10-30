# Load tidyverse packages
library(tidyverse)

# Generate a random sample of 10 proportions to work with
nums <- sample((1:100)/100, size = 10, replace = FALSE)

# Apply log squareroot transformation
tnums <- log(sqrt(nums))
sqrtnums <- sqrt(nums)
tnums <- log(sqrtnums)
# Or can use pipe %>% 
tnums <- nums %>% 
  sqrt() %>% 
  log()

##############################################################################################
# Biomass.txt
##############################################################################################
# Insect pest biomass (g) was measured on plots sprayed with water (control) or one of five different insecticides.
# Also are variables indicating replicate number and identity of the tray the plant was grown in.
file <- "data-raw/biomass.txt"
biomass <- read_table2(file)

# Convert to "long" form, gather all columns except tray, column called mass, rows called treatmemt
biomass2 <- biomass %>% 
  pivot_longer(names_to = "spray", 
               values_to = "mass",
               cols = -rep_tray)

# Write biomass2 dataframe to file
file2 <-  "data-processed/biomass2.txt"
write.table(biomass2, 
            file2, 
            quote = FALSE,
            row.names = FALSE)

# Extract parts of rep_tray and put in new columns replicate_number, tray_id
biomass3 <- biomass2 %>% 
  extract(rep_tray, 
          c("replicate_number", "tray_id"),
          "([0-9]{1,2})\\_([a-z])")

