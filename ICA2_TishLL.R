install.packages("DBI")
install.packages("RSQLite")
install.packages("quarto")
install.packages("shiny")  # For the interactive dashboard
install.packages("tidyverse")  # Useful for data manipulation and visualization


# Load necessary libraries
library(DBI)
library(RSQLite)

# Connect to SQLite database
con <- dbConnect(RSQLite::SQLite(), "/Volumes/ANIMATION/DkIT_MSc/YEAR_1__SEMESTER_1/DATA_ANALYTICS_Dr_Muhammad_Adil_Raja/I-CA2_LinearRegression/ICA2_RDBMS_Linear_Regression_TishLL/RDBMS_Linear_Regression/2023_DAIE_ICA_2_TishLL/ICA_2023.sqlite")


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
rm(result)



# Task 1: Total Budget and Count of Projects per Country

# Load necessary libraries
library(DBI)
library(RSQLite)

# Connect to SQLite database
con <- dbConnect(RSQLite::SQLite(), "/Volumes/ANIMATION/DkIT_MSc/YEAR_1__SEMESTER_1/DATA_ANALYTICS_Dr_Muhammad_Adil_Raja/I-CA2_LinearRegression/ICA2_RDBMS_Linear_Regression_TishLL/RDBMS_Linear_Regression/2023_DAIE_ICA_2_TishLL/ICA_2023.sqlite")

# Join the Tables and Perform the Query
query <- "
SELECT 
    c.CustomerCountry AS country,
    SUM(p.budget) AS total_budget,
    COUNT(*) AS project_count
FROM 
    Projects p
JOIN 
    Customers c ON p.CustomerID = c.CustomerID
GROUP BY 
    c.CustomerCountry
ORDER BY 
    total_budget DESC;
"

# Execute the query and store the result
Task1 <- dbGetQuery(con, query)
print(result)



# Task 2: Average Development Time for Projects, Categorized by the Number of Assets Used.
# 31st of February?!

# Load necessary libraries
library(DBI)
library(RSQLite)

# Connect to SQLite database
con <- dbConnect(RSQLite::SQLite(), "/Volumes/ANIMATION/DkIT_MSc/YEAR_1__SEMESTER_1/DATA_ANALYTICS_Dr_Muhammad_Adil_Raja/I-CA2_LinearRegression/ICA2_RDBMS_Linear_Regression_TishLL/RDBMS_Linear_Regression/2023_DAIE_ICA_2_TishLL/ICA_2023.sqlite")

# Calculate the Development Time and Count Assets
query <- "
SELECT 
    p.ProjectID,
    COUNT(a.ProjectID) AS number_of_assets,
    AVG(julianday(p.EndDate) - julianday(p.StartDate)) AS average_development_time
FROM 
    Projects p
JOIN 
    Assets a ON p.ProjectID = a.ProjectID
WHERE 
    p.Status = 'Completed'
GROUP BY 
    p.ProjectID
"

# Execute the query and store the result
Task2 <- dbGetQuery(con, query)

# Print the result stored in Task2
print(Task2)



# Task 3: List the Top Three Developers

# Load necessary libraries
library(DBI)
library(RSQLite)

# Connect to SQLite database
con <- dbConnect(RSQLite::SQLite(), "/Volumes/ANIMATION/DkIT_MSc/YEAR_1__SEMESTER_1/DATA_ANALYTICS_Dr_Muhammad_Adil_Raja/I-CA2_LinearRegression/ICA2_RDBMS_Linear_Regression_TishLL/RDBMS_Linear_Regression/2023_DAIE_ICA_2_TishLL/ICA_2023.sqlite")

# Query to Identify Top Three Developers
query <- "
SELECT 
    d.DeveloperID,
    COUNT(*) AS successful_projects
FROM 
    ProjectDevelopers pd
JOIN 
    Projects p ON pd.ProjectID = p.ProjectID
JOIN 
    Developers d ON pd.DeveloperID = d.DeveloperID
WHERE 
    p.Status = 'Completed'
GROUP BY 
    d.DeveloperID
ORDER BY 
    successful_projects DESC
LIMIT 3;
"

# Execute the query and store the result
Task3 <- dbGetQuery(con, query)

# Print the result stored in Task3
print(Task3)
