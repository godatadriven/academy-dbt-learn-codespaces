## Shipment type

### Current strategy

Every month price per kg is reviewed and changed if necessary. This is used to determine the price of shipping 
where $ \text{list\_price} = \text{weight\_in\_kg} \times \text{price\_per\_kg} $

`list_price = weight_in_kg x price_per_kg`

### Issue

The analysis team are checking whether the shipment price is correct by joining the monthly price_per_kg to the fct_shipments table and 
re-calculating the list price. This should match the field that already exists. 

The code (which you can find here: `check_prices_based_on_strategy.sql`) can be simplified as right now it requires multiple union all statements (or joins)

The team is requesting a table to be in the warehouse which contains the monthly prices so that their analysis is more simple

### To solve:

You need to add a `dim_shipment_types` model to your project. 

- Add staging models base_swift_transactions_dim_shipment_type_[month] to the project
- Add a model dim_shipment_types that unions all tables

**Check it is working:**
- refactor the analysts code to point to the new `dim_shipment_types` model and make sure the output is the same.

#### Bonus: Jinja

- When unioning, you are required to use the same extract of code repeatedly. Use a 
[jinja for-loop](https://jinja.palletsprojects.com/en/stable/templates/#for) to make the query scalable

