use northwind;

-- 1.Which employee generated the highest revenue in the last year?
select e.id, e.first_name, e.last_name, sum(od.unit_price * od.quantity * (1 - od.discount)) as 'Highest_Revenue'
from orders o
join order_details od on o.id = od.order_id
join employees e on e.id = o.employee_id 
where YEAR(o.order_date) = 2006 
group by e.id, e.first_name, e.last_name
order by Highest_Revenue DESC
limit 1;

-- 2. Who are the top 5 customers by total order value?
select c.first_name, sum(od.unit_price * od.quantity * (1 - od.discount)) as 'Order_Value'
from customers c
join orders o on c.id = o.customer_id
join order_details od on o.id = od.order_id
group by c.first_name
order by Order_Value DESC
limit 5;

-- 3.What products have the highest profit margin?
SELECT 
    p.product_code, 
    p.product_name, 
    SUM((od.unit_price - p.standard_cost) * od.quantity) AS total_profit,
    AVG((od.unit_price - p.standard_cost) / od.unit_price * 100) AS profit_margin
FROM products p
JOIN order_details od 
    ON od.product_id = p.id
GROUP BY p.product_code, p.product_name
ORDER BY profit_margin DESC
LIMIT 5;

-- 4.Which customers haven’t ordered in the last 6 months?
select c.first_name
from customers c
where c.id not in (
      select distinct o.customer_id 
      from orders o
	  where o.order_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH));

-- 5.Which suppliers provide the most products?
select s.first_name, count(p.id) as 'MostProductSells'
from suppliers s
join products p on s.id = p.supplier_ids
group by s.first_name
order by MostProductSells DESC;

-- 6.Average order value per customer segment
select c.country_region , avg(od.unit_price * od.quantity * (1 - od.discount)) as 'Order_Value'
from customers c
join orders o on c.id = o.customer_id
join order_details od on o.id = od.order_id
group by c.country_region
order by Order_Value DESC;

-- 7. Which product combinations are most frequently ordered together?
select od1.product_id as 'FirstProduct',
od2.product_id as 'SecondProduct', count(*) as 'Comb_Count'
from order_details od1 
join order_details od2 on od1.order_id = od2.order_id 
and od1.product_id < od2.product_id
group by od1.product_id, od2.product_id
order by Comb_Count DESC;






