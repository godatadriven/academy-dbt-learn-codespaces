Here's an exercise for students to add a surrogate key to the `shipment_types` model by creating a union of monthly data and generating the surrogate key using the `dbt_utils` package.

---

## Exercise: Creating a Surrogate Key for `shipment_types` Model

### Background

In the previous exercise, you have created a new `dim_shipment_types` model by combining multiple 
monthly tables that contain information about shipment types and their associated price per kilogram. 

Now you will create a new surrogate key for the combination of `shipment_type` and `month` using the `dbt_utils` package 
to ensure each unique combination of these two columns has a distinct key.

## Add the dbt utils package to your project

- Create a `packages.yml` file in the `shipments/` folder.
- Add the required configuration to the file to install the package, you can find that here: [dbt_utils package hub](https://hub.getdbt.com/dbt-labs/dbt_utils/latest/)

### Add a Surrogate Key Using `dbt_utils.surrogate_key`

In the dim_shipment_types model, use the `dbt_utils.surrogate_key` function to create a unique surrogate key for 
each combination of `shipment_type` and `month`.

You should add the following code in your model after the union alls:

{{ dbt_utils.surrogate_key(['shipment_type', 'month']) }} AS surrogate_key


### Run dbt to apply changes and verify results

Once you’ve created the model, run dbt to apply the changes and generate the new surrogate key.

1. Run the following commands in your terminal:

   ```bash
   dbt run
   ```
2. **Check the `shipment_types` Table**: Verify that the `surrogate_key` column is correctly populated for each unique combination of `shipment_type` and `month`.
3. **Ensure Correct Surrogate Key Generation**: Add a generic test to your `dim_shipment_types` model to test that it is unique and there are no nulls.

### Bonus Step: Optimize the Model

Consider adding a `date` column or a `year` column to your model, which could help with partitioning or filtering when using the `shipment_types` table in later analysis.

---

### Conclusion

By completing this exercise, you have learned how to:
- Add packages to your project
- Generate a surrogate key using the `dbt_utils.surrogate_key` function to ensure each combination of `shipment_type` and `month` is uniquely identified.