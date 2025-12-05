# 📚 Library Management System (SQL Project)

### 👤 Author: Mohammad Kaif Firoz  
A complete SQL-based Library Management System built using real-world database concepts such as  
Joins, Constraints, CRUD operations, Stored Procedures, CTAS, and Analytical Queries.

---

## ⭐ Project Overview  
This project simulates the backend of a library, allowing efficient management of:

- Books  
- Members  
- Employees  
- Branches  
- Issued books  
- Returned books  

The system supports operational tasks (issue/return flow) and analytical insights  
(overdue books, branch performance, active members, fine calculation).

---

## 🛠️ **Database Design (6 Normalized Tables)**  
The schema includes:

- **branch** – Branch details  
- **employees** – Staff working under each branch  
- **members** – Library members  
- **books** – Book catalog  
- **issued_status** – Issued book records  
- **return_status** – Returned book records  

Foreign-key relationships ensure data consistency.

---

## 🔹 Core Work Done
- Created 6 linked tables with constraints  
- Performed CRUD operations (insert, update, delete, select)  
- Designed **stored procedures**  
  - `issue_book` – Manages book issuing with availability check  
  - `add_return_records` – Updates return record & sets status back to "yes"  
- Built **CTAS tables** for insights (book_issued_cnt, active_members, branch_performance)  
- Used joins, date functions & conditional logic  
- Implemented overdue book identification & fine calculation  

---

## 🔧 Advanced SQL Used
- Stored Procedures  
- CTAS (Create Table As Select)  
- LEFT JOIN for pending returns  
- Window Functions (in some tasks)  
- Date arithmetic  
- Grouping & Aggregation  
- Foreign key relationships  

---

## 📊 Key Insights Derived
- Branch-wise performance (issues, returns, revenue)  
- Active members in the last 2 months  
- Top employees with the highest issues processed  
- Overdue books + fine calculation logic  
- Books not yet returned  
- Category-wise revenue  

---

## 💼 Business Value
- Automated book issuing & returning  
- Improved branch performance tracking  
- Fine calculation ensures revenue integrity  
- Real-time overdue detection improves operations  
- Provides a scalable backend structure for a real library system  

---

## 📂 Project Files Included
- SQL schema  
- All queries (CRUD + analytics)  
- Stored procedures  
- CTAS summary tables  
- Overdue summary logic  

---

## 🚀 How to Run
1. Create a new database  
2. Run table creation scripts  
3. Insert sample data  
4. Run procedures and analytical queries

---

## 👨‍💻 Author  
**Mohammad Kaif Firoz**  
SQL • Excel • Tableau • Power BI • Python  
