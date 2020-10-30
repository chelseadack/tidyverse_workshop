#############################################################################################
# WORKSHOP TASK 1
#############################################################################################

# data give HDI for different countries since 1990
filehdi <- "data-raw/Human-development-index.csv"

#############################################################################################
# tidy data

hdi <- read.csv(filehdi) %>% 
  janitor::clean_names()

# converted to long form
hdi <- hdi %>% 
  pivot_longer(names_to = "year", 
               values_to = "hdi",
               cols = -country)

# removed rows containing hdi_rank_2018
hdi <- hdi %>% 
  filter(str_detect(year, "x"))

# remove NA values
hdi_no_na <- hdi %>% 
  filter(!is.na(hdi))

#############################################################################################
# find mean index by country
hdi_summary <- hdi_no_na %>% 
  group_by(country) %>% 
  summarise(mean_index = mean(hdi),
  n = length(hdi),
  sd = sd(hdi),
  se = sd/sqrt(n))

# filter to get 10 countries with lowest mean HDI
hdi_summary_low <- hdi_summary %>% 
  filter(rank(mean_index) < 11)
hdi_summary_low

# plot of them
hdi_summary_low %>% 
  ggplot() +
  geom_point(aes(x = country,
                 y = mean_index)) +
  geom_errorbar(aes(x = country,
                    ymin = mean_index - se,
                    ymax = mean_index + se)) +
  scale_y_continuous(limits = c(0, 0.5),
                     expand = c(0, 0),
                     name = "HDI") +
  scale_x_discrete(expand = c(0, 0),
                   name = "") +
  theme_classic() +
  coord_flip()

#############################################################################################
