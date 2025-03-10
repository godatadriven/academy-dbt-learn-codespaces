### Exercise: Adding Key Metric Columns to Improve Shipment and Driver Analysis

In this exercise, you will enhance the existing models by adding important key metric columns that can provide deeper insights into your data. These metrics are essential for better analysis, reporting, and decision-making. You will add the following columns:

1. **Duration of Sending**: Calculate the duration from `creation date` to `send date` in the `fct_shipments` table.
2. **Late Flag**: Add a flag in the `fct_shipments` table that indicates whether a shipment is late based on the type of delivery:
    - Trucks should take 10 days from creation to received
    - Bicycles should take 7 days from creation to received
    - Drones should take 14 days from creation to received
3. **Driver Number of Years Employed**: Add a column in the `dim_drivers` table that calculates the number of years a driver has been employed, but only if they are still employed.
4. **Driver Average Number of Jobs per Year**: Calculate the total number of jobs a driver has completed and add it to the `dim_drivers` table.

### Conclusion

By completing this exercise, you have added several key metric columns that provide valuable insights into the shipment process and driver performance:

These metrics are essential for analyzing and optimizing the performance of shipments and drivers in your organization.