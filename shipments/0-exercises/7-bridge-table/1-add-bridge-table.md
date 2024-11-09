### Exercise: Creating a Bridge Table Between Customers and Businesses

In this exercise, you will create a bridge table that connects `customers` and `businesses` 
based on data from the `fct_shipments` table. 

This table will enable analysts to easily calculate key metrics such as the **average number of customers per business** and 
the **average number of businesses per customer**.

### Why is a Bridge Table Important?

A **bridge table** is essential when you have a many-to-many relationship between entities. In this case:
- A **customer** can be associated with multiple **businesses**.
- A **business** can have multiple **customers**.
  
Since there is no direct foreign key between `dim_customers` and `dim_businesses`, you will create a bridge table 
using data from the `fct_shipments` table. This will allow the analysts to easily access and analyze these relationships.

### Instructions:

1. **Create the Bridge Table**:
   - The `fct_shipments` table contains the relationships between customers and businesses. Use the `customer_id` and `business_id` from `fct_shipments` to build a new table.
   - The bridge table should have the following columns:
     - `customer_id`: The ID of the customer from `dim_customers`.
     - `business_id`: The ID of the business from `dim_businesses`.

2. **Design the Bridge Table**:
   - Use the `fct_shipments` table to link customers and businesses.
   - Write a query to create a new model (`bridge_customer_business.sql`) that will:
     - Select the unique pairs of `customer_id` and `business_id` from `fct_shipments`.
   
   ```sql
   -- models/bridge_customer_business.sql

   SELECT
     customer_id,
     business_id
   FROM {{ ref('fct_shipments') }}
   GROUP BY customer_id, business_id
   ```

3. **Join the Tables**:
   - Now that you have a bridge table, join it with `dim_customers` and `dim_businesses` to enable analysis.
   - In the `analyses/bridge_analysis.sql` file, try joining the following tables:
     - `dim_customers`
     - `dim_businesses`
     - `bridge_customer_business`

4. **Calculate Key Metrics**:
   - Calculate the **average number of customers per business** and the **average number of businesses per customer**. 
   Use SQL aggregate functions like `COUNT` and `GROUP BY` to perform the calculations.
   - You can look at the code `num_bus_custs_avg.sql` to see how this is currently done.

5. **Verify**:
   - After running dbt, verify that your bridge table is working as expected by checking the result of your analysis queries. 
   Make sure that the data in the `bridge_customer_business` table reflects the correct relationships.


### Conclusion:

By completing this exercise, you will have created a **bridge table** that links customers and 
businesses through the `fct_shipments` table. This table makes it easier for analysts to perform 
key metrics calculations like the **average number of customers per business** and **average number of businesses per customer**. 

It will also allow for more efficient analysis and reporting, eliminating the need for repeated complex joins across multiple tables.