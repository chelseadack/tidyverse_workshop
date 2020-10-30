#############################################################################################
# WORKSHOP TASK 3 - case study continued
#############################################################################################

# Extract top protein identifier from accession column and put it in a column called protid
# (top protein identifier is the first Uniprot ID after the “1::” in the accession column)

one_accession <- sol$accession
sol <- sol %>% 
  mutate(protid = str_extract(one_accession, "1::[^;]+") %>% 
           str_replace("1::", ""))

#############################################################################################
# Create a second dataframe sol2

# with protein abundances in a single column (abundance)
# with cell lineage and replicate in a single column (lineage_rep)

sol2 <- sol %>% 
  pivot_longer(names_to = "lineage_rep", 
               values_to = "abundance",
               cols = starts_with("y"))

#Create separate columns in sol2 for the cell lineage and the replicate
sol2 <- sol2 %>% 
  extract(lineage_rep, 
          c("cell lineage", "replicate"),
          "(y[0-9]{3,4})\\_([a-z])")

#Write sol2 to file
file4 <-  "data-processed/sol2.txt"
write.table(sol2, 
            file4, 
            quote = FALSE,
            row.names = FALSE)