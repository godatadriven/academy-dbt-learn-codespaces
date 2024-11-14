Here's an exercise for your students, focusing on adding an accepted values test and debugging when it fails. The goal is to test the `ownership` column in the vehicle model.
## Exercise: Adding an Accepted Values Test and Debugging Failures

In dbt, an **accepted values test** is used to validate that a column contains only the specified set of allowed values. This is useful for ensuring data integrity and consistency in columns that should only have specific values, such as `status`, `ownership`, or `payment_type`.

For this exercise, you will be testing the **`ownership`** column in your vehicle model. The column is expected to only contain specific values such as `owned` and `rented`. However, there may be some unexpected or missing values due to issues in the data.

### Add an Accepted Values Test for `ownership` in `dim_vehicles`

  1. In your `schema.yml` file created in part 1, add the vehicle model.
  2. Add an accepted values test for the `ownership` column based on the data dictionary.

Here is an example:

```yaml
models:
  - name: model_name
    columns:
      - name: column_name
        tests:
          - accepted_values:
              values: ['list', 'of', 'accepted', 'values']
```

### Run the dbt Model and Test

- Run the dbt model to execute the tests:
  ```bash
  dbt run -s dim_vehicles
  dbt test -s dim_vehicles
  ```

### Debugging the Test Failure

If the test fails, it likely means that there are values in the `ownership` column that are not in the accepted list. 

You can either write some sql to find out what extra values there are in the `ownership` column, or you can go to the executed code that dbt has 
saved in the previous run or `target/` folder. Run this code and find out what values you are missing. Decide whether to update the data dictionary or remove this values
from `dim_vehicles` by overwriting it or using a `where` statment.

### Step 5: Re-run the dbt Tests

After making the necessary changes, run the dbt tests again to confirm that the issue is resolved:
```bash
dbt test
```

If the test passes, you have successfully debugged the issue. If it fails again, revisit your assumptions about the data and continue debugging as needed.