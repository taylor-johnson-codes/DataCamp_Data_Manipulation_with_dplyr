# aggregate data: to take many observations and summarize them into one

# count(dataset) to find out number of observations
# OR
# dataset %>%
#   count(variable_in_dataset) for a breakdown of observations by that variable

# dataset %>%
#   count(variable_in_dataset, sort = TRUE) for rows to be sorted from the most observations to the least

# dataset %>%
#   count(variable_in_dataset, wt = another_var_in_dataset, sort = TRUE) to add weight of another variable to sort the results with


# DATA SET NOT LOADED HERE SO CODE WON'T WORK
# data set is from the 2015 US Census

# Use count to find the number of counties in each region and sort in descending order
counties_selected %>%
  count(region, sort = TRUE)

# Find number of counties per state, weighted by citizens, sorted in descending order
counties_selected %>%
  count(state, wt = citizens, sort = TRUE)

counties_selected %>%
  # Add population_walk containing the total number of people who walk to work
  # walk in dataset is the percentage of the population who walk
  mutate(population_walk = population * walk / 100) %>%
  # Count weighted by the new column, sort in descending order
  count(state, wt = population_walk, sort = TRUE)


# summarize() takes many observations and turns them into one observation
# some summary functions to use in summarize(): 
# sum(), mean(), median(), min(), max(), n() for the size of the group

counties_selected %>%
  # Summarize to find minimum population, maximum unemployment, and average income
  summarize(min_population = min(population),
            max_unemployment = max(unemployment),
            average_income = mean(income))


# group_by() can insert more than one variable by separating with a comma
counties_selected %>%
  # Group by state 
  group_by(state) %>%
  # Find the total area and population
  summarize(total_area = sum(land_area), 
            total_population = sum(population))

counties_selected %>%
  group_by(state) %>%
  summarize(total_area = sum(land_area),
            total_population = sum(population)) %>%
  # Add a density column
  mutate(density = total_population/total_area) %>%
  # Sort by density in descending order
  arrange(desc(density))

counties_selected %>%
  # Group and summarize to find the total population
  group_by(region, state) %>%
  summarize(total_pop = sum(population))

counties_selected %>%
  # Group and summarize to find the total population
  group_by(region, state) %>%
  summarize(total_pop = sum(population)) %>%
  # Calculate the average_pop and median_pop columns 
  summarize(average_pop = mean(total_pop),
            median_pop = median(total_pop))


# top_n() to get the most extreme observations from each group 
# top_n(num_of_obs_you_want, column_to_weigh_by)
# e.g. 
# counties_selected %>%
#   group_by(state) %>%
#   top_n(1, population)
# would return the county with the highest population in each state 
# updating the 1 to 3 would return the top 3 counties with the highest population in each state

counties_selected %>%
  # Group by region
  group_by(region) %>%
  # Find the greatest number of citizens who walk to work
  top_n(1, walk)

counties_selected %>%
  group_by(region, state) %>%
  # Calculate average income
  summarize(average_income = mean(income)) %>%
  # Find the highest income state in each region
  top_n(1, average_income)


counties_selected %>%
  # Find the total population for each combination of state and metro
  group_by(state, metro) %>%
  summarize(total_pop = sum(population))

counties_selected %>%
  # Find the total population for each combination of state and metro
  group_by(state, metro) %>%
  summarize(total_pop = sum(population)) %>%
  # Extract the most populated row for each state
  top_n(1, total_pop)


# ungroup() to be able to use count()

counties_selected %>%
  # Find the total population for each combination of state and metro
  group_by(state, metro) %>%
  summarize(total_pop = sum(population)) %>%
  # Extract the most populated row for each state
  top_n(1, total_pop) %>%
  # Count the states with more people in Metro or Nonmetro areas
  ungroup() %>% 
  count(metro)