library("tidyverse")

#Read and inspect data
surveys <- read_csv("data/portal_data_joined.csv")
head(surveys)
summary(surveys)


#Q1: What’s the type of column species_id? Of hindfoot_length?

# species_id = character
# hindfoot_length = double

#Q2: How many rows and columns are in surveys?

# There are 34786 rows and 13 columns. 
  
#Select some columns within surveys df
select(surveys, plot_id, species_id, weight)

select(surveys, plot_id, species_id, weight_g = weight) #can rename in select function
  
select(surveys, -record_id, -species_id)

#filter for some rows within surveys df
filter(surveys, year==1995)

filter(surveys, year==1995, plot_id == 7)

filter(surveys, year==1995 | plot_id == 7)


#Q3: filter() surveys to records collected in November where hindfoot_length is greater than 36.0

filter(surveys, month == 11, hindfoot_length > 36)

#Q4: Fix these errors

#filter(surveys, year = 1995)
filter(surveys, year == 1995)

#filter(surveys, polt_id == 2)
filter(surveys, plot_id == 2)


#Use pipes to be more reader-friendly!

#Q5: Use pipes to subset surveys to animals collected before 1995 retaining just the columns year, sex, and weight

surveys %>% 
  filter(year<1995) %>% 
  select(year, sex, weight)


surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000,
         weight_lb = weight_kg * 2.2) %>% 
  view()
  
#Q6: Create a new data frame from the surveys data that meets the following criteria: contains only the species_id column and a new column called hindfoot_cm containing the hindfoot_length values (currently in mm) converted to centimeters. In this hindfoot_cm column, there are no NAs and all values are less than 3.

new_dataframe <- surveys %>% 
  mutate(hindfoot_cm = hindfoot_length/10) %>% 
  select(species_id, hindfoot_cm) %>% 
  filter(hindfoot_cm < 3)
  
