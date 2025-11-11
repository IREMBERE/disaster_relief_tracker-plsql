# disaster_relief_tracker-plsql
PL/SQL project that simulates a real-world disaster relief supply tracker using Collections, Records, and GOTO statements. Demonstrates structured data handling, conditional flow control, and reporting in Oracle Database.

# Disaster Relief Supply Tracker (PL/SQL Project)

### "Tracking hope, not just supplies."

---

## Overview

During emergencies or natural disasters, relief organizations must track the movement of supplies such as food, tents, water, and medical kits.  
This project demonstrates how such tracking can be simulated using **PL/SQL Collections**, **Records**, and **GOTO statements** in Oracle Database.

The program processes a list of deliveries, calculates total delivered and failed weights, skips failed deliveries using `GOTO`, and prints a clean summary report.  

It’s not just an exercise in coding — it’s a small glimpse of how data systems can support real-world humanitarian operations.

---

## 🎯 Objectives

This project was designed to:
- Demonstrate **PL/SQL Records** to hold structured data (like delivery info).
- Use **Collections (Nested Tables)** to store multiple records dynamically.
- Show how **GOTO statements** can control program flow (for skipping failed cases).
- Generate a **summary report** using `DBMS_OUTPUT`.

---

## Technologies Used

| Tool / Language                    | Purpose                                 |
|------------------------------------|-----------------------------------------|
| **Oracle Database (19c)**          | To run and store the PL/SQL program     |
| **SQL Developer / SQL*Plus**       | To execute and test PL/SQL scripts      |
| **PL/SQL**                         | For writing the logic and output report |



## Project Files

| File                      |               Description                               |
|---------------------------|---------------------------------------------------------|
| `relief_tracker.sql`      | Main PL/SQL script that runs the program                |
| `README.md`               | Documentation file (this one)                           |
| `relief_report_table.sql` | Script for creating a permanent results table if needed |



## How It Works

1. **Record Definition**  
   A `RECORD` structure is created to represent each delivery, containing:
   - `location_name`
   - `item_type`
   - `weight_kg`
   - `status`

2. **Collection (Table of Records)**  
   A nested table is declared to store all delivery records.

3. **Processing Deliveries**  
   The program loops through all deliveries:
   - If a delivery **failed**, it’s skipped using `GOTO`.
   - If **delivered**, it adds its weight to the total delivered kilograms.

4. **Report Generation**  
   At the end, the program prints a formatted report showing totals and statuses.

---

## Sample Output


