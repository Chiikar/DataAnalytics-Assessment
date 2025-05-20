-- Create a CTE to calculate monthly transaction counts for each customer
WITH customer_monthly_stats AS (
    SELECT 
        u.id as user_id,
        DATE_FORMAT(s.transaction_date, '%Y-%m') as month,  -- Format date as YYYY-MM
        COUNT(*) as transactions_in_month                    -- Count transactions per month
    FROM 
        users_customuser u
    JOIN 
        savings_savingsaccount s ON u.id = s.id             -- Join users with their accounts
    WHERE 
        s.transaction_date IS NOT NULL                      -- Only include records with transactions
    GROUP BY 
        u.id, DATE_FORMAT(s.transaction_date, '%Y-%m')      -- Group by user and month
),

-- Create a CTE to calculate average transactions and categorize users
customer_frequencies AS (
    SELECT 
        user_id,
        AVG(transactions_in_month) as avg_transactions,      -- Calculate average monthly transactions
        CASE 
            WHEN AVG(transactions_in_month) >= 10 THEN 'High Frequency'
            WHEN AVG(transactions_in_month) >= 3 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END as frequency_category                            -- Categorize based on average transactions
    FROM 
        customer_monthly_stats
    GROUP BY 
        user_id                                             -- Group by user to get their overall stats
)

-- Main query to summarize the results
SELECT 
    frequency_category,
    COUNT(user_id) as customer_count,                       -- Count users in each category
    ROUND(AVG(avg_transactions), 1) as avg_transactions_per_month  -- Calculate average transactions per category
FROM 
    customer_frequencies
GROUP BY 
    frequency_category
ORDER BY 
    CASE frequency_category                                -- Custom ordering to show High first
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        ELSE 3
    END;