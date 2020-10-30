# Genever Group data
# mass spectrometry data of soluble protein fraction from 5 immortalised mesenchymal stromal cell (MSC) lines.
# data are normalised protein abundances. Each row is a protein.

filesol <- "data-raw/Y101_Y102_Y201_Y202_Y101-5.csv"

# skip first two lines
sol <- read_csv(filesol, skip = 2) %>% 
  janitor::clean_names()

# need to filter out bovine serum proteins from the medium on which the cells were grown,
# and proteins for which < 2 peptides were detected since we can not be confident about their identity.
# keep rows of human proteins identified by >1 peptide
sol <- sol %>% 
  filter(str_detect(description, "OS=Homo sapiens")) %>% 
  filter(x1pep == "x")

# extract the gene name from description & insert it into column
# extract first value of description
one_description <- sol$description[1]
# extract part of string after GN=
str_extract(one_description,"GN=[^\\s]+")
# replace GN= with an empty string
str_extract(one_description, "GN=[^\\s]+") %>% 
  str_replace("GN=", "")
# add a variable genename which contains the processed string from description variable
sol <- sol %>%
  mutate(genename =  str_extract(description,"GN=[^\\s]+") %>% 
           str_replace("GN=", ""))

# write sol dataframe into file
file3 <-  "data-processed/sol.txt"
write.table(sol, 
            file3, 
            quote = FALSE,
            row.names = FALSE)
