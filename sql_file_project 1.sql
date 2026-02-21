-- create table--

CREATE table retail_sales 
      (transactions_id int primary key,	
        sale_date date,
       sale_time time,
       customer_id int,	
       gender	varchar (15),
       age int,	
       category varchar(15),
       quantiy int,
       price_per_unit	float,
       cogs	float,
      total_sale float
                     );
--
	select * from retail_sales;
--

	select count(*) from retail_sales;
--

	select * from retail_sales
	where 
	    transactions_id is null
		or
		sale_date is null
		or
		sale_time is null
		or 
		gender is null
		or 
		age is null
		or
		category is null
		or
		quantiy is null
		or
		price_per_unit is null
		or
		cogs is null
		or 
		total_sale is null ;
		
--
		select * from retail_sales
	where 
	    transactions_id is null
		or
		sale_date is null
		or
		sale_time is null
		or 
		gender is null
		or 
		age is null
		or
		category is null
		or
		quantiy is null
		or
		price_per_unit is null
		or
		cogs is null
		or 
		total_sale is null ;

--
delete from retail_sales
	where 
	    transactions_id is null
		or
		sale_date is null
		or
		sale_time is null
		or 
		gender is null
		or 
		age is null
		or
		category is null
		or
		quantiy is null
		or
		price_per_unit is null
		or
		cogs is null
		or 
		total_sale is null ;

----- data exploration-----

---Q1. how many sales we have?---

select count(*) as total_sales from retail_sales

--- Q2 how many customers we have?---
select count(*) as customer_id from retail_sales

--- Q3 how many unique customer ?

select count (distinct customer_id) from retail_sales

---- data analysis----------

---- Q1. retrive all columns for sales made on '2022-11-05'----

select * from retail_sales 
where sale_date = '2022-11-05'

---- Q2 retrive columns where  category is clothing, quantity sold is more than and equal to 4, and in month of nov-2022----

select * from retail_sales 
where
  category='Clothing'
  and 
  To_Char(sale_date,'yyyy-mm')= '2022-11'
  and
  quantiy >=4

--- Q3 calculate total sales of each category

select category, sum(total_sale)as net_sale from retail_sales
group by category

---- Q4 find avg age of customers who purchased items from 'beauty ' category

select avg(age) as average_cust_age from retail_sales
where
category='Beauty'

---- Q5 find out all transactions where total sales greater than 1000

select * from retail_sales
where
total_sale>1000

---- Q6 find out all transaction(transaction_id) made by each gender in each category?

select count(transactions_id)as total_transaction, gender, category 
from retail_sales
group by gender, category

------ Q7 (a) find out the avg sale for all months in each year  
            (b) best selling month in each year?

-- (a)
select 
extract (year from sale_date)as year,
extract (month from sale_date)as month, 
avg(total_sale) as avg_sale, 
rank() over (partition by extract (year from sale_date)  order by avg (total_sale) desc)
from retail_sales
group by year, month 

--- (b) 
select * from
(
select 
extract (year from sale_date)as year,
extract (month from sale_date)as month, 
avg(total_sale) as avg_sale, 
rank() over (partition by extract (year from sale_date)  order by avg (total_sale) desc)
from retail_sales
group by year, month) as best_month
where rank=1


------ Q8 Find out top 5 customers based on highest total sales?

select customer_id, sum(total_sale)from retail_sales 
group by 1
order by 2 desc
limit 5


----- Q9 find out no of unique customers who purchased items from each category?


select category, count(distinct customer_id) from retail_sales
group by category


----- Q10 write a query to create shift and no of orders eg. morning < 12, afternoon btw 12 and 17. evening >17

with hourly_sales
as
(select *, 
  case
  when extract (hour from sale_time)<12 then 'morning'
  when extract (hour from sale_time) between 12 and 17 then 'afternoon' 
  else 'evening'
  end as shift 
  from retail_sales ) 

 select 
 shift, count(transactions_id)as total_orders from hourly_sales
 group by shift


 ------------------------ End of project----------------------------