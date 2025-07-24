/*H1*/

CREATE TABLE countries(
  id_country serial PRIMARY KEY,
  name varchar(50) not null
);

CREATE TABLE users(
  id_users serial PRIMARY KEY,
  id_country integer NOT null, 
  email varchar(100) NOT null,
  name varchar(50) NOT null,
  
  foreign key (id_country) references countries (id_country)
);


/*H2*/

insert into countries (name) values ('argentina') , ('colombia'),('chile');
select * from countries;


insert into users (id_country, email, name) values (2, 'foo@foo.com', 'fooziman'), (3, 'bar@bar.com', 'barziman'); 
select * from users;

delete from users where email = 'bar@bar.com';

update users set email = 'foo@foo.foo', name = 'fooz' where id_users = 1;
select * from users;

select * from users inner join  countries on users.id_country = countries.id_country;

select u.id_users as id, u.email, u.name as fullname, c.name from users u inner join  countries c on u.id_country = c.id_country;

/*H3*/

CREATE TABLE priorities(
  id_priority serial primary key,
  type_name varchar(50) not null
);

CREATE TABLE contact_request(
  id_email serial PRIMARY KEY,
  id_country integer NOT null,
  id_priority integer NOT null,
  name varchar(100) NOT null,
  detail varchar(100) NOT null,
  physical_address varchar(200) NOT null,
  
  foreign key (id_country) references countries (id_country),
  foreign key (id_priority) references priorities (id_priority)
);

/*H4*/

insert into countries (name) values ('Venezuela') , ('Colombia'), ('Brasil') , ('Ecuador') , ('Bolivia');
select * from countries;

insert into priorities (type_name) values ('Regular'), ('Preferencial'), ('VIP');
select * from priorities;

insert into contact_request(id_country, id_priority, name, detail, physical_address) values 
(1, 1, 'Carlos', 'Profesor', 'Caracas'),
(2, 1, 'María', 'Mecánico', 'Valencia'),
(3, 3, 'José', 'Agricultor', 'Bolívar');
select * from contact_request;

delete from contact_request where name = 'José';
select * from contact_request;

update contact_request set name = 'Pedro' where id_email = 1;
select * from contact_request;

/*H5*/

CREATE TABLE roles(
    id_role serial PRIMARY KEY,
    name varchar(50) NOT null
);

CREATE TABLE taxes(
    id_tax serial PRIMARY KEY,
    percentage integer NOT null
);

CREATE TABLE offers(
    id_offer serial PRIMARY KEY,
    status varchar(50) NOT null
);

CREATE TABLE discounts(
    id_discount serial PRIMARY KEY,
    status varchar(50) NOT null,
    percentage integer NOT null
);

CREATE TABLE payments(
    id_payment serial PRIMARY KEY,
    type_pay varchar(50) NOT null
);

CREATE TABLE customers(
    id_customer serial PRIMARY KEY,
    email varchar(50) NOT null,
    id_country INTEGER NOT null,
    id_role INTEGER NOT null,
    name varchar(50) NOT null,
    age integer NOT null,
    password varchar(10),
    physical_address varchar(100),

    foreign key (id_country) REFERENCES countries (id_country),
    foreign key (id_role) REFERENCES roles (id_role)
);

CREATE TABLE invoice_status(
    id_invoice_status serial PRIMARY KEY,
    status varchar(50) NOT null
);

CREATE TABLE products(
    id_product serial PRIMARY KEY,
    id_discount integer NOT null,
    id_offer integer NOT null,
    id_tax integer NOT null,
    name varchar(50) NOT null,
    details varchar(50) NOT null,
    minimum_stock integer NOT null,
    maximum_stock integer NOT null,
    current_stock integer NOT null,
    price DECIMAL(12,2) NOT null,
    price_with_tax DECIMAL(12,2) NOT null,

    foreign key (id_discount) references discounts (id_discount),
    foreign key (id_offer) references offers (id_offer),
    FOREIGN KEY (id_tax) REFERENCES taxes (id_tax)
);

CREATE TABLE products_customers(
    id_product integer NOT null,
    id_customer integer NOT null,

    FOREIGN KEY (id_product) REFERENCES products (id_product),
    FOREIGN KEY (id_customer) REFERENCES customers (id_customer)
);

CREATE TABLE invoices(
    id_invoice serial PRIMARY KEY,
    id_customer integer NOT null,
    id_payment integer NOT null,
    id_invoice_status integer NOT null,
    date date NOT null,
    total_to_pay decimal(12, 2) NOT null,

    FOREIGN key (id_customer) REFERENCES customers (id_customer),
    FOREIGN key (id_payment) REFERENCES payments (id_payment),
    FOREIGN key (id_invoice_status) REFERENCES invoice_status (id_invoice_status)
);

CREATE TABLE orders(
    id_order serial PRIMARY KEY,
    id_invoice integer NOT null,
    id_product integer NOT null,
    detail varchar(50) NOT null,
    amount integer NOT null,
    price decimal(12, 2) NOT null,

    foreign key (id_invoice) references invoices (id_invoice),
    FOREIGN KEY (id_product) references products (id_product)
);

/*H6*/

INSERT INTO countries (name) values ('Venezuela'), ('Colombia'), ('Ecuador');
select * from countries;

INSERT INTO roles (NAME) VALUES ('regular'), ('senior'), ('VIP');
select * from roles;

INSERT INTO taxes (percentage) VALUES (10), (15), (20);
select * from taxes;

INSERT INTO offers (status) VALUES ('New Offer'), ('Past Offer'), ('Clearance');
select * from offers;

INSERT INTO discounts (status, percentage) VALUES ('half', 50), ('quarter', 25), ('min', 10);
select * from discounts;


INSERT INTO payments (type_pay) VALUES ('cash'), ('card'), ('e-wallet');
select * from payments;

INSERT INTO customers (email, id_country, id_role, name, age, password, physical_address) values 
('mariaperez@mail.com', 1, 2, 'María Perez', 25, 'correo1234', 'Av Urdaneta'),
('pedroperez@mail.com', 2, 2, 'Pedro Perez', 27, 'contra1234', 'Av Panteón'),
('luisaramos@mail.com', 3, 3, 'Luisa Ramos', 42, 'pass1234', 'Las Mercedes');
select * from customers;

INSERT INTO invoice_status (status) VALUES ('in-process'), ('processed'), ('cancelled');
select * from invoice_status;

INSERT INTO products (id_discount, id_offer, id_tax, name, details, minimum_stock, maximum_stock, current_stock, price, price_with_tax) VALUES
(3, 2, 3, 'T-Shirt', 'Womens ZARA white small striped', 20, 100, 15, 15.00, 15.00),
(1, 3, 1, 'Pants', 'Womens Mango black small', 20, 100, 50, 40.00, 22.00),
(3, 1, 1, 'Scarf', 'Brown medium', 20, 100, 15, 15.00, 15.00);
select * from products;
  
INSERT INTO products_customers (id_product, id_customer) VALUES (1, 2), (2, 2), (3,3);
select * from products_customers;
  
INSERT INTO invoices (id_customer, id_payment, id_invoice_status, date, total_to_pay) VALUES
(1, 1, 2, '2025-07-15', 15.00),
(2, 3, 3, '2025-07-16', 18.00),
(3, 1, 3, '2025-07-17', 20.00);
select * from invoices;  
  
  
INSERT INTO orders (id_invoice, id_product, detail, amount, price) VALUES
(1, 1, 'ORDERED', 20, 10.00),
(2, 2, 'ORDERED', 30, 15.00),
(1, 2, 'ORDERED', 40, 20.00);
select * from orders;  


delete from users where id_users = (select max(id_users) from users);
select * from users;
  
delete from users where id_users = (select min(id_users) from users);
select * from users;

update taxes set percentage = 12 where id_tax = 1;
update taxes set percentage = 17 where id_tax = 2;
update taxes set percentage = 24 where id_tax = 3;
select * from taxes;

update products set price = 17, price_with_tax = 18.97 where id_product = 1;
update products set price = 45, price_with_tax = 25.20 where id_product = 2;
update products set price = 17, price_with_tax = 17.13 where id_product = 3;
select * from products;






