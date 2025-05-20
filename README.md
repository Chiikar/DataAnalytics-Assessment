![image](https://github.com/user-attachments/assets/56215e79-ccb9-4a1d-96f6-358c16932e78)


# SQL-Based Customer Insights Analysis

### 🎯 Project Objective
This assessment focuses on analyzing customer behavior, account activity, and lifetime value through SQL queries. The goal is to derive actionable business insights to support marketing, operations, and product strategy decisions.

#### 🔍 Analysis Breakdown
#### Question 1: High-Value Cross-Product Customers
##### Objective:
- Identify customers who hold both savings accounts and active investment plans.

##### Approach:
- Filtered for users with at least one successful savings transaction and one active investment plan.
- Excluded deleted or inactive investment plans.
- Aggregated total deposit values across both products.
- Sorted customers by total value to surface the most valuable users.

##### Business Use:
- Enables upselling, retention targeting, and understanding of product usage combinations.

#### Question 2: Customer Transaction Frequency Segmentation
##### Objective:
- Classify customers based on their monthly transaction behavior.

##### Approach:
- Calculated each customer’s average monthly transactions.
- Segmented into: High (≥10), Medium (≥3), Low (<3) frequency groups.
- Produced summary statistics per category.

##### Business Use:
- Supports customer segmentation, engagement planning, and operational prioritization.

#### Question 3: Dormant Account Identification
##### Objective:
- Find active savings or investment accounts with no inflows in over a year.

##### Approach:
- Focused on active plan types (savings and investment).
- Used latest transaction dates to compute inactivity.
- Flagged accounts with >365 days of no activity.

##### Business Use:
- Helps operations re-engage dormant customers and manage account lifecycle.

#### Question 4: Customer Lifetime Value (CLV) Estimation
##### Objective:
- Estimate the long-term value each customer brings to the business.

##### Approach:
- Calculated account tenure (months since signup).
- Summarized transaction count and average transaction value.
- Used a simplified CLV model based on 0.1% transaction profit assumption.

##### Business Use:
- Highlights high-value customers, informing loyalty initiatives and marketing strategies.

#### ✅ Summary
Each query is designed to reveal a key dimension of customer behavior—from value and engagement to risk and inactivity. The results provide a foundation for strategic decision-making across departments like marketing, operations, and customer success.
