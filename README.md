# 🧹 SQL Data Cleaning Project: Global Layoffs (2022–2023)

## 📊 Dataset
- **Source**: [Kaggle - Layoffs 2022](https://www.kaggle.com/datasets/swaptr/layoffs-2022)
- The dataset captures global layoff data across companies during 2022–2023, including details like company, location, number laid off, date, stage, industry, and more.

---

## 🎯 Project Objective
To clean and prepare the raw layoff dataset for analysis using **MySQL**, following professional data cleaning practices:
- Remove duplicate records
- Standardize and correct text fields
- Handle nulls and blanks
- Format dates correctly
- Ensure the dataset is analysis-ready

---

## 🛠️ Tools Used
- MySQL Workbench
- SQL queries (CTE, ROW_NUMBER, UPDATE, DELETE, JOIN, etc.)
- Kaggle dataset imported as a table in MySQL

---

## 🧼 Cleaning Steps Summary

1. **Created a staging table** to preserve the raw data
2. **Removed duplicates** using `ROW_NUMBER()` within a CTE
3. **Trimmed whitespace** from `company` names
4. **Standardized `industry` values** (e.g., grouped all "Crypto" variations)
5. **Fixed `country` formatting**, like removing periods
6. **Converted `date` column** from text to `DATE` format
7. **Handled missing values** by:
   - Setting blanks to `NULL`
   - Filling in missing industry names via a self-join on company
8. **Deleted rows** with no layoff info (`total_laid_off` and `percentage_laid_off` both NULL)
9. **Dropped helper column** `row_num` after removing duplicates

---

## 📁 Project Structure

| File | Description |
|------|-------------|
| `Data Cleaning Project.sql` | Full SQL script used to clean the dataset step by step |

---

## ✅ Final Result
The cleaned table `layoffs_staging6` is now ready for:
- Exploratory Data Analysis (EDA)
- Business insights
- Dashboard visualization

---

## 🙌 Acknowledgements
- Project inspired by **Alex The Analyst**'s SQL Bootcamp on YouTube.
- Dataset provided by **swaptr** on Kaggle.

