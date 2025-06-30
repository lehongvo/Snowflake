# Exercise 4: Snowsight UI Exploration

## 🎯 Objective
Explore the Snowsight interface to familiarize yourself with Snowflake's modern web UI and understand its key features for data analysis and management.

## 📋 Prerequisites
- [ ] Snowflake trial account setup completed
- [ ] Successful login to Snowsight
- [ ] Basic understanding of Snowflake architecture

## 🚀 Guided Exploration Tasks

### Phase 1: Initial Interface Overview

#### 1. Dashboard Exploration
**Landing Page Analysis:**
- **Dashboard Name:** ___________________________
- **Main Sections Visible:** ____________________
- **Quick Actions Available:** ___________________

**Take Screenshot or Describe:**
```
[Describe or attach screenshot of main dashboard]
```

#### 2. Navigation Menu
**Document the main navigation items:**
- [ ] **Worksheets** - Purpose: _____________________
- [ ] **Dashboards** - Purpose: ____________________
- [ ] **Data** - Purpose: ___________________________
- [ ] **Marketplace** - Purpose: ____________________
- [ ] **Activity** - Purpose: ______________________
- [ ] **Admin** - Purpose: _________________________

### Phase 2: Worksheet Functionality

#### 1. Create New Worksheet
**Steps:**
1. [ ] Click on "Worksheets" in navigation
2. [ ] Click "+ Worksheet" button
3. [ ] Note the interface elements

**Worksheet Interface Elements:**
- **SQL Editor:** ☐ Present ☐ Absent
- **Results Panel:** ☐ Present ☐ Absent
- **Object Browser:** ☐ Present ☐ Absent
- **Warehouse Selector:** ☐ Present ☐ Absent

#### 2. Basic SQL Execution
**Test Query 1: System Information**
```sql
SELECT CURRENT_VERSION();
```
- **Query Executed:** ☐ Yes ☐ No
- **Result:** ____________________________________
- **Execution Time:** ____________________________

**Test Query 2: Current Settings**
```sql
SELECT CURRENT_WAREHOUSE(), CURRENT_DATABASE(), CURRENT_SCHEMA();
```
- **Current Warehouse:** ________________________
- **Current Database:** _________________________
- **Current Schema:** ____________________________

#### 3. Worksheet Features
**Explore these features:**
- [ ] **Auto-complete** - Functionality: _______________
- [ ] **Syntax Highlighting** - Present: ☐ Yes ☐ No
- [ ] **Query Formatting** - Available: ☐ Yes ☐ No
- [ ] **Save Worksheet** - Location: ___________________
- [ ] **Share Worksheet** - Options: ____________________

### Phase 3: Data Browser Exploration

#### 1. Database Structure
**Navigate to Data > Databases**

**Default Database:**
- **Name:** ____________________________________
- **Schemas Available:** ________________________
- **Tables/Views Count:** _______________________

#### 2. Schema Exploration
**Select a schema and document:**
- **Schema Name:** _____________________________
- **Objects Found:**
  - Tables: ___________________________________
  - Views: ____________________________________
  - Procedures: ______________________________
  - Functions: _______________________________

#### 3. Sample Data Query
**If sample data exists, query it:**
```sql
-- Try to find sample data
SHOW TABLES;
```
- **Sample Tables Found:** ______________________
- **Sample Query Result:** ______________________

### Phase 4: Warehouse Management

#### 1. Warehouse Information
**Navigate to Admin > Warehouses**

**Default Warehouse Details:**
- **Name:** ____________________________________
- **Size:** ____________________________________
- **Status:** __________________________________
- **Auto Suspend:** ____________________________
- **Auto Resume:** _____________________________

#### 2. Warehouse Operations
**Test warehouse operations:**
- [ ] **Suspend Warehouse** - Success: ☐ Yes ☐ No
- [ ] **Resume Warehouse** - Success: ☐ Yes ☐ No
- [ ] **Resize Warehouse** - Available: ☐ Yes ☐ No

**Warehouse Sizes Available:**
- [ ] X-Small
- [ ] Small
- [ ] Medium
- [ ] Large
- [ ] X-Large
- [ ] XX-Large

#### 3. Multi-Cluster Settings
**Check multi-cluster options:**
- **Multi-cluster Available:** ☐ Yes ☐ No
- **Min Clusters:** ____________________________
- **Max Clusters:** ____________________________
- **Scaling Policy:** ___________________________

### Phase 5: Query History and Activity

#### 1. Query History
**Navigate to Activity > Query History**

**Recent Queries:**
- **Total Queries:** ____________________________
- **Time Range:** _______________________________
- **Filter Options:** ____________________________

**Document your test queries:**
| Query | Execution Time | Status | Credits Used |
|-------|----------------|---------|--------------|
| _____ | ______________ | _______ | ____________ |
| _____ | ______________ | _______ | ____________ |

#### 2. Warehouse Usage
**Check warehouse usage:**
- **Credits Consumed:** ________________________
- **Query Count:** _____________________________
- **Average Query Time:** ______________________

### Phase 6: Account and User Management

#### 1. Account Information
**Navigate to Admin > Accounts**

**Account Details:**
- **Account Name:** ____________________________
- **Region:** __________________________________
- **Cloud Provider:** ___________________________
- **Account URL:** ______________________________

#### 2. User Management
**Navigate to Admin > Users & Roles**

**Current User:**
- **Username:** ________________________________
- **Roles Assigned:** ____________________________
- **Default Role:** _____________________________
- **MFA Status:** _______________________________

#### 3. Role-Based Access
**Explore roles:**
- **Available Roles:** ___________________________
- **Current Role Permissions:** ___________________
- **Role Switching:** ☐ Available ☐ Not Available

### Phase 7: Data Marketplace

#### 1. Marketplace Overview
**Navigate to Data > Marketplace**

**Marketplace Features:**
- **Categories Available:** ______________________
- **Free Datasets:** ____________________________
- **Data Providers:** ___________________________

#### 2. Sample Dataset Exploration
**Browse a free dataset:**
- **Dataset Name:** ____________________________
- **Provider:** ________________________________
- **Description:** ______________________________
- **Installation:** ☐ Attempted ☐ Not Attempted

## 🎯 Advanced Exploration Tasks

### Task 1: Create a Simple Dashboard
**Instructions:**
1. Navigate to Dashboards
2. Create a new dashboard
3. Add a simple chart from your queries

**Dashboard Creation:**
- **Created Successfully:** ☐ Yes ☐ No
- **Chart Types Available:** ____________________
- **Customization Options:** ____________________

### Task 2: Explore Data Sharing
**Navigate to Data > Private Sharing**
- **Sharing Options:** ____________________________
- **Inbound Shares:** ____________________________
- **Outbound Shares:** ___________________________

### Task 3: Resource Monitoring
**Navigate to Admin > Resource Monitors**
- **Default Monitor:** ____________________________
- **Credit Limits:** _____________________________
- **Notification Settings:** ______________________

## 📊 Interface Comparison

**Compare with other tools you know:**

| Feature | Snowsight | Other Tool | Comments |
|---------|-----------|------------|----------|
| **SQL Editor** | _________ | __________ | ________ |
| **Visualization** | _________ | __________ | ________ |
| **Query History** | _________ | __________ | ________ |
| **User Management** | _________ | __________ | ________ |

## 💡 Key Observations

### Most Impressive Feature:
___________________________________________________
___________________________________________________

### Most Confusing Aspect:
___________________________________________________
___________________________________________________

### Ease of Use (1-10):
**Rating:** _____ **Reason:** ____________________

### Performance:
**Query Speed:** ________________________________
**UI Responsiveness:** __________________________

## 🔍 Detailed Feature Analysis

### Worksheet Capabilities
**Strengths:**
- [ ] _____________________________________________
- [ ] _____________________________________________
- [ ] _____________________________________________

**Limitations:**
- [ ] _____________________________________________
- [ ] _____________________________________________

### Data Browser
**Strengths:**
- [ ] _____________________________________________
- [ ] _____________________________________________

**Limitations:**
- [ ] _____________________________________________
- [ ] _____________________________________________

### Administrative Interface
**Strengths:**
- [ ] _____________________________________________
- [ ] _____________________________________________

**Limitations:**
- [ ] _____________________________________________
- [ ] _____________________________________________

## 🎓 Learning Outcomes

### New Concepts Learned:
1. _______________________________________________
2. _______________________________________________
3. _______________________________________________

### Questions for Further Research:
1. _______________________________________________
2. _______________________________________________
3. _______________________________________________

### Features to Explore Further:
1. _______________________________________________
2. _______________________________________________
3. _______________________________________________

## ✅ Exploration Checklist

- [ ] Navigated all main menu sections
- [ ] Created and executed SQL queries
- [ ] Explored worksheet functionality
- [ ] Investigated data browser
- [ ] Examined warehouse management
- [ ] Reviewed query history
- [ ] Checked account settings
- [ ] Browsed data marketplace
- [ ] Attempted dashboard creation
- [ ] Documented key observations

## 📝 Personal Reflection

**Overall Experience:**
___________________________________________________
___________________________________________________

**Compared to Expectations:**
___________________________________________________
___________________________________________________

**Most Valuable Discovery:**
___________________________________________________
___________________________________________________

**Preparation for Certification:**
___________________________________________________
___________________________________________________

---

**Exploration Date:** _______________
**Time Spent:** _______________
**Readiness for Day 2:** ☐ Yes ☐ No 