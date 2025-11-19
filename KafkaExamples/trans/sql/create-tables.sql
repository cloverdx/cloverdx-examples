CREATE TABLE public.customers_in (
	id int8 NULL,
	full_name varchar(100) NULL,
	street_address varchar(100) NULL,
	city varchar(50) NULL,
	postal_code varchar(15) NULL,
	state varchar(30) NULL,
	country varchar(30) NULL,
	email varchar(60) NULL,
	phone varchar(60) NULL,
	account_created date NULL,
	is_active boolean NULL,
	last_updated timestamp NULL
);