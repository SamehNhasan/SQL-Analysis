use Assignment
--Creating table cities contains 2 columns Id as int Primary Key, City as Vachar(50)
create table cities 
	(
	Id int primary key,
	City varchar(50)
	);

--Creating table Meal_Types contains 2 columns Id as int primary key, Meal_Type as varchar(50)
create table meal_types
	(
	Id int primary key,
	meal_type varchar(50)
	);

/*Creating table Meals contains 7 columns Id as int primary key, restaurant_id as int (forgin key for restaurant),
serve_type_id as int (froeign key for serve_type), meal_type_id as int (frogine key for meal_type),
hot_cold as varchar(10), meal_name as varchar(20), price as decimal*/

create table meals
	(
	Id int primary key,
	restaurant_id int,
	serve_type_id int,
	meal_type_id int,
	hot_cold varchar(10),
	meal_name varchar(10),
	price decimal(10,2)
	);
/*creating table members contains 7 columns Id as int primary key, first_name as varchar(40),
surname as varchar(40), sex as varchar(10), email as varchar(100), city_id as int (froeign key for cities),
monthly_budget as int.*/

create table members
	(
	Id int primary key,
	first_name varchar(40),
	surname varchar(40),
	sex varchar (10),
	email varchar(100),
	city_id int,
	monthly_budget decimal(10,2)
	);

/*creating table monthly_member_totals contains 14 columns member_id as int primery key, first_name as varchar(40),
surname as varchar(40), sex as varchar(10), email as varchar(100), city as varchar(40), year as int, month as int,
order_count as int, meals_count as int, monthly_budget as decimal (10,2), total_expense as decimal(10,2),
balance as decimal(10,2), commission as decimal(10,2).*/

create table monthly_member_totals
	(
	member_id int,
	first_name varchar(40),
	surname varchar(40),
	sex varchar(10),
	email varchar(100),
	city varchar(40),
	year int,
	month int,
	order_count int, 
	meals_count int,
	monthly_budget decimal (10,2),
	total_expense decimal(10,2),
	balance decimal(10,2),
	commission decimal(10,2)
	);

--Creating table order_details contains 3 columns Id as int Primary Key, order_id as int, meal_id as int.

create table order_details
	(
	Id int primary key,
	order_id int,
	meal_id int
	);

/*Creating table orders contains 6 columns Id as int primary key, date as date, hour as time,
member_id as int (froeign key for members), restaurant_id  as int (frogine key for restaurants),
total_order decimal(10,2).*/

create table orders
	(
	id int primary key,
	date date,
	hour time,
	member_id int,
	restaurant_id int,
	total_order decimal(10,2)
	);

--Creating table restaurant_type contains 2 columns Id as int Primary Key, restaurant_type as Vachar(50)
create table restaurant_type
	(
	id int primary key,
	restaurant_type varchar(50)
	);

/*Creating table restaurants contains 5 columns id as int primary key, restaurant_name as varchar(40),
restaurant_type_id as int (froeign key for restaurant_type ), income_persentage as decimal,
city_id as int (frogine key for Cities).*/

create table restaurants
	(
	id int primary key,
	restaurant_name varchar(40),
	restaurant_type_id int,
	income_persentage decimal,
	city_id int
	);

--Creating table serve_types contains 2 columns id as int Primary Key, serve_type as Vachar(40)
create table serve_types
	(
	id int primary key,
	serve_type varchar(40)
	);

--importing data from cities.csv files
bulk insert dbo.cities
from 'I:/Courses/Data analysis/Technical/Assignment/archive/cities.csv'
with (
    fieldterminator = ',',
    rowterminator = '\n',
    firstrow = 2 --to avoid importing first row
	);

--importing data from meal_types.csv files
bulk insert dbo.meal_types
from 'I:/Courses/Data analysis/Technical/Assignment/archive/meal_types.csv'
with (
    fieldterminator = ',',
    rowterminator = '\n',
    firstrow = 2 --to avoid importing first row
	);


--importing data from meals.csv files
bulk insert dbo.meals
from 'I:/Courses/Data analysis/Technical/Assignment/archive/meals.csv'
with (
    fieldterminator = ',',
    rowterminator = '\n',
    firstrow = 2 --to avoid importing first row
	);

--importing data from members.csv files
bulk insert dbo.members
from 'I:/Courses/Data analysis/Technical/Assignment/archive/members.csv'
with (
    fieldterminator = ',',
    rowterminator = '\n',
    firstrow = 2 --to avoid importing first row
	);

--importing data from monthly_member_totals.csv files
bulk insert dbo.monthly_member_totals
from 'I:/Courses/Data analysis/Technical/Assignment/archive/monthly_member_totals.csv'
with (
    fieldterminator = ',',
    rowterminator = '\n',
    firstrow = 2 --to avoid importing first row
	);

--importing data from order_details.csv files
bulk insert dbo.order_details
from 'I:/Courses/Data analysis/Technical/Assignment/archive/order_details.csv'
with (
    fieldterminator = ',',
    rowterminator = '\n',
    firstrow = 2 --to avoid importing first row
	);

--importing data from orders.csv files
BULK insert dbo.orders
from 'I:/Courses/Data analysis/Technical/Assignment/archive/orders.csv'
with (
    fieldterminator = ',',
    rowterminator = '\n',
    firstrow = 2 --to avoid importing first row
	);

--importing data from restaurant_type.csv files
bulk insert dbo.restaurant_type
from 'I:/Courses/Data analysis/Technical/Assignment/archive/restaurant_types.csv'
with (
    fieldterminator = ',',
    rowterminator = '\n',
    firstrow = 2 --to avoid importing first row
	);

--importing data from restaurants.csv files
bulk insert dbo.restaurants
from 'I:/Courses/Data analysis/Technical/Assignment/archive/restaurants.csv'
with (
    fieldterminator = ',',
    rowterminator = '\n',
    firstrow = 2 --to avoid importing first row
	);

--importing data from serve_types.csv files
bulk insert dbo.serve_types
from 'I:/Courses/Data analysis/Technical/Assignment/archive/serve_types.csv'
with (
    fieldterminator = ',',
    rowterminator = '\n',
    firstrow = 2 --to avoid importing first row
	);
select * from cities --test query result



--select top 10 cusomers with highest monthly budget and with total expenses
select top 10
	member_id, first_name, surname, 
	sum(monthly_budget) as monthly_budgets, --summing monthly budget
	sum(total_expense) as total_expenses  --summing total expenses
from
	monthly_member_totals
group by
	member_id, first_name, surname
order by 
	monthly_budgets, total_expenses desc;

--select top 5 meals have most sales in cities it's necessaryto join 5 tables 
select top 5
	c.City as city,
	m.meal_name as Meal,
	sum(o.total_order) as total_meal_ordered
from
	cities c
		right outer join 
    restaurants r on c.id = r.city_id --right outer join to get all records from table restaurants 
		right outer join
	orders o on r.id = o.restaurant_id --right outer join to get all records from table orders
		right outer join
	order_details od on o.id = od.order_id --right outer join to get all records from table order_details 
		left outer join
	meals m on od.meal_id = m.id --left outer join to get all records from table order_details 
group by 
	c.City,
	m.meal_name
order by
	total_meal_ordered desc;

--select Most Popular Meal Choise by Gender it's necessaryto join 4 tables 
select top 6
    mb.sex,
    m.meal_name,
    SUM(o.total_order) as total_ordered_meal
from
    members mb
		left outer join
    orders o on o.member_id = mb.id --left outer join to get all records from table orders 
		left outer join
    order_details od on od.order_id = o.id  --left outer join to get all records from table order_details
		right outer join
    meals m on od.meal_id = m.id  --right outer join to get all records from table meals
group by
    mb.sex,
    m.meal_name
order by
    total_ordered_meal desc;

--select Top 20 Members have most Expenses in each city
select top 20
    c.city as city,
    m.first_name,
    m.surname,
	m.sex,
    m.monthly_budget
from	
    cities c
		left outer JOIN
    members m on m.city_id = c.id --left outer join to get all records from table members
group by
    c.city,
    m.first_name,
    m.surname,
	m.sex,
    m.monthly_budget
order by
    m.monthly_budget desc;

--find Average Order Value for each sex_type

select
    m.sex,
    avg(o.total_order) as Average_order
from
    members m
		left outer join
	orders o on o.member_id = m.id --left outer join to get all records from table orders
group by
    m.sex
order by
    Average_order desc;

--find Relation Between Month and Orders' Volume it's necessaryto join 4 tables
select
	c.city as city,
	datename(month, o.date) as Order_month, --transfer date type to show month name
	sum(o.total_order) as total_order
from
	orders o
		left outer join	
	restaurants r on o.restaurant_id = r.id --left outer join to get all records from table orders
		left outer join
	cities c on r.city_id =  c.id  --left outer join to get all records from table restaurants
		left outer join
	order_details od on od.order_id = o.id --left outer join to get all records from table order_details
group by
	c.city,
	datename(month, o.date)
order by
	c.city,
	datename(month, o.date);



--find Average Sales in Cities, it's necessaryto join 3 tables
select
    c.city,
    avg(o.total_order) as Average_order
from
    restaurants r
		left outer join
	orders o on o.restaurant_id = r.id --left outer join to get all records from table orders
		left outer join
	cities c on r.city_id = c.Id --left outer join to get all records from table restaurants
group by
    c.City
order by
    Average_order desc;

--find Members' Monthly Behavior By Gender, it's necessaryto join 3 tables

select 
	c.city,
	sum(case when mmt.sex = 'M' then mmt.total_expense else 0 end) as M_total_expenses, --sum total expenses when gender is male
	sum(case when mmt.sex = 'F' then mmt.total_expense else 0 end) as F_total_expenses  --sum total expenses when gender is female
from 
	members m
		left outer join
	cities c on m.city_id = c.Id ----left outer join to get all records from table members
		left outer join
	monthly_member_totals mmt on mmt.member_id = m.id ----left outer join to get all records from table monthly_member_totals
--WHERE 
	--mmt.sex IN ('M', 'F') i tried to it with this command but i got 1 column contains M and F 
group by  
    c.city;

--find Members' Monthly Behavior By Gender, it's necessaryto join 3 tables second methode

select 
	c.city,
	sum(case when mmt.sex = 'M' then mmt.total_expense else 0 end) as M_total_expenses, --sum total expenses when gender is male
	sum(case when mmt.sex = 'F' then mmt.total_expense else 0 end) as F_total_expenses  --sum total expenses when gender is female
--for the expression case end it performs a logical conditions just like if mmt.sex = M value if true sum total_expense value if false 0
--and the same for second condition 
from 
	members m
		left outer join
	cities c on m.city_id = c.Id ----left outer join to get all records from table members
		left outer join
	monthly_member_totals mmt on mmt.member_id = m.id ----left outer join to get all records from table monthly_member_totals
group by  
    c.city
union all
	select 
	'total' as city, /*'total' is to set a record in the first column (city) to ensure that 
the second select statement contains the same columns number*/
	sum(case when mmt.sex = 'M' then mmt.total_expense else 0 end) as M_total_expenses, --sum total expenses when gender is male
	sum(case when mmt.sex = 'F' then mmt.total_expense else 0 end) as F_total_expenses  --sum total expenses when gender is female
from
	members m
		left outer join
	monthly_member_totals mmt on mmt.member_id = m.id;

--find Most Favored Food through cities it's necessaryto join 4 tables

select 
	c.city,
	sum(case when rt.restaurant_type = 'Fast Food' then o.total_order else 0 end) as Fast_Food_total_order,
	sum(case when rt.restaurant_type = 'Asian' then o.total_order else 0 end) as Asian_total_order,
	sum(case when rt.restaurant_type = 'Indian' then o.total_order else 0 end) as Indian_total_order,
	sum(case when rt.restaurant_type = 'Homemade' then o.total_order else 0 end) as Homemade_total_order,
	sum(case when rt.restaurant_type = 'Italian' then o.total_order else 0 end) as Italian_total_order
from
	orders o
		left outer join
	restaurants r on o.restaurant_id = r.Id
		left outer join
	cities c on r.city_id = c.Id
		left outer join
	restaurant_type rt on r.restaurant_type_id = rt.id
group by
	c.City;



--find Serve Type By Gender it's necessaryto join 5 tables

select 
	mb.sex,
	sum(case when st.serve_type = 'Starter' then o.total_order else 0 end) as Starter_total_order,
	sum(case when st.serve_type = 'Main' then o.total_order else 0 end) as Main_total_order,
	sum(case when st.serve_type = 'Desert' then o.total_order else 0 end) as Desert_total_order
from
	serve_types st
		left outer join
	meals m on m.serve_type_id = st.id
		left outer join
	order_details od on od.meal_id = m.Id
		left outer join
	orders o on od.order_id = o.id
		left outer join
	members mb on o.member_id = mb.Id
group by
	mb.sex;

-- find Meals Range Difference
select
	(max(case when m.hot_cold = 'Hot' then m.price else 0 end) - min(case when m.hot_cold = 'Hot' then m.price else 0 end)) as range_Hot_price,
	(max(case when m.hot_cold = 'Cold' then m.price else 0 end) - min(case when m.hot_cold = 'Cold' then m.price else 0 end)) as range_cold_price
	
from
	meals m
group by
	m.hot_cold;


--find Vegan Meal Orders in each city it's necessaryto join 6  tables 
select 
	c.city,
	count(o.total_order) as count_orders,
	sum(o.total_order) as sum_orders
from 
	meal_types mt 
		left outer join
	meals m on m.meal_type_id = mt.Id --left outer join to get all records from table meals
		left outer join	
	order_details od on od.meal_id = m.Id --left outer join to get all records from table order_details
		left outer join
	orders o on od.order_id = o.id --left outer join to get all records from table order_details
		left outer join 
	restaurants r on o.restaurant_id = r.id --left outer join to get all records from table orders
		left outer join
	cities c on r.city_id = c.Id --left outer join to get all records from table restaurants
where 
	mt.meal_type = 'Vegan' --filter results to only vegan meals
group by
	c.City
order by 
	c.City asc;



--find MOST ITALIAN RESTURANTS ORDERS it's necessaryto join 4 tables

select 
	c.city,
	sum(o.total_order) as sum_Italian_order
from 
	orders o
		left outer join
	restaurants r on o.restaurant_id = r.id --left outer join to get all records from table orders
		left outer join
	restaurant_type rt on r.restaurant_type_id = rt.Id --left outer join to get all records from table restaurants
		left outer join 
	cities c on r.city_id = c.Id --left outer join to get all records from table restaurants
where 
	rt.restaurant_type = 'Italian'
group by
	c.City;
	
--find meal type sales in each city it's necessaryto join 6 tables

select
	mt.meal_type,
	sum(case when c.city ='Givatayim' then o.total_order else 0 end) as Givatayim, --summing total_order only when city = Givatayim
	sum(case when c.city ='Herzelia' then o.total_order else 0 end) as Herzelia, --summing total_order only when city = Herzelia
    sum(case when c.city ='Ramat Hasharon' then o.total_order else 0 end) as 'Ramat Hasharon', --summing total_order only when city = Ramat Hasharon
	sum(case when c.city ='Ramat Gan' then o.total_order else 0 end) as 'Ramat Gan',  --summing total_order only when city = Ramat Gan
	sum(case when c.city ='Tel Aviv' then o.total_order else 0 end) as 'Tel Aviv' --summing total_order only when city = Tel Aviv

from
	meal_types mt
		left outer join
	meals m on m.meal_type_id = mt.Id --left outer join to get all records from table meal_types
		left outer join 
	order_details od on od.meal_id = m.Id --left outer join to get all records from table order_details
		left outer join
	orders o on od.order_id = o.id --left outer join to get all records from table order_details
		left outer join
	restaurants r on o.restaurant_id = r.id --left outer join to get all records from table orders
		left outer join
	cities c on r.city_id = c.Id --left outer join to get all records from table restaurants
group by
	mt.meal_type;



-- find City Sales During Working Hours it's necessaryto jion 3 tables 
select 
	case 
		when o.hour > '18:00:00' then 'Night'
		when o.hour > '12:00:00' then 'Evening'
		else 'Morning'
		end as Time_Period,
	sum(case when c.city ='Givatayim' then o.total_order else 0 end) as Givatayim, --summing total_order only when city = Givatayim
	sum(case when c.city ='Herzelia' then o.total_order else 0 end) as Herzelia, --summing total_order only when city = Herzelia
    sum(case when c.city ='Ramat Hasharon' then o.total_order else 0 end) as [Ramat Hasharon], --summing total_order only when city = Ramat Hasharon
	sum(case when c.city ='Ramat Gan' then o.total_order else 0 end) as [Ramat Gan],  --summing total_order only when city = Ramat Gan
	sum(case when c.city ='Tel Aviv' then o.total_order else 0 end) as [Tel Aviv] --summing total_order only when city = Tel Aviv
from 
	orders o
		left outer join
	restaurants r on o.restaurant_id = r.id
		left outer join
	cities c on r.city_id = c.id
group by
	case 
        when o.hour > '18:00:00' then 'Night'
        when o.hour > '12:00:00' then 'Evening'
        else 'Morning'
    end;





