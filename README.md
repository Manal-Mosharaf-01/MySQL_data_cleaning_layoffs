# MySQL_data_cleaning_layoffs
This project demonstrates my ability to clean and prepare real-world data for analysis using SQL. I worked with a dataset containing global company layoffs and performed a full data cleaning workflow using MySQL.

# SQL Data Cleaning Project – Layoffs Dataset

## 📌 Objective
Clean raw layoff data using SQL to make it analysis-ready.

## 🛠️ Tools
- MySQL
- MySQL Workbench

## 🔍 Key Cleaning Steps
1. **Removed Duplicates** using `ROW_NUMBER() OVER ()`
2. **Standardized Strings** (trimmed, fixed typos, unified values like “United States”)
3. **Converted Data Types** (text to DATE format)
4. **Handled Null Values** by using self-joins
5. **Dropped Unnecessary Columns**

## 📈 Outcome
- Cleaned dataset with 2,356 records
- Accurate and consistent formatting ready for EDA

## 📂 Files
- `data_cleaning_layoffs.sql`: Full SQL cleaning script

