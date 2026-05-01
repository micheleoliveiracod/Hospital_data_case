# 🏥 Hospital Analytics Dashboard | Power BI

## 📌 Overview

This project delivers an end-to-end analytics solution for a simulated hospital environment, covering financial performance, billing efficiency, and appointment operations across three hospital branches — Central Hospital, Westside Clinic, and Eastside Clinic.

The dashboard was built on a public dataset from Kaggle and structured around three analytical views — Strategic, Tactical, and Operational — each designed to answer specific business questions at different management levels.

> Dataset: [Hospital Management Dataset — Kaggle](https://www.kaggle.com/datasets/kanakbaghel/hospital-management-dataset?resource=download)

---

## 🎓 Academic & Portfolio Objectives

This project was built as a portfolio case to demonstrate practical skills in data analytics. The core learning objectives were:

- **Dimensional modeling** — design and implement a Star Schema with fact and dimension tables, applying best practices for Power BI performance
- **ETL pipeline** — extract raw CSV files, perform a full join using R and SQL, and load the transformed data into Power BI via Power Query
- **DAX measures** — build financial KPIs from scratch, including Gross Margin, EBITDA, Valuation, and operational metrics like cancellation rate and average waiting days
- **Analytical storytelling** — structure a multi-page dashboard that guides different stakeholders (C-level, finance, operations) through relevant insights for their decision layer
- **Business problem framing** — map a real-world hospital management scenario, identify stakeholders, define KPIs, and translate data into actionable recommendations
- **Documentation** — produce professional-grade technical documentation covering data dictionary, ETL process, DAX reference, user guide, and business insights

**Tools used:** Power BI Desktop · DAX · Power Query · R · SQL · Figma

---

## 📊 Dashboard Structure

### 1. Strategic View — Financial Performance
KPIs: Total Revenue, Total Cost, Gross Margin, EBITDA, Valuation, Average Ticket  
Focus: Overall financial health, procedure profitability, payment status distribution

### 2. Tactical View — Payment Analysis
KPIs: Paid, Pending, and Failed payment amounts  
Focus: Failure and default patterns by payment method (Insurance, Credit Card, Cash) and treatment type

### 3. Operational View — Appointment Management
KPIs: Completed, Cancelled, No-show, Scheduled, Average Waiting Days  
Focus: Scheduling efficiency, cancellation rates, seasonality, and operational bottlenecks

---

## 🖼️ Dashboard Preview

<img src="https://github.com/micheleoliveiracod/Hospital_data_case/blob/main/images/image.png" alt="Hospital Analytics Dashboard Preview" width="700">

---

## 📂 Repository Structure

````
├── 📁 data
│   └── appointments.csv
│   └── billing.csv
│   └── doctors.csv
│   └── patients.csv
│   └── treatments.csv
│   └── 📁 Join
│       └── script_join.R
│       └── unified_table_modified.csv
│
├── 📁 documentation
│   └── dashboard_documentation_PT.md
│   └── dashboard_documentation_EN.md
│
├── 📁 images
│   └── image2.png
│
├── 📁 pbix
│   └── Hospital_data_case.pbix
│
└── README.md
````

---

## 📄 License

All content is shared under the MIT License.