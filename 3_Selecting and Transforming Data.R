# Use ?select_helpers for more info

# DATA SET NOT LOADED HERE SO CODE WON'T WORK
# data set is from the 2015 US Census

# Glimpse the counties table
glimpse(counties)

counties %>%
  # Select state, county, population, and industry-related columns
  select(state, county, population, professional:production) %>%  # var:var selects those two vars plus all vars in-between those two
  # Arrange service in descending order 
  arrange(desc(service))

counties %>%
  # Select the state, county, population, and those ending with "work"
  select(state, county, population, ends_with("work")) %>%
  # Filter for counties that have at least 50% of people engaged in public work
  filter(public_work > 50)


# rename() to rename existing column
# dataset %>%
#   rename(new_name = old_name)

# OR do this in select()
# dataset %>%
#   select(var1, var2, new_name = var3)

counties %>%
  # Count the number of counties in each state
  count(state) %>%
  # Rename the n column to num_counties
  rename(num_counties = n)

counties %>%
  # Select state, county, and poverty as poverty_rate
  select(state, county, poverty_rate = poverty)


# transmute() is like a combo of select() and mutate()
# returns a subset of columns that are transformed and changed
# counties %>%
#   select(state, county, fraction_women = women/population)
# returns these 3 columns: state, county, fraction_women

counties %>%
  # Keep the state, county, and populations columns, and add a density column
  transmute(state, county, population, density = population/land_area) %>%
  # Filter for counties with a population greater than one million 
  filter(population > 1000000) %>%
  # Sort density in ascending order 
  arrange(density)


# Change the name of the unemployment column
counties %>%
  rename(unemployment_rate = unemployment)

# Keep the state and county columns, and the columns containing poverty
counties %>%
  select(state, county, contains("poverty"))

# Calculate the fraction_women column without dropping the other columns
counties %>%
  mutate(fraction_women = women / population)

# Keep only the state, county, and employment_rate columns
counties %>%
  transmute(state, county, employment_rate = employed / population)