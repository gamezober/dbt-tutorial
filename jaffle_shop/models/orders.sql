{{
	
	config(
		materialized='table'
		)

}}

with orders as

(

	select * from {{ ref('stg_orders') }}

),

payments as

(

	select * from {{ ref('stg_payment') }}

),

order_agg as 
(
select
	o.*,
	sum(case when p.payment_status = 'success' then p.payment_amount else 0 end) as successfully_paid_amount,
	sum(case when p.payment_status = 'failed' then p.payment_amount else 0 end) as failed_paid_amount
from
	payments p
join
	orders o on o.order_id = p.order_id
group by
	o.order_id,
	o.customer_id,
	o.order_date,
	o.order_status
)

select * from order_agg

