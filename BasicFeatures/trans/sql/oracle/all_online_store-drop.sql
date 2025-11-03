create or replace procedure training_drop_table_if_exists(table_name in varchar2)
as
begin
	execute immediate 'drop table ' || table_name;
exception
	when others then
		if sqlcode != -942 then
			raise;
		end if;
end;
/
create or replace procedure training_drop_seq_if_exists(sequence_name in varchar2)
as
begin
	execute immediate 'drop sequence ' || sequence_name;
exception
	when others then
		if sqlcode != -2289 then
			raise;
		end if;
end;
/
call training_drop_table_if_exists('payments')
/
call training_drop_table_if_exists('line_items')
/
call training_drop_table_if_exists('orders')
/
call training_drop_table_if_exists('customers')
/
call training_drop_table_if_exists('order_addresses')
/
call training_drop_table_if_exists('products')
/
call training_drop_seq_if_exists('line_items_id_seq')
/
call training_drop_seq_if_exists('order_addresses_id_seq')
