# 🧹 SQL Data Cleaning – Layoffs Dataset

## 📌 Project Overview

This project involves cleaning and preprocessing real-world layoff data using SQL to prepare it for analysis. I worked with a dataset containing global company layoffs and performed a comprehensive data cleaning pipeline in MySQL to prepare the data for further analysis.

The original dataset contained inconsistencies, duplicates, and missing values. The goal was to transform it into a clean, well-structured dataset suitable for exploratory data analysis and visualization.

---

## 🛠 Tools Used

- **MySQL**: Relational database used to store, query, and clean the dataset.
- **MySQL Workbench**: SQL IDE used to write, run, and test queries.

---

## 🧠 SQL Concepts & Techniques Applied

### 1. **Window Function – `ROW_NUMBER()`**
- Used to assign a unique number to each row based on a partition of columns.
- Purpose: Identify duplicate records in the dataset so they can be removed while retaining one clean copy.

### 2. **Common Table Expressions (CTEs)**
- Temporary result sets (using `WITH`) that make complex queries readable and modular.
- Purpose: Helped isolate duplicates or null values in multiple steps for cleaner logic and code reuse.

### 3. **String Functions – `TRIM()`, `REPLACE()`**
- Used to remove extra spaces or unify inconsistent text values.
- Purpose: Cleaned categorical fields like `company`, `industry`, and `country` for consistency.

### 4. **Date Conversion – `STR_TO_DATE()` and `ALTER TABLE`**
- Converted text-based dates (e.g., "03/21/2023") into proper `DATE` format.
- Purpose: Enabled date filtering, sorting, and time-based analysis later on.

### 5. **Self-Joins**
- A table joined to itself to fill in missing values.
- Purpose: Populated missing industry values by referencing rows with the same company and location but non-null industry values.

### 6. **NULL Handling**
- Identified and cleaned null or blank entries using `IS NULL`, `''`, and `UPDATE`.
- Purpose: Ensured data quality by addressing missing or incomplete fields.

### 7. **Data Filtering & Deletion**
- Removed rows with no meaningful data (e.g., both layoff metrics missing).
- Purpose: Increased dataset reliability by eliminating unusable entries.

---

## 📂 Dataset Description

The dataset includes information about layoffs at global companies, featuring:

- `company`
- `location`
- `industry`
- `total_laid_off`
- `percentage_laid_off`
- `date`
- `stage`
- `country`
- `funds_raised_millions`

---

## 🔧 Cleaning Steps Summary

1. **Removed Duplicates** using `ROW_NUMBER() OVER ()`
2. **Standardized Categorical Values** (trimmed, fixed inconsistent entries like "United States.", "Crypto startups", etc.)
3. **Converted Date Format** from text to SQL `DATE` type
4. **Filled Nulls** using self-joins based on matching company & location
5. **Dropped Temporary/Unnecessary Columns** like `row_num`
6. **Filtered Out Blank Rows** with no layoff data

---

## ✅ Outcome

- Original dataset contained **2,361** rows.
- Final cleaned dataset contains **1,995** rows.
- Ready for accurate exploratory analysis and dashboarding.

---

## 📁 Files Included

- `Data_cleaning.sql`: Full SQL script used for cleaning the dataset.
- `layoffs.xlsx`: Orginal dataset.
- `final_layoffs_dataset.xlsx` : Cleaned dataset.
- `README.md`: This documentation file.

---

## 🚀 Next Steps

In a follow-up project, I will use this cleaned dataset to perform SQL-based exploratory data analysis to extract meaningful business insights.

---

## 📬 Contact

**Manal Mosharaf**  
_Data Scientist  
📧 [mosharafmanal@gmail.com]  
🔗 [LinkedIn Profile or Portfolio Website]



