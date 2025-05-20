SELECT 
    s.plan_id,  -- Unique identifier for the savings or investment plan
    p.owner_id,  -- Account owner
    CASE 
        WHEN p.plan_type_id = 4 THEN 'Savings'         -- Label plan_type_id 4 as 'Savings'
        WHEN p.plan_type_id = 2 THEN 'Investment'      -- Label plan_type_id 2 as 'Investment'
        ELSE 'Other'                                   -- Catch-all label for other types
    END AS type,
    MAX(s.transaction_date) AS last_transaction_date,  -- Most recent transaction date for the account
    DATEDIFF(CURRENT_DATE, MAX(s.transaction_date)) AS inactivity_days  -- Days since the last transaction
FROM 
    plans_plan p
JOIN 
    savings_savingsaccount s ON p.owner_id = s.owner_id  -- Join accounts using owner_id
WHERE 
    p.status_id = 1  -- Filter to include only active accounts (status_id = 1)
    AND p.plan_type_id IN (2, 4)  -- Filter to include only Savings and Investment plans
GROUP BY 
    s.plan_id, p.id, p.plan_type_id  -- Grouping to aggregate transaction data per plan
HAVING 
    last_transaction_date IS NULL  -- Include accounts with no transaction records
    OR DATEDIFF(CURRENT_DATE, last_transaction_date) > 365  -- OR those inactive for over a year
ORDER BY 
    inactivity_days DESC;  -- Sort results from longest inactive to least
