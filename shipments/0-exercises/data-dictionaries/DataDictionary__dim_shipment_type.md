| Column Name     | Description                                                         |
|-----------------|---------------------------------------------------------------------|
| shipment_type   | Describes the type of shipment (Regular or Express).  |
| price_per_kg    | Price charged per kilogram for the shipment.                        |
| shipment_type_id| Unique identifier for the type of shipment.                         |

**Note**: This table is names `dim_shipment_type_<month>` for each month of the year, 
as the `price_per_kg` is reviewed monthly and updated when necessary.