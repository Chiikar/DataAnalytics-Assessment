-- use `adashi_staging`
-- Query to identify high-value customers with both savings and investment products
-- Goal: Find customers with at least one active savings account AND one investment plan
-- Sorted by total deposits (savings + investments) in descending order

SELECT 
    u.id AS owner_id,                          -- Unique user identifier
    CONCAT(u.first_name, ' ', u.last_name) AS name,  -- Full customer name
    COUNT(DISTINCT s.id) AS savings_count,     -- Number of active savings accounts
    COUNT(DISTINCT p.id) AS investment_count,  -- Number of active investment plans
    (COALESCE(SUM(s.amount), 0) + COALESCE(SUM(p.amount), 0)) AS total_deposits  -- Combined total of all deposits
FROM 
    users_customuser u                         -- Starting from all users
JOIN 
    savings_savingsaccount s ON u.id = s.owner_id
    AND s.transaction_status = 'success'       -- Only successful savings transactions
JOIN 
    plans_plan p ON u.id = p.owner_id
    AND p.plan_type_id = 2                     -- Filter for investment plans 
    AND p.is_deleted = 0                       -- Exclude deleted plans
    AND p.status_id = 1                        -- Only active plans 
GROUP BY 
    u.id, u.first_name, u.last_name            -- Group by customer
HAVING 
    COUNT(DISTINCT s.id) >= 1 AND COUNT(DISTINCT p.id) >= 1  -- Must have at least one of each product
ORDER BY 
    total_deposits DESC;                       -- Sort by highest total deposits first

