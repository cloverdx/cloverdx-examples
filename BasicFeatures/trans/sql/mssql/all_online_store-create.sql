create table customers (
	id bigint not null primary key,
	full_name varchar(100) not null,
	street_address varchar(100),
	city varchar(50),
	postal_code varchar(15),
	state varchar(30),
	country varchar(30),
	email varchar(60),
	phone varchar(60),
	account_created datetime not null,
	is_active tinyint not null
);

create table line_items (
	id bigint identity(1,1) not null primary key,
	order_id bigint not null,
	product_code bigint not null,
	unit_price numeric(10, 2) not null,
	quantity numeric(10, 2) not null
);

create table orders (
	id bigint not null primary key,
	customer_id bigint not null,
	order_datetime datetime not null,
	shipping_address_id bigint not null,
	billing_address_id bigint not null
);

create table payments (
	id bigint not null primary key,
	order_id bigint not null,
	customer_id bigint not null,
	payment_type varchar(4) not null,
	paid_amount numeric(12, 2) not null,
	payment_date datetime not null
);

create table order_addresses (
	id bigint identity(1,1) not null primary key,
	person_name varchar(100) not null,
	street varchar(100),
	city varchar(50),
	zip varchar(15),
	state varchar(30),
	country varchar(30)
);

create table products (
	product_name varchar(150) not null,
	product_code bigint not null primary key,
	unit_price numeric(12, 2) not null,
	supplier varchar(100) not null,
	profit_margin decimal(12, 2) not null
);

alter table orders add foreign key (customer_id) references customers(id) on delete cascade;
alter table orders add foreign key (shipping_address_id) references order_addresses(id) on delete no action;
alter table orders add foreign key (billing_address_id) references order_addresses(id) on delete no action;
alter table line_items add foreign key (order_id) references orders(id) on delete cascade;
alter table line_items add foreign key (product_code) references products(product_code) on delete cascade;
alter table payments add foreign key (customer_id) references customers(id) on delete cascade;
-- order_id FK in payments is not created to allow for exercises in module 8 to run
-- alter table payments add foreign key (order_id) references orders(id) on delete cascade;
