🧹 SQL Data Cleaning Project: Global Layoffs (2022–2023)
📊 Dataset
Source: Kaggle - Layoffs 2022

A global dataset capturing company layoffs during the economic downturn of 2022 and 2023

🎯 Project Goal
Clean the raw data using SQL for reliable analysis:

Remove duplicate rows

Standardize text fields (company names, countries, industries)

Convert date formats

Handle missing/null values

Finalize a clean, analysis-ready dataset

🛠️ Tools Used
MySQL Workbench

SQL (CTEs, UPDATE, DELETE, ROW_NUMBER, JOINS)

Kaggle CSV to SQL import

🧽 Data Cleaning Steps
Created a staging table to preserve the original dataset

Removed duplicates using ROW_NUMBER() and partitioning

Trimmed company names and removed inconsistencies

Standardized industry labels (e.g., unified "Crypto" variations)

Cleaned country names (e.g., removed trailing punctuation)

Fixed date format and converted TEXT → DATE

Filled missing industry values by joining on company names

Removed rows with no layoff info

Dropped unnecessary helper columns after cleanup

✅ Final Table
Clean and consistent structure ready for:

Exploratory Data Analysis (EDA)

Visualization

Reporting
