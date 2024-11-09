## Add a missing entity

The table Shipment type can be added

## Add data tests

A key part of data modeling is the grain of the model, and it's the job of the data modeler to make sure that the grain of each 
model is well documented and tested.

In this exercise you will be added tests and documentation to your end models (marts) to test that primary keys are both unique and not null.

## Customers with many businesses

The analysts are currently working on determining how many businesses each customer has. To do this
they need to join `dim_customers` and `dim_business_customers`, however there is no foreign key in either of these
tables to do so.

Add a foreign key to the `dim_business_customers` model so that the analysts can join the data. 
In the `analyses/exercise-customers.sql` file, try joining the tables and count the number of rows - has your query worked as expected? 
(Hint: count the rows in each table: `dim_customers`, `dim_business_customers`, and your joined table)

What do you need to do to solve this?


## Add some columns

- Duration of sending
- Late flag
- Driver num of years
- Driver avg num of jobs per year

## Incremental - page views

- Add the page_views as an incremental

## Slowly changing dimension

The analysts want to be able to store historical data about the shipment types. 
The Shipment price per kg changes at least 3 times over the course of a year. 