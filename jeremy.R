library(tidyverse)

# Creating dataframe with three species with different number of records

df <- data.frame(sci_name = c("Jeremy dickens", "Jeremy dickens", "Jeremy dickens", 
                              "Wyclife agumba", 'Wyclife agumba', 
                              "Agumba oluoch", 'Agumba oluoch'), 
                 presence = c(1, 1, 1, 1, 1, 1, 1), 
                 origin = c(1, 1, 1, 1, 1, 1, 1), 
                 seasonal = c(2, 3, 1, 3, 1, 2, 1))

# Wrangling the data for seasonal

df |>  # Picking the dataframe
  group_by(sci_name) |> # Grouping by the scientific names column
  summarise(seasonal = list(unique(seasonal))) |> # Picking unique elements from each group (unique species)
  mutate(seasonal_revealed = map_chr(seasonal, toString)) # Printing unique elements into new column

# Wrangling the data for origin

df |>  # Picking the dataframe
  group_by(sci_name) |> # Grouping by the scientific names column
  summarise(origin = list(unique(origin))) |> # Picking unique elements from each group (unique species)
  mutate(origin_revealed = map_chr(origin, toString)) # Printing unique elements into new column

# Wrangling the data for presence

df |>  # Picking the dataframe
  group_by(sci_name) |> # Grouping by the scientific names column
  summarise(presence = list(unique(presence))) |> # Picking unique elements from each group (unique species)
  mutate(presence_revealed = map_chr(presence, toString)) # Printing unique elements into new column
