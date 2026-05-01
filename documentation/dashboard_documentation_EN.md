# Hospital Analytics Dashboard — Technical Documentation & User Guide

**Version:** 1.0  
**Date:** May 2026  
**Author:** Michele Oliveira  
**Tool:** Power BI Desktop  
**Dataset:** Kaggle — Hospital Management Dataset  
**Repository:** [GitHub](https://github.com/micheleoliveiracod/Hospital_data_case)

---

## Table of Contents

1. [Business Context and Problem Statement](#1-business-context-and-problem-statement)
2. [Stakeholders](#2-stakeholders)
3. [Dashboard Objectives](#3-dashboard-objectives)
4. [Data Sources and ETL](#4-data-sources-and-etl)
5. [Data Modeling](#5-data-modeling)
6. [Dashboard Structure](#6-dashboard-structure)
7. [User Guide](#7-user-guide)
8. [Calculation Reference (DAX)](#8-calculation-reference-dax)
9. [Insights and Recommendations](#9-insights-and-recommendations)
10. [Limitations and Assumptions](#10-limitations-and-assumptions)
11. [How to Run the Project](#11-how-to-run-the-project)
12. [Glossary](#12-glossary)

---

## 1. Business Context and Problem Statement

### 1.1 Scenario

The hospital operates across three units — **Central Hospital**, **Westside Clinic**, and **Eastside Clinic** — serving patients across multiple medical specialties (Pediatrics, Dermatology, and Oncology). The business model involves appointment scheduling, clinical procedure delivery, and billing through different payment methods (insurance, credit card, and cash).

Management identified difficulties in answering critical questions quickly:

- Is the hospital generating profit or operating at a loss?
- Which procedures are most profitable?
- Why are so many payments pending or failing?
- What is the cancellation and no-show rate for appointments?
- Are there operational bottlenecks in the scheduling process?

Without centralized visibility into these indicators, strategic and operational decisions were being made based on isolated spreadsheets, with no integration between the financial and clinical areas.

### 1.2 Core Problem

> **The hospital lacks an integrated monitoring mechanism that connects financial performance, billing efficiency, and appointment operational efficiency into a single analytical view.**

This results in:

- Inability to identify procedures with negative margins
- Accumulation of bad debt without tracking by payment method
- High rate of cancelled and no-show appointments without root cause analysis
- No mapped seasonality for capacity planning

---

## 2. Stakeholders

| Stakeholder | Profile | Primary Interest | Relevant View |
|---|---|---|---|
| **Executive Board** | C-Level / Strategic Management | Profitability, valuation, and business sustainability | Strategic |
| **Financial Management** | Controller / CFO | Revenue, bad debt, payment methods, margin | Strategic + Tactical |
| **Operations Management** | COO / Clinical Coordinator | Cancellation rate, no-show, waiting time | Operational |
| **Billing Team** | Billing Analysts | Payment status, method failures, pending amounts | Tactical |
| **Physicians & Clinical Coordinators** | Specialists | Appointment volume, procedure types | Operational |
| **Data / BI Analysts** | Technical Team | Model maintenance, data refresh, DAX | Technical |

---

## 3. Dashboard Objectives

### General Objective
Provide an integrated analytical platform to monitor the hospital's financial and operational health, supporting data-driven decisions across three management layers: strategic, tactical, and operational.

### Specific Objectives

| # | Objective | Primary KPI |
|---|---|---|
| 1 | Assess overall financial performance | Total Revenue, Gross Margin, EBITDA |
| 2 | Identify procedures with pricing issues | Revenue and Cost by Treatment Type |
| 3 | Detect bad debt and payment failure patterns | % Failed and Pending Payments by Method |
| 4 | Monitor appointment scheduling efficiency | Cancellation Rate, No-show, Waiting Time |
| 5 | Identify demand seasonality | Appointment Volume by Month/Year |


---

## 4. Data Sources and ETL

### 4.1 Data Origin

The data used in this project comes from a public dataset available on Kaggle:

> **Hospital Management Dataset**  
> Author: Kanak Baghel  
> Link: https://www.kaggle.com/datasets/kanakbaghel/hospital-management-dataset  
> License: Educational and portfolio use

The dataset simulates a real hospital management environment with 200 records per table, covering the period from **January to December 2023**.

### 4.2 Source Tables

| File | Records | Description |
|---|---|---|
| `appointments.csv` | 200 | Appointment scheduling records |
| `billing.csv` | 200 | Billing charges and payment status |
| `doctors.csv` | 10 | Physician registry |
| `patients.csv` | 50 | Patient registry |
| `treatments.csv` | 200 | Performed procedures |

### 4.3 Data Dictionary

#### Table: appointments

| Field | Type | Description | Example |
|---|---|---|---|
| `appointment_id` | TEXT (PK) | Unique appointment identifier | A001 |
| `patient_id` | TEXT (FK) | Reference to patient | P034 |
| `doctor_id` | TEXT (FK) | Reference to physician | D009 |
| `appointment_date` | DATE | Appointment date | 2023-08-09 |
| `appointment_time` | TIME | Appointment time | 15:15:00 |
| `reason_for_visit` | TEXT | Reason for the visit | Therapy, Consultation, Emergency, Follow-up, Checkup |
| `status` | TEXT | Appointment status | Scheduled, Completed, Cancelled, No-show |

#### Table: billing

| Field | Type | Description | Example |
|---|---|---|---|
| `bill_id` | TEXT (PK) | Unique billing identifier | B001 |
| `patient_id` | TEXT (FK) | Reference to patient | P034 |
| `treatment_id` | TEXT (FK) | Reference to treatment | T001 |
| `bill_date` | DATE | Billing date | 2023-08-09 |
| `amount` | DECIMAL | Amount charged (USD) | 3941.97 |
| `payment_method` | TEXT | Payment method | Insurance, Credit Card, Cash |
| `payment_status` | TEXT | Payment status | Paid, Pending, Failed |

#### Table: doctors

| Field | Type | Description | Example |
|---|---|---|---|
| `doctor_id` | TEXT (PK) | Unique physician identifier | D001 |
| `first_name` | TEXT | First name | David |
| `last_name` | TEXT | Last name | Taylor |
| `specialization` | TEXT | Medical specialty | Dermatology, Pediatrics, Oncology |
| `phone_number` | TEXT | Contact phone | 8322010158 |
| `years_experience` | INT | Years of experience | 17 |
| `hospital_branch` | TEXT | Hospital unit | Westside Clinic, Eastside Clinic, Central Hospital |
| `email` | TEXT | Professional email | dr.david.taylor@hospital.com |

#### Table: patients

| Field | Type | Description | Example |
|---|---|---|---|
| `patient_id` | TEXT (PK) | Unique patient identifier | P001 |
| `first_name` | TEXT | First name | David |
| `last_name` | TEXT | Last name | Williams |
| `gender` | TEXT | Gender | M, F |
| `date_of_birth` | DATE | Date of birth | 1955-06-04 |
| `contact_number` | TEXT | Contact phone | 6939585183 |
| `address` | TEXT | Address | 789 Pine Rd |
| `registration_date` | DATE | Hospital registration date | 2022-06-23 |
| `insurance_provider` | TEXT | Health insurance provider | WellnessCorp, PulseSecure, HealthIndia, MedCare Plus |
| `insurance_number` | TEXT | Policy number | INS840674 |
| `email` | TEXT | Patient email | david.williams@mail.com |

#### Table: treatments

| Field | Type | Description | Example |
|---|---|---|---|
| `treatment_id` | TEXT (PK) | Unique treatment identifier | T001 |
| `appointment_id` | TEXT (FK) | Reference to appointment | A001 |
| `treatment_type` | TEXT | Procedure type | Chemotherapy, MRI, ECG, X-Ray, Physiotherapy |
| `description` | TEXT | Protocol level | Basic screening, Standard procedure, Advanced protocol |
| `cost` | DECIMAL | Procedure cost (USD) | 3941.97 |
| `treatment_date` | DATE | Treatment date | 2023-08-09 |

### 4.4 ETL Process (Extract, Transform, Load)

#### Step 1 — Extract

The five CSV files were extracted from Kaggle and stored locally in the `/data` folder. A join between the `appointments` and `treatments` tables was performed in R beforehand, generating the `unified_table_modified.csv` file in the `/data/Join` folder.

**R script used (`script_join.R`):**

```r
# Load libraries
library(DBI); library(RSQLite); library(readr); library(dplyr)

# Read CSVs
appointments <- read_csv("appointments.csv")
treatments   <- read_csv("treatments.csv")

# Full join between appointments and treatments
JOIN <- full_join(appointments, treatments, by = "appointment_id")
write_csv(JOIN, "tabela_unificada.csv")
```

SQL equivalent:

```sql
SELECT *
FROM treatments
FULL JOIN appointments ON treatments.appointment_id = appointments.appointment_id
```

#### Step 2 — Transform (Power Query)

After importing the CSVs into Power BI, the following transformations were applied via Power Query (M Language):

| Transformation | Table | Description |
|---|---|---|
| Data type definition | All | Dates as `Date`, amounts as `Decimal Number`, IDs as `Text` |
| Categorical value standardization | Appointments, Billing | Consistency check on `status` and `payment_status` fields |
| Table relationships | All | Definition of primary and foreign keys in the model |

#### Step 3 — Load

Tables were loaded into the Power BI model following the Star Schema, with the `Appointments` table as the central fact table and the others as dimensions.


---

## 5. Data Modeling

### 5.1 Model Diagram (Star Schema)

```
                    ┌─────────────┐
                    │   PATIENTS  │
                    │ (Dimension) │
                    └──────┬──────┘
                           │ patient_id
                           │
┌─────────────┐    ┌───────▼──────────┐    ┌─────────────┐
│   DOCTORS   │    │   APPOINTMENTS   │    │  TREATMENTS │
│ (Dimension) ├────►      (Fact)      ◄────┤ (Dimension) │
└─────────────┘    └───────┬──────────┘    └─────────────┘
    doctor_id              │ appointment_id     treatment_id
                           │
                    ┌──────▼──────┐
                    │   BILLING   │
                    │ (Dimension) │
                    └─────────────┘
                       patient_id
                      treatment_id
```

### 5.2 Fact Table

**Appointments** is the central table of the model. Each row represents a scheduling event, connecting a patient, a physician, and — indirectly via `treatment_id` — the performed procedure and its corresponding billing record.

| Attribute | Value |
|---|---|
| Granularity | 1 row = 1 appointment |
| Records | 200 |
| Primary Key | `appointment_id` |
| Foreign Keys | `patient_id`, `doctor_id` |

### 5.3 Dimension Tables

| Table | Role | PK | Relationship with Fact |
|---|---|---|---|
| **Patients** | Patient dimension | `patient_id` | Appointments.patient_id → Patients.patient_id |
| **Doctors** | Physician dimension | `doctor_id` | Appointments.doctor_id → Doctors.doctor_id |
| **Treatments** | Procedure dimension | `treatment_id` | Treatments.appointment_id → Appointments.appointment_id |
| **Billing** | Billing dimension | `bill_id` | Billing.treatment_id → Treatments.treatment_id |

### 5.4 Relationship Cardinality

| Relationship | Cardinality | Filter Direction |
|---|---|---|
| Appointments → Patients | Many to One (N:1) | Single (Patients → Appointments) |
| Appointments → Doctors | Many to One (N:1) | Single (Doctors → Appointments) |
| Treatments → Appointments | One to One (1:1) | Single |
| Billing → Treatments | One to One (1:1) | Single |

### 5.5 Model Notes

- The relationship between `Billing` and `Appointments` is indirect, passing through `Treatments`. To cross financial data with scheduling data, the path is: `Billing → Treatments → Appointments`.
- The `amount` field in `Billing` and the `cost` field in `Treatments` hold identical values in the dataset, indicating that the treatment cost is passed directly to the patient as the billed amount — with no explicit markup in the dataset.

---

## 6. Dashboard Structure

The dashboard consists of **three analytical views**, each targeting a specific user profile and decision-making level.

### 6.1 Strategic View — Financial Performance

**Target audience:** Executive Board, CFO, Senior Management  
**Objective:** Assess the hospital's financial health and identify structural profitability issues.

#### KPIs

| Indicator | Description | Source |
|---|---|---|
| **Total Revenue** | Sum of all billed amounts (`billing.amount`) | Billing table |
| **Total Cost** | Sum of all treatment costs (`treatments.cost`) | Treatments table |
| **Gross Margin ($)** | Total Revenue − Total Cost | Calculated (DAX) |
| **Gross Margin (%)** | (Gross Margin / Total Revenue) × 100 | Calculated (DAX) |
| **Average Ticket** | Total Revenue / Number of Bills | Calculated (DAX) |
| **Operating Expenses** | 60% of Total Revenue (assumed premise) | Calculated (DAX) |
| **EBITDA ($)** | Gross Margin − Operating Expenses | Calculated (DAX) |
| **EBITDA Margin (%)** | (EBITDA / Total Revenue) × 100 | Calculated (DAX) |
| **Valuation ($)** | EBITDA × Market Multiple (premise) | Calculated (DAX) |

#### Visualizations

| Visual | Type | Description |
|---|---|---|
| KPI Cards | Card | Revenue, Cost, Margin, EBITDA, Valuation |
| Revenue and Cost by Procedure | Clustered Bar Chart | Comparison by treatment type |
| Margin by Procedure | Bar Chart | Identification of loss-making procedures |
| Payment Status | Donut / Pie Chart | % Paid, Pending, Failed |
| Payment Time Series | Line Chart | Monthly evolution of revenue and billing |

---

### 6.2 Tactical View — Payment Analysis

**Target audience:** Financial Management, Billing Team  
**Objective:** Identify failure and bad debt patterns by payment method and procedure type.

#### KPIs

| Indicator | Description |
|---|---|
| **Payments Received ($)** | Sum of amounts where `payment_status = 'Paid'` |
| **Pending Payments ($)** | Sum of amounts where `payment_status = 'Pending'` |
| **Failed Payments ($)** | Sum of amounts where `payment_status = 'Failed'` |

#### Visualizations

| Visual | Type | Description |
|---|---|---|
| Status Cards | Card | Total amounts by payment status |
| Payments by Method | Stacked Bar Chart | Paid/Pending/Failed by Insurance, Credit Card, Cash |
| Payments by Treatment | Stacked Bar Chart | Paid/Pending/Failed by procedure type |
| Detail Table | Table | Drill-down by patient, method, and status |

#### Questions this view answers

- Why does **Insurance** concentrate a high volume of pending payments?
- Why does **Cash** show a high failure rate?
- Which procedures have the highest bad debt rate?
- Is there a correlation between treatment type and problematic payment method?

---

### 6.3 Operational View — Appointment Management

**Target audience:** Clinical Coordinators, Operations Management  
**Objective:** Monitor appointment scheduling efficiency and identify bottlenecks.

#### KPIs

| Indicator | Description |
|---|---|
| **Waiting Days** | Difference between `appointment_date` and `treatment_date` |
| **Completed Appointments** | Count of `status = 'Completed'` |
| **Cancelled Appointments** | Count of `status = 'Cancelled'` |
| **No-show** | Count of `status = 'No-show'` |
| **Scheduled Appointments** | Count of `status = 'Scheduled'` |

#### Visualizations

| Visual | Type | Description |
|---|---|---|
| Status Cards | Card | Totals by appointment status |
| Appointment Volume Over Time | Line Chart | Monthly volume evolution |
| Appointments by Month and Year | Bar Chart | Seasonality and year-over-year comparison |
| Appointments by Status | Bar Chart | Distribution by status |
| Waiting Time by Treatment | Bar Chart | Average waiting days by procedure type |

#### Questions this view answers

- Which months concentrate the highest appointment volume?
- What is the cancellation and no-show rate?
- Which procedures have the longest waiting times?
- Is there seasonality that justifies capacity planning?


---

## 7. User Guide

### 7.1 Access Requirements

| Requirement | Details |
|---|---|
| Software | Power BI Desktop (latest version recommended) |
| File | `Hospital_data_case.pbix` (folder `/pbix`) |
| Data | CSV files in the `/data` folder (required for refresh) |
| Operating System | Windows 10 or later |

### 7.2 How to Open the Dashboard

1. Download the repository or clone it via Git:
   ```bash
   git clone https://github.com/micheleoliveiracod/Hospital_data_case.git
   ```
2. Open Power BI Desktop.
3. Go to **File → Open** and select `pbix/Hospital_data_case.pbix`.
4. If prompted, update the data source path to point to the `/data` folder in the cloned repository.
5. Click **Refresh** to load the latest data.

### 7.3 Navigating Between Views

The dashboard has **three pages** accessible via the navigation panel or the tabs at the bottom of Power BI:

| Tab | Name | Target User |
|---|---|---|
| 1 | Strategic View | Executive Board / CFO |
| 2 | Tactical View | Finance / Billing |
| 3 | Operational View | Operations / Clinical |

### 7.4 Using Filters (Slicers)

Each view has interactive filters that allow data segmentation. Selecting a value in any filter **automatically updates all visuals on the page**.

#### Available Filters

| Filter | Location | Possible Values |
|---|---|---|
| **Period (Month/Year)** | All views | Jan–Dec 2023 |
| **Treatment Type** | Strategic and Tactical | Chemotherapy, MRI, ECG, X-Ray, Physiotherapy |
| **Payment Method** | Tactical | Insurance, Credit Card, Cash |
| **Payment Status** | Tactical | Paid, Pending, Failed |
| **Appointment Status** | Operational | Completed, Cancelled, No-show, Scheduled |
| **Hospital Branch** | All views | Central Hospital, Westside Clinic, Eastside Clinic |
| **Medical Specialty** | Operational | Dermatology, Pediatrics, Oncology |

### 7.5 How to Interpret KPIs

#### Strategic View

| KPI | Interpretation | Warning Signal |
|---|---|---|
| **Total Revenue** | Total billed in the selected period | Month-over-month decline |
| **Gross Margin (%)** | If negative, procedure costs exceed revenue | Negative value |
| **EBITDA** | Estimated operating result after expenses | Negative value indicates unsustainability |
| **% Paid Payments** | Proportion of billing actually collected | Below 50% is critical |

#### Tactical View

| KPI | Interpretation | Warning Signal |
|---|---|---|
| **Failed Payments ($)** | Amount lost due to billing process failures | Continuous growth |
| **Pending Payments ($)** | Open amount, still recoverable | High volume in Insurance |
| **Failures by Method** | Identifies which payment channel is most problematic | Cash with high failure rate |

#### Operational View

| KPI | Interpretation | Warning Signal |
|---|---|---|
| **No-show Rate** | % of patients who did not show up without notice | Above 20% |
| **Cancellation Rate** | % of cancelled appointments | Above 25% |
| **Waiting Days** | Average time between scheduling and treatment | Above 30 days |

### 7.6 Drill-down Features

In time series and bar charts, you can navigate between granularity levels:

- **Double-click** on a bar or point: drills down to the next level (e.g., Year → Month → Day)
- **Hierarchy button** (down arrow at the top of the visual): expands all levels
- **Ctrl + Click** on an element: applies cross-filter to other visuals on the page

### 7.7 Exporting Data

To export data from any visual:
1. Right-click on the desired visual.
2. Select **Export data**.
3. Choose the format: `.xlsx` (Excel) or `.csv`.


---

## 8. Calculation Reference (DAX)

This section documents all DAX measures created in the model, including their formula, description, and usage context.

### 8.1 Financial Measures — Strategic View

---

#### Total Revenue
```dax
Total Revenue = SUM(billing[amount])
```
**Description:** Sum of all billed amounts in the billing table, regardless of payment status. Represents total invoiced revenue (not necessarily collected).  
**Source table:** `billing`  
**Field:** `amount`

---

#### Total Cost
```dax
Total Cost = SUM(treatments[cost])
```
**Description:** Sum of all procedure costs. In the dataset, treatment cost equals the amount billed to the patient.  
**Source table:** `treatments`  
**Field:** `cost`

---

#### Gross Margin ($)
```dax
Gross Margin = [Total Revenue] - [Total Cost]
```
**Description:** Difference between billed revenue and procedure costs. Indicates whether the hospital charges above or below its clinical operating cost.  
**Note:** Since `billing.amount` = `treatments.cost` in the dataset, this measure tends to zero, highlighting the absence of markup in pricing.

---

#### Gross Margin (%)
```dax
Gross Margin % = 
DIVIDE([Gross Margin], [Total Revenue], 0)
```
**Description:** Gross margin as a percentage of total revenue. Uses `DIVIDE` to avoid division-by-zero errors.

---

#### Average Ticket
```dax
Average Ticket = 
DIVIDE([Total Revenue], COUNTROWS(billing), 0)
```
**Description:** Average value per billing record issued. Useful for benchmarking against healthcare industry standards.

---

#### Operating Expenses (Assumed Premise)
```dax
Operating Expenses = [Total Revenue] * 0.6
```
**Description:** Estimated operating expenses based on assumed premises, since the dataset does not provide real expense data. Breakdown:
- Physicians: 30% of revenue
- Infrastructure: 20% of revenue
- Administrative: 10% of revenue
- **Total: 60% of revenue**

---

#### EBITDA ($)
```dax
EBITDA = [Gross Margin] - [Operating Expenses]
```
**Description:** Earnings Before Interest, Taxes, Depreciation and Amortization. Estimated based on the operating expense premises.

---

#### EBITDA Margin (%)
```dax
EBITDA Margin % = 
DIVIDE([EBITDA], [Total Revenue], 0)
```
**Description:** EBITDA as a percentage of total revenue. Indicates the hospital's operational efficiency.

---

#### Valuation ($)
```dax
Valuation = [EBITDA] * [EV/EBITDA Multiple]
```
**Description:** Estimated market value of the hospital based on the EV/EBITDA multiple. The multiple used is an assumed premise based on healthcare industry benchmarks (typically 8x to 12x for hospitals).  
**Note:** This is an estimated indicator for analytical and portfolio purposes. It does not represent a formal financial valuation.

---

### 8.2 Payment Measures — Tactical View

---

#### Total Paid
```dax
Total Paid = 
CALCULATE(
    SUM(billing[amount]),
    billing[payment_status] = "Paid"
)
```
**Description:** Sum of amounts effectively received by the hospital.

---

#### Total Pending
```dax
Total Pending = 
CALCULATE(
    SUM(billing[amount]),
    billing[payment_status] = "Pending"
)
```
**Description:** Sum of open amounts that may still be recovered.

---

#### Total Failed
```dax
Total Failed = 
CALCULATE(
    SUM(billing[amount]),
    billing[payment_status] = "Failed"
)
```
**Description:** Sum of amounts with billing process failures. Represents potential financial loss.

---

#### % Paid Payments
```dax
% Paid Payments = 
DIVIDE([Total Paid], [Total Revenue], 0)
```
**Description:** Proportion of the amount effectively collected over total billed revenue.

---

#### % Failed Payments
```dax
% Failed Payments = 
DIVIDE([Total Failed], [Total Revenue], 0)
```
**Description:** Proportion of failed billing over total revenue. Critical financial risk indicator.

---

### 8.3 Operational Measures — Operational View

---

#### Total Appointments
```dax
Total Appointments = COUNTROWS(appointments)
```
**Description:** Total count of records in the appointments table.

---

#### Completed Appointments
```dax
Completed Appointments = 
CALCULATE(
    COUNTROWS(appointments),
    appointments[status] = "Completed"
)
```

---

#### Cancelled Appointments
```dax
Cancelled Appointments = 
CALCULATE(
    COUNTROWS(appointments),
    appointments[status] = "Cancelled"
)
```

---

#### No-show
```dax
No-show = 
CALCULATE(
    COUNTROWS(appointments),
    appointments[status] = "No-show"
)
```

---

#### Cancellation Rate (%)
```dax
Cancellation Rate % = 
DIVIDE([Cancelled Appointments], [Total Appointments], 0)
```
**Description:** Percentage of cancelled appointments over total scheduled.

---

#### No-show Rate (%)
```dax
No-show Rate % = 
DIVIDE([No-show], [Total Appointments], 0)
```
**Description:** Percentage of patients who did not show up without prior cancellation.

---

#### Average Waiting Days
```dax
Average Waiting Days = 
AVERAGEX(
    unified_table_modified,
    DATEDIFF(
        unified_table_modified[appointment_date],
        unified_table_modified[treatment_date],
        DAY
    )
)
```
**Description:** Average number of days between the appointment date and the treatment date. Calculated over the unified table that contains both dates.


---

## 9. Insights and Recommendations

### 9.1 Financial Diagnosis

#### Issue: No Markup in Procedure Pricing

In the dataset, the `billing.amount` field is identical to `treatments.cost`, indicating the hospital charges exactly the procedure cost with no profit margin. Combined with estimated operating expenses of 60% of revenue, the business operates with a **negative EBITDA**.

**Recommendation:** Review the procedure pricing policy. Healthcare industry benchmarks suggest gross margins between 20% and 40% for mid-sized hospitals.

---

#### Issue: High Volume of Failed and Pending Payments

The payment status distribution reveals that a significant portion of billing is not converted into effective revenue:

| Status | Characteristic |
|---|---|
| **Paid** | Confirmed revenue |
| **Pending** | Concentrated in Insurance — indicates delayed reimbursement from insurers |
| **Failed** | Concentrated in Cash — indicates absence of prior credit analysis |

**Recommendations:**
- **Insurance (Pending):** Review contracts with health insurance providers and reimbursement timelines. Implement an automated follow-up process with insurers.
- **Cash (Failed):** Implement credit analysis or require an upfront deposit for cash payments. Evaluate whether the Cash method should be maintained for high-cost procedures.

---

### 9.2 Operational Diagnosis

#### Issue: High Cancellation and No-show Rate

Appointment analysis reveals that a relevant proportion of consultations do not result in effective care, either through cancellation or patient absence.

**Recommendations:**
- Implement automated reminder systems (SMS/email) 24h and 2h before the appointment.
- Create a presence confirmation policy with a minimum 24h advance notice.
- Analyze whether cancellations are concentrated around a specific physician, specialty, or time slot.
- Consider creating a waiting list to fill cancelled slots.

---

#### Issue: Seasonality in April and November

Appointment peaks were identified in **April** and **November**, with a possible drop in other periods.

**Recommendations:**
- Plan care capacity in advance for peak months.
- Investigate the causes of seasonality (health campaigns, holidays, insurance plan renewals).
- Create demand generation strategies for low-demand months.

---

### 9.3 Executive Summary of Insights

| # | Insight | Impact | Urgency |
|---|---|---|---|
| 1 | Business is not self-sustaining with current pricing | High | Critical |
| 2 | Insurance payments with high pending rate | High | High |
| 3 | Cash payments with high failure rate | Medium | High |
| 4 | High no-show and cancellation rate | Medium | Medium |
| 5 | Unmanaged seasonality in April and November | Low | Low |

---

## 10. Limitations and Assumptions

### 10.1 Dataset Limitations

| Limitation | Impact |
|---|---|
| Simulated dataset (not real) | Patterns may not reflect real hospital behavior |
| Only 200 records per table | Statistical analyses have low sample significance |
| No real expense data | EBITDA and Valuation are estimates based on premises |
| No inventory or supply data | Actual procedure costs may differ |
| Single period (2023) | No real historical trend analysis possible |
| `billing.amount` = `treatments.cost` | No real markup in the dataset — structural limitation |

### 10.2 Assumed Premises

| Premise | Value | Justification |
|---|---|---|
| Physician expenses | 30% of revenue | Healthcare industry benchmark |
| Infrastructure expenses | 20% of revenue | Healthcare industry benchmark |
| Administrative expenses | 10% of revenue | Healthcare industry benchmark |
| **Total operating expenses** | **60% of revenue** | Sum of the above premises |
| EV/EBITDA Multiple | Defined in the model | Based on market benchmarks for hospitals |

### 10.3 Data Quality Notes

- Some records in `unified_table_modified.csv` have a `treatment_date` after 2023 (e.g., 2024-01-03), indicating the treatment was performed after the scheduling period — expected behavior for procedures with long waiting queues.
- The `gender` field in the `patients` table shows inconsistencies: some records with typically female names have `gender = 'M'` and vice versa. This is a characteristic of the simulated dataset and does not affect financial or operational analyses.
- There are no records of patients without appointments (registered patients with no consultation), which limits churn or retention analyses.

---

## 11. How to Run the Project

### 11.1 Prerequisites

- [Power BI Desktop](https://powerbi.microsoft.com/en-us/desktop/) installed (free)
- [R](https://cran.r-project.org/) installed (optional, only to recreate the join)
- Git installed (optional, to clone the repository)

### 11.2 Step by Step

**Option A — View the dashboard only:**

```
1. Download the file pbix/Hospital_data_case.pbix
2. Open it in Power BI Desktop
3. Explore the three dashboard views
```

**Option B — Run with refreshed data:**

```
1. Clone the repository:
   git clone https://github.com/micheleoliveiracod/Hospital_data_case.git

2. Open Power BI Desktop

3. Open the file pbix/Hospital_data_case.pbix

4. Go to Transform Data → Data Source Settings

5. Update the path to the /data folder of the cloned repository

6. Click Close and Apply

7. Click Refresh to reload the data
```

**Option C — Recreate the join with R:**

```r
# Install dependencies
install.packages(c("readr", "dplyr"))

# Run the script
source("data/Join/script_join.R")

# The unified_table_modified.csv file will be generated in data/Join/
```

### 11.3 Repository Structure

```
Hospital_data_case/
├── data/
│   ├── appointments.csv       # Appointment records
│   ├── billing.csv            # Billing records
│   ├── doctors.csv            # Physician registry
│   ├── patients.csv           # Patient registry
│   ├── treatments.csv         # Treatment records
│   └── Join/
│       ├── script_join.R      # R join script
│       └── unified_table_modified.csv  # Unified table
├── documentation/
│   ├── dashboard_documentation_PT.md  # Portuguese version
│   └── dashboard_documentation_EN.md  # English version (this file)
├── images/
│   └── image2.png             # Dashboard preview
├── pbix/
│   └── Hospital_data_case.pbix  # Power BI file
├── README.md
└── LICENSE
```

---

## 12. Glossary

| Term | Definition |
|---|---|
| **EBITDA** | Earnings Before Interest, Taxes, Depreciation and Amortization. Operational performance indicator. |
| **Valuation** | Estimated market value of a company, calculated as a multiple of EBITDA. |
| **EV/EBITDA** | Enterprise Value / EBITDA — Market multiple used to estimate a company's value relative to its operating result. |
| **Average Ticket** | Average value per transaction or appointment. |
| **Gross Margin** | Difference between revenue and the direct cost of services rendered. |
| **Star Schema** | Dimensional data model where a central fact table is connected to dimension tables. Recommended pattern for Power BI. |
| **DAX** | Data Analysis Expressions — Power BI formula language for creating measures and calculated columns. |
| **Power Query** | ETL tool integrated into Power BI for data transformation and cleansing. |
| **No-show** | A patient who did not attend a scheduled appointment without prior cancellation. |
| **KPI** | Key Performance Indicator. |
| **Drill-down** | Navigation to a more detailed granularity level within a visual. |
| **Slicer** | Interactive visual filter in Power BI that allows segmentation of displayed data. |
| **Insurance** | Payment method via health insurance plan. |
| **Pending** | Payment status indicating an open amount awaiting processing or reimbursement. |
| **Failed** | Payment status indicating a processing failure — billing not completed. |
| **Full Join** | Table join operation that returns all records from both tables, with `NULL` where there is no match. |

---

## Project Information

| Field | Value |
|---|---|
| **Project** | Hospital Analytics Dashboard |
| **Type** | Professional Portfolio Case |
| **Primary Tool** | Power BI Desktop |
| **Supporting Tools** | DAX, Power Query, R, Figma |
| **Dataset** | Kaggle — Hospital Management Dataset |
| **Data Period** | January to December 2023 |
| **Number of Records** | 200 per table (1,000 total) |
| **License** | MIT License |
| **Repository** | https://github.com/micheleoliveiracod/Hospital_data_case |

---

*Documentation created for professional portfolio purposes. The data used is simulated and publicly available.*
