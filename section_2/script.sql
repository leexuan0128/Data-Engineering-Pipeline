-- Create a table called order_products_prior based on the section_1 query result.
CREATE TABLE order_products_prior WITH (
        external_location = 's3://data-lake-bucket-imba/features/order_products_prior/', format = 'parquet') 
    AS (
        SELECT ORDERS.*,
            ORDER_PRODUCTS.product_id,
            ORDER_PRODUCTS.add_to_cart_order,
            ORDER_PRODUCTS.reordered
        FROM ORDERS
        JOIN ORDER_PRODUCTS 
        ON ORDERS.ORDER_ID = ORDER_PRODUCTS.ORDER_ID
        WHERE eval_set = 'prior'
        );

-- Create a SQL query (user_features_1). Based on table orders
-- For each user, calculate the max order_number, the sum of days_since_prior_order and the average of days_since_prior_order.
SELECT user_id,
        MAX(order_number) AS max_order_num,
        SUM(days_since_prior_order) AS sum_of_days_since_prior_order,
        ROUND(AVG(days_since_prior_order), 2) AS avg_of_days_since_prior_order
    FROM orders
    GROUP BY user_id
    ORDER BY user_id
    LIMIT 10;

-- Create a SQL query (user_features_2). Similar to above, based on table order_products_prior.
-- For each user calculate the total number of products, total number of distinct products, and user reorder ratio(number of reordered = 1 divided by number of order_number > 1).
SELECT user_id,
        COUNT(product_id) AS total_products,
        COUNT(DISTINCT product_id) AS distinct_products,
        ROUND(COUNT(CASE WHEN REORDERED = 1 THEN 1 END) * 1.0 / 
                COUNT(CASE WHEN ORDER_NUMBER > 1 THEN 1 END),2) AS reorder_ratio
    FROM order_products_prior
    GROUP BY user_id
    ORDER BY user_id
    LIMIT 10;

-- Create a SQL query (up_features). Based on table order_products_prior.
-- For each user and product, calculate the total number of orders, minimum order_number, maximum order_number and average add_to_cart_order.
SELECT user_id, 
       product_id,
       COUNT(*) AS total_orders,
       MIN(order_number) AS min_order_number,
       MAX(order_number) AS max_order_number,
       ROUND(AVG(add_to_cart_order),2) AS avg_add_to_cart_order
    FROM order_products_prior
    GROUP BY user_id, product_id
    ORDER BY user_id, product_id
    LIMIT 10;

-- Create a SQL query (prd_features). Based on table order_products_prior, calculate the sequence of product purchase for each user, and name it product_seq_time.
-- For each product, calculate the count, sum of reordered, count of product_seq_time = 1 and count of product_seq_time = 2.
SELECT product_id,
        Count(*) AS count_of_prod_orders,
        Sum(reordered) AS sum_of_prod_reorders,
        Sum(CASE WHEN product_seq_time = 1 THEN 1 ELSE 0 END) AS prod_first_orders, 
        Sum(CASE WHEN product_seq_time = 2 THEN 1 ELSE 0 END) AS prod_second_orders
    FROM (SELECT *, 
            Rank() OVER (partition BY user_id, product_id
            ORDER BY order_number) AS product_seq_time
        FROM order_products_prior)
    GROUP BY product_id
    ORDER BY product_id
    LIMIT 10;
