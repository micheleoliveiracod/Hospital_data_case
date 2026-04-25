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

**Metrics and indicators:** 

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

**Analyses:** 

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

**Metrics and indicators:**

* Payment Paid ($)
* Payment Failed ($)
* Payment Pending ($)
* Paid, pending, and failed amounts by payment method
* Paid, pending, and failed amounts by treatment type

**Analyses:**

* Identify patterns in failed and pending payments by payment method.
* Identify patterns in failed and pending payments by procedure.
* Why do we have a high number of pending and failed payments in insurance payment methods?
* Is this result related to the hospital's business rules or conventions? What can you do to improve this indicator?
* Why do we have a high number of pending and failed payments with the cash payment method?
* Is credit analysis being done at the time of treatment scheduling? What are the business rules for this payment method?

---

### 3. Operational View

**Metrics and indicators:**

* Days of waiting 
* Completed
* Cancelled
* No-show
* Scheduled
* Number of appointments over time
* Number of appointments by month and year
* Number of appointments by status
* Waiting time by type of treatment

**Analyses:**

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

## 📈 Insights

* Current situation: the business is not self-sustaining and does not generate value.
* Investigate the pricing method for procedures.
* Investigate the financial processes related to billing, possibly based on business rules.
* Investigate a significant number of canceled appointments and no-show appointments, indicating operational inefficiency in appointment management.
* Peaks in appointments in April and November, with a possible drop due to seasonality.

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
│   └── 📁 Join
│       └── script_join.r
│       └── unified_table_modified.csv
│
├── 📁 images
│   └── image2.png
│
├── 📁 pbix
│   └── Hospital_data_case.pbix
│
├── 📁 documentation
│   └── dashboard_documentation.pdf
│
└── README.md
````

---

## 🖼️ Dashboard Preview

<img src="https://github.com/micheleoliveiracod/Hospital_data_case/blob/main/images/image2.png" alt="Texto alternativo" width="700">

---

## 🚀 How to Run the Project

Download the .pbix file

Open it in Power BI Desktop

Refresh the data connections

Explore the dashboards

---

## 📄 License

All content is shared under the MIT License.
