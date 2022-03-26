# Entity & Relationship Diagram (ERD) Design

In the step 1 of our pipeline, we build a data lake using a 3 million grocery order record. After we use AWS Athena to retrive the data from the source, we now have 5 tables:

- Aisles: aisles’s info.
- Products: all products info.
- Departments: products departments categories.
- Orders: sales orders placed by customers.
- OrdersProduct: order line items for each order.

We can draw an ERD to have a clear sight of the table structure and relaitionship from our data.

![ERD](/section_1/img/ERD.png)

## Query
_Query to join orders table and order_products table together, filter on eval_set = ‘prior’_

```SQL
SELECT * 
FROM ORDERS
LEFT JOIN ORDER_PRODUCTS
    ON ORDERS.ORDER_ID = ORDER_PRODUCTS.ORDER_ID
WHERE eval_set = 'prior';
```