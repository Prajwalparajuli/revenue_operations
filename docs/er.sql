
CREATE TABLE Customers
(
  customer_id              VARCHAR NOT NULL,
  customer_unique_id       VARCHAR NULL    ,
  customer_zip_code_prefix INTEGER NULL    ,
  customer_city            VARCHAR NULL    ,
  customer_state           VARCHAR NOT NULL,
  PRIMARY KEY (customer_id),
  FOREIGN KEY (customer_id) REFERENCES Orders(customer_id),
  FOREIGN KEY (customer_zip_code_prefix) REFERENCES Geolocation(geolocation_zip_code_prefix),
  FOREIGN KEY (customer_city) REFERENCES Geolocation(geolocation_city),
  FOREIGN KEY (customer_state) REFERENCES Geolocation(geolocation_state)
  ON DELETE CASCADE
);

CREATE TABLE Geolocation
(
  geolocation_zip_code_prefix INTEGER NULL    ,
  geolocation_lat             DECIMAL NULL    ,
  geolocation_lng             DECIMAL NULL    ,
  geolocation_city            VARCHAR NULL    ,
  geolocation_state           VARCHAR NULL    
);

CREATE TABLE Ordered_Items
(
  order_id            VARCHAR  NOT NULL,
  order_item_id       VARCHAR  NOT NULL,
  product_id          VARCHAR  NULL    ,
  seller_id           VARCHAR  NULL    ,
  shipping_limit_date DATETIME NULL    ,
  price               DECIMAL  NULL    ,
  freight_value       DECIMAL  NULL    ,
  PRIMARY KEY (order_id, order_item_id),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (order_id) REFERENCES Payments(order_id),
  FOREIGN KEY (order_id) REFERENCES Reviews(order_id),
  FOREIGN KEY (product_id) REFERENCES Products(product_id),
  FOREIGN KEY (seller_id) REFERENCES Sellers(seller_id)
  ON DELETE CASCADE
);

CREATE TABLE Orders
(
  order_id                      VARCHAR  NOT NULL,
  customer_id                   VARCHAR  NULL    ,
  order_status                  VARCHAR  NULL    ,
  order_purchase_timestamp      DATETIME NULL    ,
  order_approved_at             DATETIME NULL    ,
  order_delivered_carrier_date  DATETIME NULL    ,
  order_delivered_customer_date DATETIME NULL    ,
  order_estimated_delivery_date DATETIME NULL    ,
  PRIMARY KEY (order_id),
  FOREIGN KEY (order_id) REFERENCES Ordered_Items(order_id),
  FOREIGN KEY (order_id) REFERENCES Payments(order_id),
  FOREIGN KEY (order_id) REFERENCES Reviews(order_id),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
  ON DELETE CASCADE
);

CREATE TABLE Payments
(
  order_id             VARCHAR NOT NULL,
  payment_sequential   INTEGER NOT NULL,
  payment_type         VARCHAR NULL    ,
  payment_installments INTEGER NULL    ,
  payment_value        DECIMAL NULL    ,
  PRIMARY KEY (order_id, payment_sequential),
  FOREIGN KEY (order_id) REFERENCES Orders_Items(order_id),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (order_id) REFERENCES Reviews(order_id)
  ON DELETE CASCADE
);

CREATE TABLE Product_Category_Translation
(
  product_category_name         VARCHAR NOT NULL,
  product_category_name_english VARCHAR NULL    ,
  PRIMARY KEY (product_category_name),
  FOREIGN KEY (product_category_name) REFERENCES Products(product_category_name)
  ON DELETE CASCADE
);

CREATE TABLE Products
(
  product_id                 VARCHAR NOT NULL,
  product_category_name      VARCHAR NULL    ,
  product_name_length        FLOAT   NULL    ,
  product_description_length FLOAT   NULL    ,
  product_photo_qty          FLOAT   NULL    ,
  product_weight_g           FLOAT   NULL    ,
  product_length_g           FLOAT   NULL    ,
  product_height_g           FLOAT   NULL    ,
  product_width_g            FLOAT   NULL    ,
  PRIMARY KEY (product_id),
  FOREIGN KEY (product_id) REFERENCES Ordered_Items(product_id),
  FOREIGN KEY (product_category_name) REFERENCES Product_Category_Translation(product_category_name)
  ON DELETE CASCADE
);

CREATE TABLE Reviews
(
  review_id               VARCHAR   NOT NULL,
  order_id                VARCHAR   NOT NULL,
  review_score            INTEGER   NULL    ,
  review_comment_title    VARCHAR   NULL    ,
  review_comment_message  VARCHAR   NULL    ,
  review_creation_date    DATE      NULL    ,
  review_answer_timestamp TIMESTAMP NULL    ,
  PRIMARY KEY (review_id, order_id),
  FOREIGN KEY (order_id) REFERENCES Orders_Items(order_id),
  FOREIGN KEY (order_id) REFERENCES Orders(order_id),
  FOREIGN KEY (order_id) REFERENCES Payments(order_id)
  ON DELETE CASCADE
);

CREATE TABLE Sellers
(
  seller_id              VARCHAR NOT NULL,
  seller_zip_code_prefix INTEGER NULL    ,
  seller_city            VARCHAR NULL    ,
  seller_state           VARCHAR NULL    ,
  PRIMARY KEY (seller_id),
  FOREIGN KEY (seller_id) REFERENCES Ordered_Items(seller_id),
  FOREIGN KEY (seller_zip_code_prefix) REFERENCES Geolocation(geolocation_zip_code_prefix),
  FOREIGN KEY (seller_city) REFERENCES Geolocation(geolocation_city),
  FOREIGN KEY (seller_state) REFERENCES Geolocation(geolocation_state)
  ON DELETE CASCADE 
);
