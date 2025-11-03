insert into order_addresses(person_name, street, city, zip, state, country)
values ($name, $street, $city, $zip, $state, $country)
returning $addressId:=id, $orderId:=$orderId, $type:=$type