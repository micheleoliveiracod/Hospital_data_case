# 🏥 Hospital Analytics Dashboard | Power BI

## 📌 Overview

This project aims to analyze hospital data from both a strategic (financial) and operational (clinical) perspective, using Power BI to generate insights that support data-driven decision-making.

The dashboard was developed based on a public dataset available on Kaggle, simulating a real-world hospital management environment.
Link: https://www.kaggle.com/datasets/kanakbaghel/hospital-management-dataset?resource=download

---

## 🎯 Project Objectives

Analyze hospital financial performance
Identify key issues related to costs and revenue
Detect patterns of payment default
Evaluate operational efficiency in scheduling and service execution
Support data-driven decision-making

---

## 📊 Dashboard Structure

### 1. Strategic View

**Key metrics:** 

* Total Revenue
* Total Cost
* Gross Margin ($ and %)
* Average Ticket
* Profit
* EBITDA ($ and margin %)
* Valuation ($)
* Revenue, cost, and margin by procedure
* Percentage of payments by status
* Time series of payments by year and month

**Key analyses:** 

* Assess overall financial performance
* Identify potential pricing issues in medical procedures
* Detect problems in billing and payment collection processes

Note:

EBITDA and Valuation were estimated based on assumed operating expenses, as the dataset does not provide this information.

Physicians → 30% of revenue
Infrastructure → 20% of revenue
Administrative → 10% of revenue

Total: 60% of revenue as expenses

Operating Expenses = [Total Revenue] * 0.6

---

### 2. Tactical View

Key metrics:

* Payment Paid ($)
* Payment Failed ($)
* Payment Pending ($)
* Paid, pending, and failed amounts by payment method
* Paid, pending, and failed amounts by treatment type

**Key analyses:**

* Identify patterns in failed and pending payments by payment method
* Identify patterns in failed and pending payments by procedure

---

### 3. Operational View

**Key metrics:**

* Number of appointments over time
* Number of appointments by month and year
* Number of appointments by status

**Key analyses:**

* Identify operational bottlenecks
* Detect seasonality in appointments
* Evaluate cancellation rates

---

## 🧱 Data Modeling

**Star Schema**

Fact Table:

  * Appointments

Dimensions:

  * Patients
  * Doctors
  * Treatments
  * Billing

---

## 📈 Key Insights

  * Issues in the pricing strategy for medical procedures
  * Budgetary problems: the business is not self-sustaining and does not generate value
  * Financial process issues related to billing and collections, possibly linked to business rules
  * High rates of scheduled appointments and no-shows, indicating operational inefficiencies in scheduling management
  * Peaks in appointments during April and November, indicating seasonality in the analyzed period

---

## 🛠️ Tools Used

  * Power BI
  * DAX (Data Analysis Expressions)
  * Dimensional Modeling
  * Power Query (ELT)
  * Figma

---

## 📂 Repository Structure

````
├── 📁 data
│   └── appointments.csv
│   └── billing.csv
│   └── doctors.csv
│   └── patients.csv
│   └── treatments.csv
│
├── 📁 image
│   └── image-1.png
│
├── 📁 pbix
│   └── Hospital_data_case.pbix
│
├── 📁 documentation
│   └── dashboard_documentation.png
│
└── README.md
````

---

## 🖼️ Dashboard Preview

[image-1.png](https://github.com/micheleoliveiracod/Hospital_data_case/blob/main/images/image-1.png)

---

## 🚀 How to Run the Project

Download the .pbix file

Open it in Power BI Desktop

Refresh the data connections

Explore the dashboards

---

## 📄 License

All content is shared under the MIT License.
