create table customers (
	id number(19, 0) not null primary key,
	full_name varchar2(100) not null,
	street_address varchar2(100),
	city varchar2(50),
	postal_code varchar2(15),
	state varchar2(30),
	country varchar2(30),
	email varchar2(60),
	phone varchar2(60),
	account_created timestamp not null,
	is_active integer not null
)
/
create table line_items (
	id number(19, 0) not null primary key,
	order_id number(19, 0) not null,
	product_code number(19, 0) not null,
	unit_price numeric(10, 2) not null,
	quantity numeric(10, 2) not null
)
/
create table orders (
	id number(19, 0) not null primary key,
	customer_id number(19, 0) not null,
	order_datetime timestamp not null,
	shipping_address_id number(19, 0) not null,
	billing_address_id number(19, 0) not null
)
/
create table payments (
	id number(19, 0) not null primary key,
	order_id number(19, 0) not null,
	customer_id number(19, 0) not null,
	payment_type varchar2(4) not null,
	paid_amount numeric(12, 2) not null,
	payment_date timestamp not null
)
/
create table order_addresses (
	id number(19, 0) not null primary key,
	person_name varchar2(100) not null,
	street varchar2(100),
	city varchar2(50),
	zip varchar2(15),
	state varchar2(30),
	country varchar2(30)
)
/
create table products (
	product_name varchar2(150) not null,
	product_code number(19, 0) not null primary key,
	unit_price numeric(12, 2) not null,
	supplier varchar2(100) not null,
	profit_margin decimal(12, 2) not null
)
/
alter table orders add foreign key (customer_id) references customers(id) on delete cascade
/
alter table orders add foreign key (shipping_address_id) references order_addresses(id) on delete cascade
/
alter table orders add foreign key (billing_address_id) references order_addresses(id) on delete cascade
/
alter table line_items add foreign key (order_id) references orders(id) on delete cascade
/
alter table line_items add foreign key (product_code) references products(product_code) on delete cascade
/
alter table payments add foreign key (customer_id) references customers(id) on delete cascade
/
alter table payments add foreign key (order_id) references orders(id) on delete cascade
/
create sequence line_items_id_seq cache 100
/
create sequence order_addresses_id_seq cache 100
/

create or replace trigger line_items_id_trg
before insert on line_items
for each row
when (new.id is null)
begin
	select line_items_id_seq.nextval into :new.id from dual;
end;
/

create or replace trigger order_addresses_id_trg
before insert on order_addresses
for each row
when (new.id is null)
begin
	select order_addresses_id_seq.nextval into :new.id from dual;
end;
/

alter trigger line_items_id_trg enable/
alter trigger order_addresses_id_trg enable
