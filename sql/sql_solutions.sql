---------------------------------------------------------------------------------------
-- Solutions for book SQL Questions by Xhoni Shollaj
---------------------------------------------------------------------------------------


-- 1. Return the total value of orders handled by each employee for each order year
    SELECT h.empid eid
	     , sum(case when extract(year from s.orderdate) = 2013
			   	 then s.freight else NULL end) "2013"
		 , sum(case when extract(year from s.orderdate) = 2014
				 then s.freight else NULL end) "2014"
		 , sum(case when extract(year from s.orderdate) = 2015
				 then s.freight else NULL end) "2015"
      FROM hr.employees h 
	  JOIN sales.orders s
	    ON s.empid = h.empid
  GROUP BY h.empid;
	 	
		
-- 2. Return customers for whom all employees in the organization handled orders.
    select distinct t0.custid
	  from sales.orders t0
	 where (select count(t1.*) from (select distinct empid from sales.orders) t1)
		 = (select count(t2.*) from (select distinct empid from sales.orders where custid = t0.custid) t2);    

select max(extract(month from orderdate)) from sales.orders limit 10000;


-- 3. Return orders that were placed on the last date of activity of the month
with orders_date as 
(
    select *
	     , (select (date_trunc('MONTH', orderdate::date) + interval '1 month' - interval '1 day')::date) last_day
	  from sales.orders 
)
select * from orders_date where orderdate = last_day;


--4. Return the orders that were placed on the last date of activity of the customer
with orders_castom as 
(
    select *
	     , max(orderdate) OVER(partition by custid) maxdate
	  from sales.orders 
)
select * from orders_castom where maxdate=orderdate;


--5. Return customers who placed orders
    select distinct
		   cus.custid
	     , cus.companyname
	  from sales.orders ord
 left join sales.customers cus
	    on ord.custid = cus.custid
  order by cus.custid;
  

--6. Return order years and the distinct number of customers handled in each year
--for years that had more than 70 distinct customers handled. 
with orders_years as (
	select custid
		 , extract(year from orderdate) o_year
	  from sales.orders
)
	select o_year
	     , count(distinct custid)
	  from orders_years
	 group by o_year
	having count(distinct custid)>70;


--7. Computes the number of orders that were handled in each year, and the
--difference from the count of the previous year.
with orders_years as (
	select extract(year from orderdate) o_year
		 , count(orderid) orders_count
	  from sales.orders
  group by o_year
  order by 	o_year
)
	select *
	     , (orders_count - lag(orders_count) over(order by 	o_year))  diff
	  from orders_years;
	 

--8. Return customers and their orders, (including customers with no orders).
    select distinct cus.custid
	     , cus.companyname
		 , cus.country
	     , ord.orderid
		 , ord.shipcountry
	  from sales.customers cus
 left join sales.orders ord	  
 	    on ord.custid = cus.custid;


--9. Returns only customers who didn’t place orders
    select cus.custid
	  from sales.customers cus  
 	 where cus.custid 
	not in (select distinct custid from sales.orders);



--10. Match employees with their managers, who are also employees
    select 
	       t1.empid mgr_empid
		 , t1.lastname mgr_lastname
		 , t1.firstname mgr_firstname
		 , t1.title mgr_title
		 , t2.empid 
		 , t2.lastname 
		 , t2.firstname 
		 , t2.title 
	from hr.employees t1
	join hr.employees t2
	  on t1.empid = t2.mgrid;


--11. Use a non-equi join with a less than (<) operator to identify unique pairs of employees.
    select 
	       t1.empid "1_empid"
		 , t1.lastname "1_lastname"
		 , t1.firstname "1_firstname"
		 , t1.title "1_title"
		 , t2.empid "2_empid"
		 , t2.lastname "2_lastname"
		 , t2.firstname "2_firstname"
		 , t2.title "2_title"
	from hr.employees t1
	join hr.employees t2
	  on t1.empid < t2.empid;


--12. Join five tables to return customer-supplier pairs that had activity together.
    select 
	       t0.contactname
		 , t4.companyname
	from sales.orders t1
	join sales.customers t0
	  on t1.custid = t0.custid
	join sales.orderdetails t2
	  on t1.orderid = t2.orderid
	join production.products t3
	  on t2.productid = t3.productid
	join production.suppliers t4
	  on t3.supplierid = t4.supplierid;


--13. Return the customer ID and company name of customers who placed orders.
    select distinct
	       t0.contactname
		 , t0.custid
	from sales.orders t1
	join sales.customers t0
	  on t1.custid = t0.custid;


--14. Return locations that are both employee locations and customer locations.
    select distinct
	       t0.city
		 , t0.region
		 , t0.country
	from sales.orders t1
	join sales.customers t0
	  on t1.custid = t0.custid
	join hr.employees t2
	  on t2.empid = t1.empid
   where 1=1
     and coalesce(t2.city, 'NULL') = coalesce(t0.city, 'NULL')
     and coalesce(t2.country, 'NULL') = coalesce(t0.country, 'NULL')
     and coalesce(t2.region, 'NULL') = coalesce(t0.region, 'NULL')
	   ;














