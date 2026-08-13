# Revenue and Operatioins Intelligence Platform

Data Source: Olid Brazilian E-commerce dataset, kaggle

## Source Inventory, and Profile Evidence

This dataset contains 9 csv files, where each csv files contain data about customers, their geolocation, items they ordered, their payments information, the product reviews, order details with shpping data, all the products from the sellers, the list of all the sellers, and the product translation into english. 

Below are the specific files in this dataset and their information:

**olist_customers_dataset.csv**
This dataset contains the information about customers that have placed an order from the sellets, it contains 

- customer_id - This customer id is the key for the dataset, so a single customer has different customer ids for different orders. 
  
  - Data type - string

- customer_unique_id -  This is the unique customer id for a single customer.
  
  - Data type - string

- customer_zip_code_prefix - This is the customer's zip code. 
  
  - Data type - int64

- customer_city - This is customer's city.
  
  - Data type - string

- customer_state - This is customer's state. 
  
  - Data type - string

- Row Count = 99441

- Column Count = 5

- There are no missing values in this dataset. 

- Each row represents a customer with their id for each orders and their unique identifier customer id for the whole dataset, and their location/address. 

- **Business Meaning** = This dataset file can be used to identify customers, and relate to what they ordered, where do they live, what relevent products can be recommended to them based on their location, and their order history after connecting them to their orders. Possibility for personalized Ads, and Ads based of where they live with what is the trend in that part of the location. 

- No duplicate rows

**olist_geolocation_dataset.csv**
This dataset contains the information about precise geolocation. 

- geolocation_zip_code_prefix - Zip code for all the customers that has placed the order.
  
  - Data type - int64

- geolocation_lat - Latitude for that zip code 
  
  - Data type - float64

- geolocation_lng - Longitude for that zip code
  
  - Data type -  float64             

- geolocation_city - City where the zip code is located.
  
  - Data type - string             

- geolocation_state - State of the location
  
  - Data type - string

- Row Count = 1000163

- Column Count = 5

- There are no missing values in this dataset. 

- Each row represents the precise location of the zip code where the customers are located. 

- Total duplicate rows = 261831

- Total unique zip codes = 19015 ; This means one zip code prefix appears more than once as there are 1000163 total rows and 261831 duplicate rows, which means a state can have multiple zip codes and a state can have multiple cities which makes zip codes non unique. 

- zip code prefix can have multiple longitude and latitude, as longitude and latitude is precise geolocation, and in a wider zip code area, there will definitely be multiple longitude and latitudes. 

- **Business Meaning** = This dataset file can be used for pin pointing the location of where the orders has been placed once combined with the orders and customers. Which then could be used to run ad for that location, and get information about which products are being ordered in which part of the country so that the inventory managements is streamlined by storing more or less of the products that are being bought in that area or not being bought in that area. 

- No duplicate rows

**olist_order_items.csv**
This dataset contains the information about the items purchased within each order

- order_id - Unique order id for each order placed by a customer.
  
  - Data type -  string

- order_item_id - Sequential number identifying number of items included in the same order.
  
  - Data type - int64

- product_id - product unique identifier
  
  - Data type - string

- seller_id - seller unique identifier
  
  - Data type - string

- shipping_limit_date - Shows the seller shipping limit date for handling the order over to the logistic partner.
  
  - Data type - string

- price - item price
  
  - Data type -  float64

- freight_value - Item freight value (if an order has more than one item the freight value is splitted between items.) This is the shpping cost of the item
  
  - Data type - float64

- Mentioned in the data metadata in Kaggle
  
  - Total order_item value = price * quantity of the items ordered
  - Total freight value = shipping cost * quantity of the items ordered
  - Total order value = Total order_item value + Total freight value

- Row Count = 112650

- Column Count = 7

- There are no missing values in this dataset. 

- Each row represents what item was ordered in a single order, what is the price of the item, what is the shipping date from the seller to the logistic company, what is the shipping cost, which seller sold the product and what product was sold. 

- **Business Meaning** = This dataset gives us information on what products were ordered from which seller along with the price and shpping cost of the product. Could be used to analyze which sellers sells the most product, which item was sold the most, which items were sold the least, which item cost the most or least, what is the max shipping cost, which item is popular or not popular which could be discontinued, give us valuable information on which items could be placed on sale for maximum sales revenue. 

- No duplicate rows

**olist_order_payments_dataset.csv**
This dataset contains the information about the orders payment options

- order_id - Unique identifier of an order
  
  - Data type - string

- payment_squential - Number representing if customer split the payments into multiple payment methods or cards, 1 is not, others representing number multiple payment methods. 
  
  - Data type - int64

- payment_type - method of payment chosen by the customer
  
  - Data type -  string             

- payment_installments - Number of installments chosen by the customer.
  
  - Data type - int64             

- payment_value - Transaction value
  
  - Data type - float64

- Row Count = 103886

- Column Count = 5

- There are no missing values in this dataset. 

- Each row represents customers choice of payment type, their installment, their number of payments method used and their order total payment. 

- **Business Meaning** = This dataset file give insights into customer choice of payment, and their financail condition (only on the surface level). Also, give information on which payment methods are mostly use. If credit cards is used the most could be used as data to open a rewards credit card partnering with financial institution giving customer more insentives with cash backs or rewards. 

- No duplicate rows

**olist_order_reviews_dataset.csv**
This dataset provides information about customers reviews and comments with their order_id, score, title, message, date and timestamp of the review. 

 0   review_id                99224 non-null  str  
 1   order_id                 99224 non-null  str  
 2   review_score             99224 non-null  int64
 3   review_comment_title     11568 non-null  str  
 4   review_comment_message   40977 non-null  str  
 5   review_creation_date     99224 non-null  str  
 6   review_answer_timestamp  99224 non-null  str  

- Row count = 99224
- Column count = 7
- No duplicate rows.
- Null values are contained in 2 coulmns where customer gave scrore reviews only with no comments and no title. (Normal for customer reviews)
  - review_comment_title = 87656 (null values)
  - review_comment_message = 58247 (null values)
- Each row represnent customer review for a particular product.
- **Business Meaning** = This dataset give information on who users liked or disliked the products. This information provides insights on sellers and their products, which could be used to accept less of or more of the products that the sellers has to offer. And provide information to sellers about their product perception from the users so they can improve their product quality. This also give information on the logistic providers and thier handling of the products once it leaves the sellers warehouse. 

**olist_products_dataset.csv**
This dataset contains information about the products sold.
This dataset contains information about the product unqiue identifier, category, name length, description length, photo quantity uploaded to the website, product weight, length, height, and width. 
   Column                      Non-Null Count  Dtype  

---  ------                      --------------  -----  

 0   product_id                  32951 non-null  str    
 1   product_category_name       32341 non-null  str    
 2   product_name_lenght         32341 non-null  float64
 3   product_description_lenght  32341 non-null  float64
 4   product_photos_qty          32341 non-null  float64
 5   product_weight_g            32949 non-null  float64
 6   product_length_cm           32949 non-null  float64
 7   product_height_cm           32949 non-null  float64
 8   product_width_cm            32949 non-null  float64

- Row count = 32951
- Column count = 9
- No duplicate rows
- There are 610 null values in each of the product categiry name, product name length, product description length, and photo quantity. Which means either sellers did not provide any information about this product or at the time of the data creation these products were just being added and were not complete. There are 2 null values in each of the product weight, length, height and width.
- Each row represents a product that is listed for sale and its details. 
- **Business meaning** =  This dataset simply provided information on what products are currently being listed for sale in the olist website. 

**olist_sellers_dataset.csv**
This dataset contains information about the sellers, and their location.

   Column                  Non-Null Count  Dtype

---  ------                  --------------  -----

 0   seller_id               3095 non-null   str  
 1   seller_zip_code_prefix  3095 non-null   int64
 2   seller_city             3095 non-null   str  
 3   seller_state            3095 non-null   str  

- Row count = 3095
- Column count = 4
- No duplicate rows
- No null values
- **Business Meaning** = This dataset gives information about the who sellers are and where are they selling products from. This could be used to create more diveresity in the products being sold in the website, also could be used to find and recommend local sellers products for the users living in the same area as sellers so the shipping cost could be lowers and shipping times could be faster. 

**product_category_name_translation.csv**
This dataset simply provides the English translation for the Portugees product category names. 
     Column                         Non-Null Count  Dtype

---  ------                         --------------  -----

 0   product_category_name          71 non-null     str  
 1   product_category_name_english  71 non-null     str  

- Row count = 71
- Column count = 2
- No diplicate rows
- No null values
- **Busniess Meaning** = There are 71 total product categories, portugees names of the product category could be used for the portugees speaking customers, and english for wider diversity of customers. 

**olist_orders_dataset.csv**
This dataset contains information about the orders from each customer.
     Column                         Non-Null Count  Dtype

---  ------                         --------------  -----

 0   order_id                       99441 non-null  str  
 1   customer_id                    99441 non-null  str  
 2   order_status                   99441 non-null  str  
 3   order_purchase_timestamp       99441 non-null  str  
 4   order_approved_at              99281 non-null  str  
 5   order_delivered_carrier_date   97658 non-null  str  
 6   order_delivered_customer_date  96476 non-null  str  
 7   order_estimated_delivery_date  99441 non-null  str  

- Row count = 99441
- Column count = 8
- No duplicate rows
- 4908 null values
- **Business Meaning** = This dataset gives information about each orders from customer, this is more like transactional dataset where this gives information about what each customer has ordered or is ordering, so recommendation system could be built based on customer habit and activity and recommend new products that they may like. 
- Each row represent each customers order placed. 

## Explaining grain

- Orders = One row of order represent a single order of a customer and their details.
- Order items = One row represent item information on what the product that customer ordered. 
- Payments = One row represent payement attributes and value of each order. 
- Reviews =  One row represent product review in the order made by customer.
- Geolocation = One row represent precise location of where orders have been placed from. 

## Test candidate keys

|Dataset |Column Names| 

|Customers| customer_id| 
|Geolocation | geolocation_lat & geolocation_lng| 
|Ordered Items | order_id & order_item_id| 
|Payments  | order_id & payement_sequential | 
|Reviews  | reviews_id & order_id |
|Orders  | order_id |
|Products  | product_id|
|Product category translation| product_category_name| 

- why raw Geolocation can duplicate customer rows and inflate totals after a join.
   Joining geolocation to customers data set with common column zip code, city and state can inflate theh joined rows because there are multiple geolocation coordinates (longitude and latitude) that associated with the same zip codes or others where there are only 19015 unique zip codes, 8011 unique cities, and 27 unique states in the geolocations dataset, if joined with only these attributes, thhe other non unique latitude and longitude will also be associated with the join and will repeat the customer info across the row for each of those coordinates. Here zip code can be used as primary key in the geolocation only if all the duplicate rows are removed, that might mean removing the precise longitude and latitude coordinates. 
