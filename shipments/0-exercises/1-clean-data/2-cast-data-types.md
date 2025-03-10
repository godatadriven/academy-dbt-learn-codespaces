## Exercise: Casting Columns in dbt

### Problem Description:
You have a staging `model base_swift_transactions_shipments` with some columns that are currently not stored in the best way. Note that it is 
expected that you have already renamed `wgtkg_123x` to `weight_in_kg`

Here are the columns to resolve:
- The weight column is currently a string with spaces instead of a decimal point, e.g., `'56 33'`
-  All date columns are stored as milliseconds, representing the number of milliseconds since the Unix epoch.

Your task is to transform and cast these columns correctly:
1. **Transform the weight column**: This should be a numeric field with three decimal places.
2. **Convert all date columns**: These should be converted into a proper `TIMESTAMP`.

***Remember which warehouse / SQL dialect you need to be using!***

### Steps 

Locate and open the `base_swift_transactions_shipments.sql`.

1. **For `wgtKg_123X`**:
   - You need to replace the space between the whole and decimal parts with a dot (`.`) to convert it into a valid floating-point number.

   Here's how you can transform a column to a float, replacing the spaces with a decimal:
   ```sql
   CAST(REPLACE(string_column, ' ', '.') AS FLOAT) AS new_column
   ```

2. **For `date_column`s**:
   - The `date_column`s are in milliseconds, and you need to convert it to a proper `TIMESTAMP` format. You can use the `TO_TIMESTAMP` function to convert the milliseconds into a timestamp.

   Here's how you can convert the `date_column`:
   ```sql
   TO_TIMESTAMP(date_column / 1000) AS date_column_timestamp
   ```

### Implement the Changes in the Model

Update your SQL model to reflect these transformations and run dbt to apply your changes:
```bash
dbt run
```

Verify that the transformation was successful:
1. Check the `weight_in_kg` column to ensure the weight is now correctly formatted as a float (e.g., `56.33`).
2. Check the date columns to confirm the dates have been correctly converted to a readable timestamp format.

### Conclusion
By completing this exercise, you have practiced:
- Casting string columns to a float after performing string manipulation.
- Converting columns from milliseconds into a proper `TIMESTAMP`.