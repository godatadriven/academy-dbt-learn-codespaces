# Exercise: Renaming Columns for Consistency and Readability

In data modeling, choosing **consistent** and **descriptive** column names is crucial. It ensures your models are easy to understand and work with. Consistent naming helps data users and future developers quickly understand the purpose of each column without needing to consult documentation.

When renaming columns, focus on:
- **Consistency:** Use similar naming conventions across all tables and columns (e.g., `customer_id` instead of `cust_id` in one model and `user_id` in another).
- **Readability:** Ensure the name clearly describes what the column represents. For example, `transaction_amount` is better than just `amount`.

## Renaming Columns in the `base_stg_swift_transactions__shipments.sql` Model

**Objective:** Review the `base_stg_swift_transactions__shipments.sql` model and rename any columns that are unclear, inconsistent, or difficult to understand.

Use the other models to choose consistent naming strategies and the data dictionary to choose readable and suitable names.

#### Example:

If you have columns like:
```sql
SELECT 
  t1.id as transaction_id,
  t1.t_amt as amt,
  t1.ship_dt as shipment_date
FROM 
  raw.shipments t1;
```

You might want to rename `t_amt` to `transaction_amount` and `ship_dt` to `shipment_date`, making sure the names clearly reflect the data they hold.

### Step 3: Commit and Test

- After renaming the columns, run your dbt model to make sure everything works as expected.
- Check your data and ensure that any downstream models or queries referencing the renamed columns are updated accordingly.