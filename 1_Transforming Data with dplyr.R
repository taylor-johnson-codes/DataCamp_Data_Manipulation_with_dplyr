# DATA SET NOT LOADED HERE SO CODE WON'T WORK
# data set is from the 2015 US Census

# select() to select only the variables/columns from the data set that you need
# save it to a variable to save the selected data to a new table

counties %>%
  # Select the columns
  select(state, county, population, poverty)


# arrange() sorts data based on one or more variables in ascending order
# arrange(desc()) sorts data based on one or more variables in descending order

counties_selected <- counties %>%
  select(state, county, population, private_work, public_work, self_employed)

counties_selected %>%
  # Add a verb to sort in descending order of public_work
  arrange(desc(public_work))


# filter() extracts particular observations from a data set based on a condition
# combine multiple filters with comma e.g. filter(cond1, cond2)
# can use == < > operators

counties_selected <- counties %>%
  select(state, county, population)

counties_selected %>%
  # Filter for counties with a population above 1000000
  filter(population > 1000000)

counties_selected %>%
  # Filter for counties only in California with a population above 1000000
  filter(state == "California",
         population > 1000000)


counties_selected <- counties %>%
  select(state, county, population, private_work, public_work, self_employed)

# Filter for Texas and more than 10000 people; sort in descending order of private_work
counties_selected %>%
  # Filter for Texas and more than 10000 people
  filter(state == "Texas", population > 10000) %>%
  # Sort in descending order of private_work
  arrange(desc(private_work))


# mutate() to add new variables or change existing variables

counties_selected <- counties %>%
  select(state, county, population, public_work)

counties_selected %>%
  # Add a new column public_workers with the number of people employed in public work
  # I think public_work in the data set is the percentage of public workers in the population
  mutate(public_workers = public_work * population / 100)

counties_selected %>%
  mutate(public_workers = public_work * population / 100) %>%
  # Sort in descending order of the public_workers column
  arrange(desc(public_workers))


counties_selected <- counties %>%
  # Select the columns state, county, population, men, and women
  select(state, county, population, men, women)

counties_selected %>%
  # Calculate proportion_women as the fraction of the population made up of women
  mutate(proportion_women = women/population)


counties %>%
  # Select the five columns 
  select(state, county, population, men, women) %>% 
  # Add the proportion_men variable
  mutate(proportion_men = men/population) %>%
  # Filter for population of at least 10,000
  filter(population > 10000) %>%
  # Arrange proportion of men in descending order 
  arrange(desc(proportion_men))