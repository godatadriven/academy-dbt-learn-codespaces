## Exercise: Adding Employee Flag to `dim_customers` and `fct_shipments` using a seed

The business has provided a list of email addresses of employees. 
The analysis team has requested that we flag these customers in the `dim_customers` table to distinguish between employees and non-employees. 

Additionally, we need to add this flag to the `fct_shipments` table so that the analysis team can 
easily filter or segment shipments based on whether they were made by employees or not.

### Task steps

### 1: Create a CSV Seed File with Employee Emails

1. **Create the Seed File**:

   In your dbt project directory, create a folder called `data/` if it doesn't already exist. Inside this folder, create a file called `employee_emails.csv` with the following contents:

   ```csv
   email
   powersamanda@example.org
   haasamber@example.net
   mrodriguez@example.net
   michaelrollins@example.net
   jasminewilson@example.org
   ericwhite@example.com
   floreskyle@example.org
   ecarlson@example.org
   hensondwayne@example.org
   olong@example.net
   shawcassie@example.net
   wstanley@example.com
   sandramoore@example.net
   erika46@example.com
   omurphy@example.com
   jacob83@example.net
   thomasevans@example.com
   mosleyrachel@example.net
   anthony24@example.org
   ryancampbell@example.org
   briggshannah@example.net
   matthewsmith@example.net
   ipadilla@example.net
   stevensonanthony@example.com
   ```

2. **Configure the Seed File in `dbt_project.yml`**:

   Make sure your `dbt_project.yml` file is set up to load the seed file. You may need to add or confirm the following lines under the `seeds` section:

   ```yaml
   seeds:
     my_project_name:
       employee_emails:
         file: data/employee_emails.csv
         header: true
   ```

---

### Step 2: Add Employee Flag to `dim_customers`

Now that the employee emails are available as a seed, you need to add an `is_employee` flag to the `dim_customers` table to indicate whether a customer is an employee based on their email.

**Modify the `dim_customers` Model** to join the `employee_emails` based on the `email_address` field.

You can reference the seed using `{{ ref('name_of_seed') }}` and you should add a column `is_employee` which is `true` if they are an employee or `false` if not.

### Step 3: Add the Employee Flag to `fct_shipments`

Next, you need to propagate the `is_employee` flag from the `dim_customers` table to the `fct_shipments` table based on the `customer_id`.

1. **Modify the `fct_shipments` Model**:

Update the `fct_shipments.sql` model to include the `is_employee` flag by joining with the `dim_customers` table.


### Run dbt to apply changes & validate results

Once you've made the changes, run dbt to apply the transformations and load the seed file:

```bash
dbt seed
dbt run -s +fct_shipments
```

After running dbt, validate the results:
1. In the `dim_customers` table, check that the `is_employee` flag is correctly populated based on the email addresses in the seed file.
2. In the `fct_shipments` table, verify that the `is_employee` flag appears for each shipment and reflects the correct employee status based on `customer_id`.


### Conclusion

By completing this exercise, you have learned how to:
- Use a CSV seed file to load external data into a dbt project.
- Add an `is_employee` flag to a dimension table (`dim_customers`) based on email addresses.
- Propagate the flag to a fact table (`fct_shipments`) for better analysis efficiency.