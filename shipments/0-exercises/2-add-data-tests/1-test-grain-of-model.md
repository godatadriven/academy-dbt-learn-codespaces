## Exercise: Testing Granularity with Generic Tests in dbt

**Granularity** refers to the level of detail captured in a dataset. For example, in a `sales` table, each row might represent an individual sale (fine granularity) or aggregated sales data by day (coarse granularity). Defining the correct granularity ensures data accuracy and avoids issues like duplicate data.

- **Primary Keys:** These are unique identifiers for each record in a table and are crucial for maintaining the intended granularity. Every table should have a unique primary key or set of keys that define its grain. When data modeling, it's important to know and test for the uniqueness of these keys.

### Test the Primary Keys in End Models

- **Objective:** Add `unique` and `not_null` tests to all models within the `marts/` folder.
- **Steps:**
  1. Open your `marts` folder and locate your model files.
  2. Create a `schema.yml` file and add `unique` and `not_null` tests for the primary keys of each model.

#### Example
Here's how you can add generic tests for a primary key called `id`:
```yml
models:
  - name: your_model_name
    columns:
      - name: id
        tests:
          - unique
          - not_null
```

### Debugging Test Failures

If any tests fail, you need to determine the root cause. Some reasons why tests might fail include:
- **Incorrect Assumptions about Source Data:** The data you expect might differ from the data you actually have, such as duplicates or missing values.
- **Code Issues:** Your transformations might introduce duplicates or fail to ensure uniqueness.

**Debugging Task:**
- Add a `unique` or `not_null` test to the source table where the primary key tests are failing.
  - Analyze the test results to determine if the issue originates from the source data or transformations.
  - Document your findings and explain any necessary corrections.
