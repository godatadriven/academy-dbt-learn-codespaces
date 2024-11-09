## Shipment type - testing list price

### Current strategy

Every month price per kg is reviewed and changed if necessary. This is used to determine the price of shipping 
where $ \text{list\_price} = \text{weight\_in\_kg} \times \text{price\_per\_kg} $

### Request

Now that there is a `dim_shipment_types` model, the analysts would like the test against `list_price` to be added as a test in the dbt Project so that it
is run on a schedule and not reliant on one analyst running the code.

### To solve:

Add a data test in the `tests/` directory. Adapt the code you refactored from the analysts so that it complies with the 
[dbt data test logic] (https://docs.getdbt.com/docs/build/data-tests).

Hint: A test is an assumption about your model, when you write a test if the output has 0 rows then the test will pass.

#### Bonus: Custom generic test

Update your data test to be a [custom generic test](https://docs.getdbt.com/best-practices/writing-custom-generic-tests).

Once you have done that, add a configuration so that the test will error when more than 10% of the shipment prices are incorrect 
