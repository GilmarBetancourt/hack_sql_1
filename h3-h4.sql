create table priorities(
  id_priority serial primary key,
  type_name varchar(50) not null
);

create table countries(
  id_country serial primary key,
  name varchar(100)
);

create table contact_request(
  id_email serial primary key,
  id_country integer not null,
  id_priority integer NOT null,
  name varchar(100),
  detail varchar (100),
  physical_address varchar(100)

);

insert into countries(name) VALUES ('Venezuela'), ('Colombia'), ('Brasil'), ('Ecuador'), ('Bolivia');
select * from countries

insert into priorities (type_name) values ('Regular'), ('Preferencial'), ('VIP');
SELECT * from priorities

INSERT into contact_request(id_country, id_priority, name, detail, physical_address) values (1, 1, 'Carlos', 'Profesor', 'Caracas'), (2, 1, 'Maria', 'Mecanico', 'Valencia'), (3, 3, 'Jose', 'Agricultor', 'Bolivar');
select * from contact_request

delete from contact_request where name = 'Jose';
select * from contact_request;

update contact_request set name = 'Maria G' where id_email = 2;
SELECT * FROM contact_request;