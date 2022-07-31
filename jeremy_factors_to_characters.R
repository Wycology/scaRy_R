library(tidyverse)

all_species <- read.csv("Birdlife_distributions_clipped.csv")

all_species |>  # Picking the dataframe
  select(sci_name, presence, origin, seasonal) |> #selecting relevant columns
  mutate(presence_char = case_when(presence == 1 ~ "Extant,",
                                   presence == 2 ~ "Probably Extant,",
                                   presence == 3 ~ "Possibly Extant,",
                                   presence == 4 ~ "Possibly Extinct,",
                                   presence == 5 ~ "Extinct post 1500,"),
         origin_char = case_when(origin == 1 ~ "Native,",
                                 origin == 2 ~ "Reintroduced,",
                                 origin == 3 ~ "Introduced,"),
         seasonal_char = case_when(seasonal == 1 ~ "Resident,",
                                   seasonal == 2 ~ "Breeding Season,",
                                   seasonal == 3 ~ "Non-breeding Season,",
                                   seasonal == 4 ~ "Passage,",
                                   seasonal == 5 ~ "Seasonal Occurrence Uncertain,")) |> 
  as.data.frame() |> #converting to data frame (factors) 
  group_by(sci_name) |> # Grouping by the species names column
  summarise(presence_char = list(unique(presence_char)), # Picking unique elements from each group (species)
            origin_char = list(unique(origin_char)),
            seasonal_char = list(unique(seasonal_char))) |> 
  mutate(species = sci_name, # Printing unique elements into new column
            presence_categories_char = map_chr(presence_char, toString),
            origin_categories_char = map_chr(origin_char, toString),
            seasonal_categories_char = map_chr(seasonal_char, toString)) |>
  select(species, presence_categories_char, origin_categories_char, seasonal_categories_char) |> 
  write_csv("species_in_studyarea_numbers.csv")