-- Step 1: Calculate customer tenure (in months) and build basic customer info
WITH customer_data AS (
  SELECT
    u.id AS customer_id,  -- Unique identifier for the customer
    CONCAT(u.first_name, ' ', u.last_name) AS name,  -- Full name of the customer
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months  -- Months since the user joined
  FROM users_customuser u
),

-- Step 2: Aggregate transaction data per customer
transaction_summary AS (
  SELECT
    s.owner_id,  -- Customer ID linked to the transaction
    COUNT(*) AS total_transactions,  -- Total number of transactions made by the customer
    AVG(s.amount) AS avg_transaction_value  -- Average transaction value
  FROM savings_savingsaccount s
  GROUP BY s.owner_id  -- Group by customer to get aggregates per user
)

-- Step 3: Combine customer info with transaction summary to calculate estimated CLV
SELECT DISTINCT  -- Ensure each customer appears only once
  c.customer_id,
  c.name,
  c.tenure_months,
  COALESCE(t.total_transactions, 0) AS total_transactions,  -- Handle nulls if no transactions
  CASE
    -- CLV formula: (transactions/month) * 12 * avg profit per transaction (0.1%)
    WHEN c.tenure_months > 0 AND t.total_transactions IS NOT NULL THEN
      (t.total_transactions / c.tenure_months) * 12 * (0.001 * t.avg_transaction_value)
    ELSE 0  -- If tenure is 0 or no transactions, set CLV to 0
  END AS estimated_clv
FROM customer_data c
LEFT JOIN transaction_summary t ON c.customer_id = t.owner_id  -- Join transaction data to customer data
ORDER BY estimated_clv DESC;  -- Show customers with highest estimated CLV at the top
