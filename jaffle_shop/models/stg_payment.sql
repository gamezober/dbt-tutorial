{{
	
	config(
		materialized='table'
		)

}}

with source as

(

	select * from raw.stripe.payment

)

select
	s.orderid as order_id,
	s.paymentmethod as payment_method,
	s.status as payment_status,
	
	-- converting cents to dollars
	s.amount/100.0 as payment_amount,
	s.created as created_at
from
	source s
	