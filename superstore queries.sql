use superstore;

-- 1.What are the total sales and profit by region?
select region , sum(sales) as 'Total Sales' , sum(profit) as 'Total Profit'
from superstore
group by region;

-- 2.Which product categories are most profitable?
select category ,sum(profit) as 'Total_Profitable'
from superstore
group by category
order by Total_Profitable DESC;

-- 3.Who are the top 10 customers by sales?
select `customer name`, sum(sales) as 'Total Sales'
from superstore
group by `customer name`
order by `Total Sales` DESC
limit 10 ;

-- 4.What is the monthly sales trend over time?
-- if field for example order date in text format we can use this method 
SELECT DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%Y-%m') AS Month , sum(sales) AS Total_Sales
FROM superstore
GROUP BY DATE_FORMAT(STR_TO_DATE(`Order Date`, '%m/%d/%Y'), '%Y-%m')
ORDER BY Month;

-- if field for example order date in varchar  format we can use this method 
select date_format(`order date`, '%y-%m') as month, sum(sales) as total_sales
from superstore
group by date_format(`order date`, '%y-%m')
order by month;

-- 5.Which shipping mode is used most often?
select `ship mode` , count(*) as 'total_orders'
from superstore
group by `ship mode`;

-- 6.Which states and cities contribute the most to profit?
select city, state, sum(profit) as 'Total_Profit'
from superstore
group by city, state
order by Total_Profit DESC
limit 10;

-- 7.What is the average discount given per category?
select category, avg(discount) as 'Average_Discount'
from superstore
group by category
order by Average_Discount DESC;

-- 8.Which orders resulted in losses (negative profit)?
select `order Id`, `Product Name`, sales, profit
from superstore
where profit < 0
group by `order Id`, `Product Name`, sales, profit;

-- 9.Which customers purchased more than 5 times?
SELECT 
    `Customer Name`,
    COUNT(DISTINCT `Order ID`) AS Order_Count
FROM superstore
GROUP BY `Customer Name`
HAVING COUNT(DISTINCT `Order ID`) > 5
ORDER BY Order_Count DESC;

-- 10. What are the top 5 products by revenue?
select `product name`, sum(sales) as'Revenue'
from superstore
group by `product name`
order by Revenue DESC
limit 5;