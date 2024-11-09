## Exercise: Denormalizing the `fct_shipments` Table for Better Analysis

### Background

The analysis team is requesting certain key columns from other models to be added directly to the `fct_shipments` table. This will help improve query performance and make it easier for the team to access the relevant information without needing to join multiple tables in their analyses. 

The requested columns are:
- **`vehicle_type`** 
- **`customer_country`** 
- **`business_name`** 
- **`gps_tracking_enabled`** 
- **`vehicle_location_id`** 
- **`driver_hire_date`** 

### Objective

Your task is to update the `fct_shipments` table to include these key columns, denormalizing the model in the process. 
By adding these columns, the analysis team will be able to work with the data more efficiently in their analyses, without needing to join multiple tables.

You will need to locate where each column comes from in the staging files.

### Instructions

- Identify where the columns are coming from and ensure they have the requested names (rename where necessary).
- Add the models as CTEs in the `fct_shipments` model, for example:

```sql
with customers as (select * from {{ ref('base_swift_base_customers.sql') }})
```

- Add the required joins to the `fct_shipments` table to pull in these columns. 
- Ensure that the relationships between the tables are correct and using the correct primary/foreign keys
- Update the SQL code for `fct_shipments` to include these columns from the related tables. 
- Run dbt to apply the changes to your model:
```bash
dbt run
```

### Validate the Results
After running the model, check the `fct_shipments` table to ensure the following:
1. The new columns (`vehicle_type`, `customer_country`, `business_name`, `gps_tracking_enabled`, `vehicle_location_id`, `driver_hire_date`) have been added correctly.
2. The values are accurate by comparing them to the source tables.


### Conclusion
By completing this exercise, you will have:
- Successfully denormalized the `fct_shipments` model by adding key columns from other related tables.
- Improved the efficiency of querying for the analysis team by reducing the need for multiple joins.
- Balanced the trade-offs of denormalization and normalization in the context of data modeling:
    - **Faster queries**: By having these columns directly in the `fct_shipments` table, the analysis team doesn’t have to perform complex joins in every query, improving performance.
    - **Simpler queries**: They can directly access key pieces of information without having to understand the relationships between multiple tables.
    - **Consistency**: It ensures that the data is always available in the same format and doesn't require additional processing or lookups.