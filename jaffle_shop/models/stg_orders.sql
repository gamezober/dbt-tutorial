{{
	
	config(
		materialized='view'
		)

}}

with source as 
(

select * from {{ source('jaffle_shop', 'orders')}}

),

rename as

(

select
    s.id as order_id,
    s.user_id as customer_id,
    s.order_date,
    s.status as order_status
from
	source s
)

select * from rename