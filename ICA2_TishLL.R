install.packages("DBI")
install.packages("RSQLite")
install.packages("quarto")
install.packages("shiny")  # For the interactive dashboard
install.packages("tidyverse")  # Useful for data manipulation and visualization


library(DBI)
library(RSQLite)

# Connect to SQLite database
con <- dbConnect(RSQLite::SQLite(), "/Volumes/ANIMATION/DkIT_MSc/YEAR_1__SEMESTER_1/DATA_ANALYTICS_Dr_Muhammad_Adil_Raja/I-CA2_LinearRegression/ICA2_RDBMS_Linear_Regression_TishLL/RDBMS_Linear_Regression/ICA_2023.sqlite")

# List all tables
dbListTables(con)

# Query the database
projects_table <- dbGetQuery(con, "SELECT * FROM Projects")

# Query the database
assets_table <- dbGetQuery(con, "SELECT * FROM Assets")

# Query the database
timelines_table <- dbGetQuery(con, "SELECT * FROM Timelines")

# Query the database
customers_table <- dbGetQuery(con, "SELECT * FROM Customers")

# Query the database
developers_table <- dbGetQuery(con, "SELECT * FROM Developers")

# Query the database
projectdevelopers_table <- dbGetQuery(con, "SELECT * FROM ProjectDevelopers")

# Query the database
assetsdevelopers_table <- dbGetQuery(con, "SELECT * FROM AssetsDevelopers")





# To remove an item from the Environment window, change name, obvs
rm(assets_table)
