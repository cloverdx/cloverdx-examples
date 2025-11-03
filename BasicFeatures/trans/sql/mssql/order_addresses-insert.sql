insert into order_addresses(person_name, street, city, zip, state, country)
values ($name, $street, $city, $zip, $state, $country)
returning $addressId:=auto_generated, $orderId:=$orderId, $type:=$type