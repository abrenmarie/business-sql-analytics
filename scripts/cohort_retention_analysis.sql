WITH user_first_booking AS (
    SELECT 
        user_id,
        DATE_TRUNC('month', MIN(booking_date)) AS cohort_month
    FROM source_bookings
    WHERE booking_status = 'CONFIRMED'
    GROUP BY user_id
),

activity_ledger AS (
    SELECT 
        b.user_id,
        DATE_TRUNC('month', b.booking_date) AS activity_month,
        COUNT(b.booking_id) AS total_bookings,
        SUM(b.total_price) AS gross_revenue,
        SUM(CASE WHEN b.booking_channel = 'DIRECT' THEN b.total_price ELSE 0 END) AS direct_channel_revenue
    FROM source_bookings b
    WHERE b.booking_status = 'CONFIRMED'
    GROUP BY b.user_id, DATE_TRUNC('month', b.booking_date)
),

cohort_sizes AS (
    SELECT 
        cohort_month,
        COUNT(DISTINCT user_id) AS cohort_base_size
    FROM user_first_booking
    GROUP BY cohort_month
)

SELECT 
    c.cohort_month AS cohort,
    cs.cohort_base_size AS base_users,
    EXTRACT(YEAR FROM AGE(a.activity_month, c.cohort_month)) * 12 + 
    EXTRACT(MONTH FROM AGE(a.activity_month, c.cohort_month)) AS cohort_index,
    COUNT(DISTINCT a.user_id) AS active_users,
    ROUND((COUNT(DISTINCT a.user_id)::NUMERIC / cs.cohort_base_size) * 100, 2) AS retention_rate_pct,
    SUM(a.total_bookings) AS total_bookings_volume,
    SUM(a.gross_revenue) AS total_revenue,
    ROUND(SUM(a.gross_revenue) / COUNT(DISTINCT a.user_id), 2) AS average_revenue_per_active_user (ARPU),
    ROUND((SUM(a.direct_channel_revenue) / NULLIF(SUM(a.gross_revenue), 0)) * 100, 2) AS direct_revenue_share_pct

FROM user_first_booking c
JOIN activity_ledger a ON c.user_id = a.user_id
JOIN cohort_sizes cs ON c.cohort_month = cs.cohort_month
GROUP BY 1, 2, 3
ORDER BY cohort_month ASC, cohort_index ASC;