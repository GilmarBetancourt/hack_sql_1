CREATE TABLE COUNTRIES(
  id_country serial PRIMARY KEY,
  Name varchar(50) NOT NULL
  );
  
CREATE TABLE ROLES(
  id_role serial primary key,
  name varchar(50) not NULL
  );
  
CREATE TABLE TAXES(
  id_tax serial primary key,
  percentage integer not NULL
  );
    
CREATE TABLE OFFERS(
  id_offer serial primary key,
  status varchar(50) not NULL
  );
    
CREATE TABLE DISCOUNTS(
  id_discounts serial primary key,
  status varchar(50) not NULL,
  percentage integer not null
  ); 
  
CREATE TABLE PAYMENTS(
  id_payment serial primary key,
  type varchar(50) not null
  );
  
CREATE TABLE CUSTOMERS(
  id_customer serial primary key,
  email varchar(50) not null,
  id_country INTEGER not null,
  id_role INTEGER not null,
  name varchar(50) NOT null,
  age integer not null,
  password varchar(10),
  physical_address varchar(50),
  
  foreign key (id_country) REFERENCES COUNTRIES (id_country),
  foreign key (id_role) REFERENCES ROLES (id_role)
  
  );
  
create table INVOICE_STATUS(
  id_invoice_status serial primary key,
  status varchar(50) not null
  );
  
CREATE TABLE PRODUCTS(
  id_product serial PRIMARY key,
  id_discounts integer not null,
  id_offer integer not null,
  id_tax integer not null,
  name varchar(50) not null,
  details varchar(50) not null,
  minimum_stock integer not null,
  maximum_stock integer not null,
  current_stock integer not null,
  price integer not null,
  price_with_tax integer not null,
  
  foreign key (id_discounts) references DISCOUNTS (id_discounts),
  foreign key (id_offer) references OFFERS (id_offer),
  FOREIGN KEY (id_tax) REFERENCES TAXES (id_tax)  
  );
  
CREATE TABLE PRODUCT_CUSTOMERS(
  id_product integer not null,
  id_customer integer not null
  );
  
CREATE TABLE INVOICES(
  id_invoice serial primary key,
  id_customer integer not null,
  id_payment integer not null,
  id_invoice_status integer not null,
  DATE date not null,
  total_to_pay decimal(12, 2) not null,
  
  FOREIGN key (id_customer) REFERENCES CUSTOMERS (id_customer),
  FOREIGN key (id_payment) REFERENCES PAYMENTS (id_payment),
  FOREIGN key (id_invoice_status) REFERENCES INVOICE_STATUS (id_invoice_status)
  
  );
  
CREATE TABLE ORDERS(
  id_order serial primary key,
  id_invoice integer not null,
  id_product integer not null,
  detail varchar(50) not null,
  amount integer not null,
  price decimal(12, 2) not NULL,
  
  foreign key (id_invoice) references INVOICES (id_invoice),
  FOREIGN KEY (id_product) references PRODUCTS (id_product)
  
  );
  