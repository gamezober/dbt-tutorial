{{
	
	config(
		materialized='view'
		)

}}

with source as 

(

	select * from {{ source('jaffle_shop', 'customers') }}

),

rename as

(

select
    s.id as customer_id,
    s.first_name,
    s.last_name
from
	source s

)

select	* from rename
