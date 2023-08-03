/*
                            National Retail Sales Data Analysis
                                 From Sree Yadlapalli


                                  Introduction
In this analysis,I am using national retail sales database using SQL.
The goal is to demonstrate my knowledge of databases, data loading, merging, and querying.
There will be some business questions asked by the CEO regarding sales performance.

The table schemas for the transaction files are provided in the `exercise files`  tab.
Files in data folder
location.csv
product.csv
trans_fact_1.csv
trans_fact_2.csv
trans_fact_3.csv
trans_fact_4.csv
trans_fact_5.csv
trans_fact_6.csv
trans_fact_7.csv
trans_fact_8.csv
trans_fact_9.csv
trans_fact_10.csv
*/


# Questions
########################################################################################################################
#                            Section 1 - Loading data
########################################################################################################################

# In this section you will:
# - Create a database called `loyalty`
# - Combine the transaction data into one table
/*
The commands below are used to learn about the current databases and create a new database called 'Loyalty'.
*/

show databases;
drop database if exists loyalty;
create database loyalty;
use loyalty;
select database();
show tables;

# 1. Create a table called location with the appropriate data types and load the data from location.csv
# Hint:
# - Take a look at the header of the CSV file to get column names
# - Take a look at the values in the CSV file to set appropriate data types
# - Don't include the header as a row
# - Remove any surrounding `doubxle quotes` from the data


drop table if exists loyalty.location; -- TO ensure there are no duplicates
create table loyalty.location -- To Create the Table
(
    store_location_key int,
    region             varchar(5),
    province           varchar(30),
    city               varchar(30),
    postal_code        varchar(10),
    banner             varchar(10),
    store_number       int
);
describe loyalty.location; -- To ensure datatypes are assigned properly
truncate loyalty.location; -- To delete the data inside the table

-- Load data from a CSV file into the table
load data local infile 'C:\\Users\\Sree\\Desktop\\MYSQLTutorialFolder\\quiz_data\\location.csv'
into table loyalty.location
fields terminated by ',' ENCLOSED BY '"'
lines terminated by '\n'
ignore 1 lines;


select * from location limit 5; -- To verify the data
select count(*) from location;  -- To verify the data

/* Output
1794,NA,ONTARIO,LONDON,NA,dc35b695,1794
42,NA,ONTARIO,TORONTO,NA,dc35b695,42
7218,NA,ALBERTA,SLAVE LAKE,NA,6e36648,7218
7196,NA,BRITISH COLUMBIA,VICTORIA,NA,6e36648,7196
7167,NA,BRITISH COLUMBIA,SURREY,NA,6e36648,7167
 */

# 2. Similar to the previous question, create a table called product with the appropriate data types and load the data from product.csv

drop table if exists loyalty.product; -- TO ensure there are no duplicates
create table loyalty.product  -- To create the table
(
    product_key         bigint,
    sku                 tinyint,
    upc                 bigint,
    item_name           bigint,
    item_description    varchar(20),
    department          varchar(20),
    category            varchar(20)
);
describe loyalty.product; -- To ensure datatypes are assigned properly
truncate loyalty.product; -- To delete the data inside the table

-- Load data from a CSV file into the table
load data local infile 'C:\\Users\\Sree\\Desktop\\MYSQLTutorialFolder\\quiz_data\\product.csv'
into table loyalty.product
fields terminated by '\,' ENCLOSED BY '"'
lines terminated by '\r\n'
ignore 1 lines;

-- Test product table
select * from product limit 5; -- To verify the data
select count(*) from product;   -- To verify the data
/*
        Output
7652613339,0,7652613339,324168,NA,651b1068,8312aed6
1810063322,0,1810063322,276973,NA,651b1068,7aaa7a34
5274585486,0,5274585486,794396,NA,c81ba571,54ea8364
6978362094,0,6978362094,510386,NA,b947a4a9,382cf3a
6978396053,0,6978396053,120105,NA,b947a4a9,382cf3a

 */

# 3: Create the transactions table
# After creating the 10 tables called txn1 to txn10, one for each file trans_fact_1.csv to trans_fact_10.csv.
# Load the data from the appropriate file to the appropriate table.
# After all 10 tables have been loaded, create and combine all 10 `txn` tables into one larger table called transactions.
# Hint:
# - If you prefer, you can just create one table and load all 10 CSV files into it

drop table if exists loyalty.txn1;  -- TO ensure there are no duplicates
create table loyalty.txn1       -- To create table
(
    store_location_key int,
    product_key        bigint,
    collector_key      bigint,
    trans_dt           date,
    sales              decimal(10,2),
    units              int,
    trans_key          decimal(30)
);

describe loyalty.txn1; -- Display the table details such as data types
truncate loyalty.txn1;  -- To empty the table

-- Load data from a CSV file into the table
load data local infile 'C:\\Users\\Sree\\Desktop\\MYSQLTutorialFolder\\quiz_data\\trans_fact_1.csv'
into table loyalty.txn1
fields terminated by ',' ENCLOSED BY '"'
lines terminated by '\n'
ignore 1 lines;

-- Test txn1 table
select * from txn1 limit 5;
/*
 9807,83215400105,-1,2015-09-09,42.72,1,198159807567120150909818
9807,6024538816,-1,2015-10-28,27.57,1,2171898075671201510281549
1396,999999999999513,139517343969,2015-06-18,62.44,1,60818613961182201506181635
9604,999999999999513,-1,2015-12-09,0.00,1,672879604118220151209919
9604,999999999999513,-1,2015-12-04,0.00,1,671159604118220151204726
 */
select count(*) from txn1; -- Count the table
/*
 20000
 */

drop table if exists loyalty.txn2;  -- TO ensure there are no duplicates
create table loyalty.txn2   -- To create table
(
    store_location_key int,
    product_key        bigint,
    collector_key      bigint,
    trans_dt           date,
    sales              decimal(10,2),
    units              int,
    trans_key          decimal(30)
);
-- Describe the txn2 table
-- Display the table details such as data types
describe loyalty.txn2;  -- Display the table details such as data types
truncate loyalty.txn2;  -- To empty the table

-- Load data from a CSV file into the table
load data local infile 'C:\\Users\\Sree\\Desktop\\MYSQLTutorialFolder\\quiz_data\\trans_fact_2.csv'
into table loyalty.txn2
fields terminated by ',' ENCLOSED BY '"'
lines terminated by '\n'
ignore 1 lines;

-- Test Product Table
select * from txn2 limit 3;
/*
 7296,85375900278,-1,2015-06-26,4.97,1,1254872965892201506261221
7296,81526001001,139537965459,2015-05-01,44.48,1,2499072965092201505011441
7296,77105840334,141333831857,2015-05-24,16.00,1,28995729621768201505241031
 */
select count(*) from txn2; -- Count the table
-- 20000

drop table if exists loyalty.txn3; -- To ensure there are no duplicates
create table loyalty.txn3           -- To create table

(
    store_location_key int,
    product_key        bigint,
    collector_key      bigint,
    trans_dt           date,
    sales              decimal(10,2),
    units              int,
    trans_key          decimal(30)
);
-- Describe the txn3 table
-- Display the table details such as data types
describe loyalty.txn3;
truncate loyalty.txn3;      -- To empty the table

-- Load data from a CSV file into the table
load data local infile 'C:\\Users\\Sree\\Desktop\\MYSQLTutorialFolder\\quiz_data\\trans_fact_3.csv'
into table loyalty.txn3
fields terminated by ',' ENCLOSED BY '"'
lines terminated by '\n'
ignore 1 lines;

-- Test Product Table
select * from txn3 limit 3;
/*
9807,83215400105,-1,2015-09-09,42.72,1,198159807567120150909818
9807,6024538816,-1,2015-10-28,27.57,1,2171898075671201510281549
1396,999999999999513,139517343969,2015-06-18,62.44,1,60818613961182201506181635
 */
select count(*) from txn3; -- Count the table
/*
 20000
 */
drop table if exists loyalty.txn4;   -- To ensure there are no duplicates
create table loyalty.txn4
(
    collector_key      bigint,
    trans_dt           char(10),
    store_location_key int,
    product_key        bigint,
    sales              decimal(10,2),
    units              int,
    trans_key          decimal(30)
);
-- Describe the txn4 table
-- Display the table details such as data types
describe loyalty.txn4;
truncate loyalty.txn4; -- To empty the table

-- Load data from a CSV file into the table
load data local infile 'C:\\Users\\Sree\\Desktop\\MYSQLTutorialFolder\\quiz_data\\trans_fact_4.csv'
into table loyalty.txn4
fields terminated by ',' ENCLOSED BY '"'
lines terminated by '\n'
ignore 1 lines;

-- Test txn4 table
select * from txn4 limit 5;
-- Since I used char as a datatype for the date,I have updated the date to time format using UPDATE command.
update txn4 set trans_dt = str_to_date(trans_dt,'%m/%d/%Y');

select * from txn4 limit 5; -- Test the data
/*
 -1,2015-06-26,8142,4319416816,9.42,1,16945500000000000000000000
-1,2015-10-25,8142,6210700491,24.90,1,34001800000000000000000000
-1,2015-09-18,8142,5873832611,12.09,1,17274800000000000000000000
-1,2015-09-14,8142,77105810243,20.45,1,4145280000000000000000000
-1,2015-04-18,8142,5610007708,10.31,1,26415800000000000000000000


 */
select count(*) from txn4; -- Count the table
/*
 20000
 */

drop table if exists loyalty.txn5; -- To ensure there are no duplicates
create table loyalty.txn5 -- To create the table
(
    collector_key      bigint,
    trans_dt           date,
    store_location_key int,
    product_key        bigint,
    sales              decimal(10,2),
    units              int,
    trans_key          decimal(30)
);
-- Describe the txn5 table
-- Display the table details such as data types
describe loyalty.txn5; -- To ensure datatypes are loaded properly
truncate loyalty.txn5; -- To empty the tables

-- Load data from a CSV file into the table
load data local infile 'C:\\Users\\Sree\\Desktop\\MYSQLTutorialFolder\\quiz_data\\trans_fact_5.csv'
into table loyalty.txn5
fields terminated by ',' ENCLOSED BY '"'
lines terminated by '\n'
ignore 1 lines;

-- Test Product Table
select * from txn5 limit 3;
/*
-1,2015-10-28,6973,999999999999513,0.00,1,31575569731182201510281142
-1,2015-07-24,6973,77105810883,8.53,1,31216969731182201507241448
141178981825,2015-12-14,6973,30041060552,11.55,1,31755569731182201512141140
 */
select count(*) from txn5; -- To count the data
/*
 20000
 */
drop table if exists loyalty.txn6; -- To ensure there are no duplicates
create table loyalty.txn6 -- To create the table
(
    collector_key      bigint,
    trans_dt           char(10),
    store_location_key int,
    product_key        bigint,
    sales              decimal(10,2),
    units              int,
    trans_key          decimal(30)
);
-- Describe the txn6 table
-- Display the table details such as data types
describe loyalty.txn6;
truncate loyalty.txn6; -- To empty the table

-- Load data from a CSV file into the table
load data local infile 'C:\\Users\\Sree\\Desktop\\MYSQLTutorialFolder\\quiz_data\\trans_fact_6.csv'
into table loyalty.txn6
fields terminated by ',' ENCLOSED BY '"'
lines terminated by '\n'
ignore 1 lines;

-- Since I used char as a datatype for the date,I have updated the date to time format using UPDATE command.
update txn6 set trans_dt = str_to_date(trans_dt,'%m/%d/%Y');
select * from txn6 limit 3;

/*
 -1,2015-10-28,6973,1000000000000000,0.00,0,31575600000000000000000000
-1,2015-07-24,6973,77105810883,8.53,0,31217000000000000000000000
141179000000,2015-12-14,6973,30041060552,11.55,0,31755600000000000000000000

 */

select count(*) from txn6; -- To count the data
/*
 20000
 */

drop table if exists loyalty.txn7; -- To ensure there are no duplicates
create table loyalty.txn7 -- To create the table
(
    collector_key      bigint,
    trans_dt           date,
    store_location_key int,
    product_key        bigint,
    sales              decimal(10,2),
    units              int,
    trans_key          decimal(30)
);
-- Describe the txn7 table
-- Display the table details such as data types
describe loyalty.txn7;
truncate loyalty.txn7; -- To Empty the table

-- Load data from a CSV file into the table
load data local infile 'C:\\Users\\Sree\\Desktop\\MYSQLTutorialFolder\\quiz_data\\trans_fact_7.csv'
into table loyalty.txn7
fields terminated by ',' ENCLOSED BY '"'
lines terminated by '\n'
ignore 1 lines;

-- Describe data in txn7
select * from txn7 limit 3;
/*
-1,2015-09-09,9807,83215400105,42.72,1,198159807567120150909818
-1,2015-10-28,9807,6024538816,27.57,1,2171898075671201510281549
139517343969,2015-06-18,1396,999999999999513,62.44,1,60818613961182201506181635

 */
select count(*) from txn7; -- To count the data
/*
 20000
 */

drop table if exists loyalty.txn8; -- To ensure there are no duplicates
create table loyalty.txn8 -- To create the table
(
    product_key        bigint,
    collector_key      bigint,
    trans_dt           char(10),
    store_location_key int,
    sales              decimal(10,2),
    units              int,
    trans_key          decimal(30)
);
-- Describe the txn8 table
-- Display the table details such as data types
describe loyalty.txn8;
truncate loyalty.txn8; -- To empty the table

-- Load data from a CSV file into the table
load data local infile 'C:\\Users\\Sree\\Desktop\\MYSQLTutorialFolder\\quiz_data\\trans_fact_8.csv'
into table loyalty.txn8
fields terminated by ',' ENCLOSED BY '"'
lines terminated by '\n'
ignore 1 lines;


-- Since I used char as a datatype for the date,I have updated the date to time format using UPDATE command.
update txn8 set trans_dt = str_to_date(trans_dt,'%m/%d/%Y');

-- Describe data in txn8
select * from txn8 limit 3;
/*
1000000000000000,-1,2015-10-28,6973,0.00,1,31575600000000000000000000
77105810883,-1,2015-07-24,6973,0.00,1,31217000000000000000000000
30041060552,141179000000,2015-12-14,6973,0.00,1,31755600000000000000000000

 */
select count(*) from txn8; -- To count the data
/*
 20000
 */


drop table if exists loyalty.txn9; -- To ensure there are no duplicates
create table loyalty.txn9  -- To create the table
(
    product_key        bigint,
    collector_key      bigint,
    trans_dt           date,
    store_location_key int,
    sales              decimal(10,2),
    units              int,
    trans_key          decimal(30)
);
-- Describe the txn9 table
-- Display the table details such as data types
describe loyalty.txn9;
truncate loyalty.txn9; -- To empty the table

-- Load data from a CSV file into the table
load data local infile 'C:\\Users\\Sree\\Desktop\\MYSQLTutorialFolder\\quiz_data\\trans_fact_9.csv'
into table loyalty.txn9
fields terminated by ',' ENCLOSED BY '"'
lines terminated by '\n'
ignore 1 lines;

-- Describe data in txn9
select * from txn9 limit 3;
/*
4319416816,-1,2015-06-26,8142,9.42,1,16945481425160201506261558
6210700491,-1,2015-10-25,8142,24.90,1,34001814221225201510251132
5873832611,-1,2015-09-18,8142,12.09,1,17274781425160201509181416

 */
select count(*) from txn9;  -- To count the table
/*
 20000
 */

drop table if exists loyalty.txn10;  -- To ensure there are no duplicates
create table loyalty.txn10 -- To create the table
(
    product_key        bigint,
    collector_key      bigint,
    trans_dt           date,
    store_location_key int,
    sales              decimal(10,2),
    units              int,
    trans_key          decimal(30)
);
-- Describe the txn10 table
-- Display the table details such as data types
describe loyalty.txn10;
truncate loyalty.txn10; -- To empty the table

-- Load data from a CSV file into the table
load data local infile 'C:\\Users\\Sree\\Desktop\\MYSQLTutorialFolder\\quiz_data\\trans_fact_10.csv'
into table loyalty.txn10
fields terminated by ',' ENCLOSED BY '"'
lines terminated by '\n'
ignore 1 lines;

-- Describe data in tf10
select * from txn10 limit 5;
/*
4319416816,-1,2015-06-26,8142,9.42,1,16945481425160201506261558
6210700491,-1,2015-10-25,8142,24.90,1,34001814221225201510251132
5873832611,-1,2015-09-18,8142,12.09,1,17274781425160201509181416

 */
select count(*) from txn10; -- To count the data
/*
 20000
 */

/* ------------------------------------Creating table Transactions from all the tables-------------------------------*/

create table transactions
select store_location_key,product_key,collector_key,trans_dt,sales,units,trans_key
from txn1
union
select store_location_key,product_key,collector_key,trans_dt,sales,units,trans_key
from txn2
union
select store_location_key,product_key,collector_key,trans_dt,sales,units,trans_key
from txn3
union
select store_location_key,product_key,collector_key,trans_dt,sales,units,trans_key
from txn4
union
select store_location_key,product_key,collector_key,trans_dt,sales,units,trans_key
from txn5
union
select store_location_key,product_key,collector_key,trans_dt,sales,units,trans_key
from txn6
union
select store_location_key,product_key,collector_key,trans_dt,sales,units,trans_key
from txn7
union
select store_location_key,product_key,collector_key,trans_dt,sales,units,trans_key
from txn8
union
select store_location_key,product_key,collector_key,trans_dt,sales,units,trans_key
from txn9
union
select store_location_key,product_key,collector_key,trans_dt,sales,units,trans_key
from txn10;

select * from transactions limit 5; -- To check the table
/*
 9807,83215400105,-1,2015-09-09,42.72,1,198159807567120150909818
9807,6024538816,-1,2015-10-28,27.57,1,2171898075671201510281549
1396,999999999999513,139517343969,2015-06-18,62.44,1,60818613961182201506181635
9604,999999999999513,-1,2015-12-09,0.00,1,672879604118220151209919
9604,999999999999513,-1,2015-12-04,0.00,1,671159604118220151204726

 */
select count(*) from transactions; -- To count the table

/*
84031
 */




########################################################################################################################
#                            Section 2 - General SQL Queries
########################################################################################################################

# 1. How many sales are exactly 0?
select count(sales)
from transactions
where sales=0;
/*
17747
 */

# 2. How many transactions have negative sales and negative units?
select count(*) "Transactions with Negative Sales and Negative Units"
from transactions
where sales<0 and units<0;
/*
 347
 */
# 3. How many years does the transaction table span (start and end year)?
select concat ('The transaction table span from',' ',min(year(trans_dt)),' ','and',' ',max(year(trans_dt)),'.') ans
from transactions;   -- Concat command is used to display result as a string
/*
The transaction table span from 2015 and 2016.
 */

# 4. Create a table to show the total sales year-over-year growth

-- Note : The units column is ignored assuming that the sales already account for number of units sold

select year(trans_dt),sum(sales) "Sum of Sales from Current Year",
        lag(sum(sales)) over (order by year(trans_dt)) as "Sales From Previous Year",
        -- Calculating the year over year growth/Decline
        -- (sales - previous_sales)/previous_revenue * 100 as yr_over_yr
        -- Please note that the final output is displayed as a percentage
        ((sum(sales)-lag(sum(sales)) over (order by year(trans_dt)))/lag(sum(sales)) over (order by year(trans_dt)))*100 as "YEAR OVER YEAR GROWTH/DECLINE PERCENTAGE"
from transactions
group by 1;
/*
2015,1531348.36,,
2016,159276.67,1531348.36,-89.598926

 */



# 5. Create a table to show the total sales for each month of each year
SELECT * FROM transactions;
select YEAR(trans_dt) Transactionyear, -- To Group Years
       monthname(trans_dt) month, -- To Group Months and Display Month Name
       sum(sales) "Total Sales Per Month of Each Year" -- To sum sales per month
from transactions
group by 1,2
order by
    1,
    CASE WHEN month = 'January' then 1
        WHEN month ='February' then 2
        WHEN month ='March' then 3
        WHEN month ='April' then 4
        WHEN month = 'May' then 5
        WHEN month = 'June' then 6
        WHEN month = 'July' then 7
        WHEN month = 'August' then 8
        WHEN month = 'September' then 9
        WHEN month = 'October' then 10
        WHEN month = 'November' then 11
        WHEN month = 'December' then 12
    else null end;

/*
 2015,March,7215.24
2015,April,245145.24
2015,May,153227.30
2015,June,167331.69
2015,July,140963.12
2015,August,170344.32
2015,September,152907.68
2015,October,166976.90
2015,November,160353.01
2015,December,166883.86
2016,January,100656.91
2016,February,7062.93
2016,March,10450.95
2016,April,6955.41
2016,May,7700.80
2016,June,4864.47
2016,July,4827.61
2016,August,5366.84
2016,September,6572.28
2016,October,4818.47

 */

# 6. Create a **pivot table** to show the total sales for each month of each year?
select month(trans_dt), -- To display Month
       sum(case when year(trans_dt) = 2015 then sales else 0 end) as "Sale1", -- Condition to show sales for 2015
       sum(case when year(trans_dt) = 2016 then sales else 0 end) as "Sale2"   -- Condition to show sales for 2016
from transactions
group by 1
order by 1;

/*
1,0.00,100656.91
2,0.00,7062.93
3,7215.24,10450.95
4,245145.24,6955.41
5,153227.30,7700.80
6,167331.69,4864.47
7,140963.12,4827.61
8,170344.32,5366.84
9,152907.68,6572.28
10,166976.90,4818.47
11,160353.01,0.00
12,166883.86,0.00

 */

# 7. Which month of which year had the largest total sales?
select concat( m,' ','of', ' ',y,' ','had the largest sales','.') Result
    from
        (select
             year(trans_dt) y, -- To group by Year
            monthname(trans_dt) m, -- To group by month and display month name
            sum(sales) -- To find the total sales for a particular month
        from
            transactions
        group by 1,2
        order by 3 desc limit 1) as cq;
/*
April of 2015 had the largest sales.
 */

# 8. Create a table to show total sales for each province

select province,  -- To group by province
       sum(sales) "Total Sales"
from location left join transactions -- Using Inner Join to combine both tables to get sales for each province
    on location.store_location_key = transactions.store_location_key
group by 1;

/*
ALBERTA,484575.38
BRITISH COLUMBIA,168061.45
MANITOBA,50527.03
ONTARIO,935780.56
PRINCE EDWARD ISLAND,
SASKATCHEWAN,51680.61
NOVA SCOTIA,
NEW BRUNSWICK,
NEWFOUNDLAND,
QUEBEC,
NORTHWEST TERRITORY,

 */

# 9. Create a table to show total sales for each product key

-- Note : Units Column is Ignored assuming the sales column already accounts for number of units sold

-- Considering only Transaction table since all the transactions are already tabulated.
select product_key,sum(sales) Total_Sales
from transactions
group by 1
order by 2 desc;

/*
999999999999513,540773.37
1000000000000000,381643.96
999999999999200,19838.99
41410000216,7783.94
83215400105,4699.20
41410000215,4091.33
6349108729,3404.25
 */


# 10. Create a table to show the average sales for customers in the loyalty program vs customers that are not.
# Hints: Collector key = -1 (nonloyal) - Collector Key > -1 (loyal)

-- Using case when to segregate loyal and non loyal
select avg(case when collector_key = -1 then sales end) as "Avg Sales of Non-Loyalty Customers",
       avg(case when collector_key > -1 then sales end) as "Avg Sales of Loyalty Customers"
from transactions;

/*
20.735224,18.104968

 */



# 11. Calculate the year-over-year growth in sales for each province

select province, -- Province
       (revenue-Previous_Year_Revenue) as yr_over_yr_Growth_Decline, -- To display year over year growth or decline
      concat((revenue-Previous_Year_Revenue)/Previous_Year_Revenue * 100,'%') as yr_over_yr_percentage -- To display year over year growth or decline in percentage
   from (
    select *,
             lag(revenue) over (partition by province order by yr) as Previous_Year_Revenue
      from (select province, yr, sum(amount) revenue
            from location
                     join (select store_location_key, year(trans_dt) yr, sum(sales) amount -- To extract data from transactions and location tables
                           from transactions
                           group by 1, 2) as subq on location.store_location_key = subq.store_location_key

            group by 1, 2
            order by 1) as subq2
    ) as subq3;

/*
ALBERTA,,
ALBERTA,-453470.24,-96.684048%
BRITISH COLUMBIA,,
BRITISH COLUMBIA,-17307.59,-18.673658%
MANITOBA,,
MANITOBA,-48372.55,-97.821548%
ONTARIO,,
ONTARIO,-806649.04,-92.588996%
SASKATCHEWAN,,
SASKATCHEWAN,-46272.27,-94.478631%

 */

# 12. Calculate the month-over-month growth in sales for each province
select *,
       (revenue-Previous_Month_Revenue) as Mth_over_Mth_Growth_Decline, -- To display month over month growth or decline
        -- -- To display month over month growth or decline in percentage
      concat((revenue-Previous_Month_Revenue)/Previous_Month_Revenue * 100,'%') as Mth_over_Mth_Percentage
from (select *,
             lag(revenue) over (partition by province,yr order by mth) as Previous_Month_Revenue
      from (select province, yr, mth, sum(amount) revenue
            from location
                     inner join  -- Using Inner Join to connect Location and Transactions
                 (select store_location_key, year(trans_dt) yr, month(trans_dt) mth, sum(sales) amount
                  from transactions
                  group by 1, 2, 3) as sq1 on location.store_location_key = sq1.store_location_key
            group by province, yr, mth
            order by 1, 2, 3) as sq2
) as sq3;

/*
ALBERTA,2015,3,1917.14,,,
ALBERTA,2015,4,104820.57,1917.14,102903.43,5367.549057%
ALBERTA,2015,5,37549.33,104820.57,-67271.24,-64.177518%
ALBERTA,2015,6,60348.35,37549.33,22799.02,60.717515%
ALBERTA,2015,7,31407.83,60348.35,-28940.52,-47.955777%
ALBERTA,2015,8,68728.00,31407.83,37320.17,118.824414%
ALBERTA,2015,9,37136.17,68728.00,-31591.83,-45.966462%
ALBERTA,2015,10,35518.87,37136.17,-1617.30,-4.355053%
ALBERTA,2015,11,53352.43,35518.87,17833.56,50.208692%
 */


########################################################################################################################
#                            Section 3 - Business Questions
########################################################################################################################

# 1. The president of the company wants to understand which provinces and stores are performing well (above the average
# of each province), and how much are the top store in each province performing compared with the province average.
# How many stores are performing above average in each province and how many are performing below average?
# (find the average store sales of each province, sales of each store, and the difference)

-- SOLUTION:

-- Analysing Data
select * from transactions;
select * from location;
select * from product;

/*
Understanding:  1.The President want to know which (Provinces) and (Stores in each Provinces) are doing well
                2.Top Store Performance of each store compared to Provincial Average
                3.Number of Stores Performing above average and below average in each province
Approach :  In order to accomplish, The question into two parts

First Part: Using Inner Join, I made a relation between location and transactions table.
            Following that,I used Window Function to compute each Province's Average.
            Then Using case when,I compared each store with its respective province.
            The rating is named as store rating.Along with that,I computed average provincial sale
            and compared each province total.It is named as Province Rating.

Second Part : For the second part,I  I used Count Function to compute the number of stores
            above average and below average.
*/

-- First Part

select Province,Sales_Performance_Province,
       -- Using Case Function to determine if the province is above or below average
       case
           when Sales_Performance_Province >0
            then 'Above Average'
            else 'Below Average'
            end as ProvinceRating,
            store_number,Store_Performance,StoreRating
from
    (select *,
            -- Total Sale of Each Province - Avg Sale of All Provinces
             TotalProvinceSale - Avg_ProvinceSale as Sales_Performance_Province,
             -- Using Case Function to determine if the store is above or below average
             case
                 when Store_Performance > 0
                     then 'Above Average'
                 else 'Below Average'
                 end                              as StoreRating
      from (select *,
                   -- To compute total sale of each store - Total sale of each province
                   (Total_Sales - Province_Avg)  as Store_Performance,
                   -- To compute average sale of whole data
                   Avg(TotalProvinceSale) over () as Avg_Provincesale
            from (select *,
                         -- Average Sales for each province
                         avg(Total_Sales) over (partition by province) Province_Avg,
                         -- Total Sales for each Province
                         sum(Total_Sales) over (partition by province) TotalProvinceSale
                  from (select province, store_number, sum(sales) Total_Sales
                        from location
                                 join transactions using (store_location_key)
                        group by 1, 2
                        order by 1, 2) as subq) as subq2) as subq3
    ) as subq4
order by 3,6;


/*
ONTARIO,335745.583830,Above Average,6973,261115.960000,Above Average
ONTARIO,335745.583830,Above Average,1891,28903.520000,Above Average
ONTARIO,335745.583830,Above Average,8142,286808.970000,Above Average
ONTARIO,335745.583830,Above Average,1396,56819.160000,Above Average
ONTARIO,335745.583830,Above Average,6979,7491.250000,Above Average
ONTARIO,335745.583830,Above Average,1685,-41853.750000,Below Average
ONTARIO,335745.583830,Above Average,8207,-40396.040000,Below Average
ONTARIO,335745.583830,Above Average,1842,-38483.250000,Below Average
ONTARIO,335745.583830,Above Average,2063,-38575.080000,Below Average
ONTARIO,335745.583830,Above Average,2428,-28067.870000,Below Average
ONTARIO,335745.583830,Above Average,6905,-22837.700000,Below Average
ONTARIO,335745.583830,Above Average,6907,-41404.110000,Below Average
ONTARIO,335745.583830,Above Average,6941,-41910.070000,Below Average
ONTARIO,335745.583830,Above Average,6946,-30052.020000,Below Average
ONTARIO,335745.583830,Above Average,6948,-41727.860000,Below Average

 */

-- Second Part

select province,StoreRating,count(StoreRating) -- Using Count Function to determine the Above Avg. and Below Avg. Stores
from (
select Province,Sales_Performance_Province,
       case
           when Sales_Performance_Province >0
            then 'Above Average'
            else 'Below Average'
            end as ProvinceRating,
            store_number,Store_Performance,StoreRating
from
    (select *,
             TotalProvinceSale - Avg_ProvinceSale as Sales_Performance_Province,
             case
                 when Store_Performance > 0
                     then 'Above Average'
                 else 'Below Average'
                 end                              as StoreRating
      from (select *,
                   (Total_Sales - Province_Avg)      Store_Performance,
                   Avg(TotalProvinceSale) over () as Avg_Provincesale
            from (select *,
                         avg(Total_Sales) over (partition by province) Province_Avg,
                         sum(Total_Sales) over (partition by province) TotalProvinceSale
                  from (select province, store_number, sum(sales) Total_Sales
                        from location
                                 join transactions using (store_location_key)
                        group by 1, 2
                        order by 1, 2) as subq) as subq2) as subq3
    ) as subq4
order by 3,6
    ) as subq5
group by province,StoreRating;

/*
 ALBERTA,Below Average,10
ALBERTA,Above Average,3
BRITISH COLUMBIA,Below Average,4
BRITISH COLUMBIA,Above Average,2
MANITOBA,Above Average,1
MANITOBA,Below Average,2
ONTARIO,Above Average,5
ONTARIO,Below Average,17
SASKATCHEWAN,Below Average,2
SASKATCHEWAN,Above Average,1

 */


# 2. The president further wants to know how customers in the loyalty program are performing compared to non-loyalty
# customers and what category of products is contributing to most of the sales from each group.

-- SOLUTION :

/*
Understanding:  1. How customers in loyalty program are doing with respect to non-loyalty customers and which category
                    of products is contributing to most sales from each group

Approach :  Firstly,I'll segragate customers into loyal and non loyal along with the sales.
            Later I'll further divide sales with respect to each category.

First Part: Using Inner Join,I'll combine customers(loyal and Non loyal) with sales and category.
            Then I'll use group by to calculate sales by category over loyalty and category.
            there by we will get sales by category from loyal and non loyal customers.
            Lastly,I'll apply windows fucntions to compute total sales from loyal and non loyal customers and apply ranking.
            For comparision,I used filter to return top 3 categories contributing to sales  for loyal and non loyal customers.
Note : The units are ignored as it is assumed that they are already factored into sales.
*/

-- First Part

select *
from (select *,
             -- Ranking to determine top categories
             rank() over (partition by loyalty order by salesbycategory desc) as ranking
      from (select *,
                   -- Window Function to determine sales from loyal & non loyal
                   sum(salesbycategory) over (partition by loyalty) as salesbyloyalty
            from (select loyalty, category, sum(sales) as salesbycategory
                  from (select case
                                   when collector_key = -1 then 'Non-Loyal'
                                   when collector_key > -1 then 'loyal'
                                   end as loyalty,
                               category,
                               sales
                        from product
                                 inner join
                             transactions using (product_key)
                        order by 1, 2) as a
                  group by 1, 2
                  order by 1, 3 desc) as b) as c
) as d
where ranking<4;

/* Conclusion : Non-Loyal customers outperform loyal customers as they bring more sales.
    Regarding categories, We have included top three for loyal and non loyal.It can be observed that "ffcec4a7" and "fe148072"
    are two common categories for both loyal and non loyal customers.
 */
/*
/*
loyal,ffcec4a7,10610.35,141407.40,1
loyal,fe148072,9123.76,141407.40,2
loyal,65d731c8,6551.42,141407.40,3
Non-Loyal,fe148072,16677.00,250556.97,1
Non-Loyal,ffcec4a7,12400.62,250556.97,2
Non-Loyal,cef3760b,12370.95,250556.97,3

 */

# 3. Determine the top 5 stores by province and top 10 product categories by the department from these top-performing stores.

-- SOLUTION :


/*
Understanding:  1. Top 5 Stores by Province
                2. Top 10 product categories from these top performing stores(which means above 5 stores)

Approach :  I'll approach the question in two parts

First Part: Join Province,Store Key/Store Number and Sales.Then group sales by province and Store Key.
            Apply Widows ranking to determine the top 5 stores in each province.

Second Part: I'll again consider store key,department,category using inner join from the tables.
            I'll use the where filter with store key with the result from first part.
                Then I'll sum the sales grouping by category and department.
            Later I'll apply ranking window and filter to return the top 10 categories in each department.

Note : The units are ignored as it is assumed that they are already factored into sales.
*/


select * from transactions;
select * from location;
select * from product;

-- First Part :

select *
from (select *,
             rank() over (partition by province order by Total_Sales desc) Store_Ranking
      from (select province,
                   t.store_location_key,
                   sum(sales) as Total_Sales
            from location l
                     inner join transactions t on l.store_location_key = t.store_location_key
            group by 1, 2
            order by 1, 3 desc) as subq1
    ) as subq2
where Store_Ranking<=5;

/*
ALBERTA,9807,217507.09,1
ALBERTA,7296,179697.70,2
ALBERTA,9802,54094.98,3
ALBERTA,7247,10261.62,4
ALBERTA,7226,9986.44,5
BRITISH COLUMBIA,7167,71271.98,1
BRITISH COLUMBIA,7104,61893.84,2
BRITISH COLUMBIA,7175,14096.53,3
BRITISH COLUMBIA,7125,10962.98,4
BRITISH COLUMBIA,7194,8975.25,5
MANITOBA,4823,50248.00,1
MANITOBA,4861,257.69,2
MANITOBA,7403,21.34,3
ONTARIO,8142,329344.45,1
ONTARIO,6973,303651.44,2
ONTARIO,1396,99354.64,3
ONTARIO,1891,71439.00,4
ONTARIO,6979,50026.73,5
SASKATCHEWAN,7317,43409.15,1
SASKATCHEWAN,7309,4487.25,2
SASKATCHEWAN,7313,3784.21,3
 */

-- Second Part

select *
from (select *,
             -- Rank Window Function to filter top 10 categories
             rank() over (partition by department order by Each_Category_Total desc) Category_Ranking
      from (select department,
                category,
                sum(total_sales) Each_Category_Total -- Sum of Sales wrt.each category
            -- To join sales data store location key,department and category
            from (select l.store_location_key, department, category, sum(sales) Total_Sales
                  from product p
                           inner join
                       transactions t on p.product_key = t.product_key
                           inner join
                       location l on t.store_location_key = l.store_location_key
                  -- Where filter to collect store location keys from top 5 provinces
                  where l.store_location_key in
                        (select store_location_key
                         from (select *,
                                      rank() over (partition by province order by Total_Sales desc) Store_Ranking
                               from (select province,
                                            t.store_location_key,
                                            sum(sales) as Total_Sales
                                     from location l
                                              inner join transactions t on l.store_location_key = t.store_location_key
                                     group by 1, 2
                                     order by 1, 3 desc) as subq1) as subq2
                         where Store_Ranking <= 5)
                  group by 1, 2, 3
                  order by 1) as subq3

            group by 1, 2) as subq4
) as subq5
where Category_Ranking<=10;

/*
144711b0,5d6df0e5,23.85,1
1a34cbb9,fe148072,24198.85,1
1a34cbb9,ffcec4a7,20789.10,2
1a34cbb9,e49d14f1,16319.77,3
1a34cbb9,11566ced,11211.16,4
1a34cbb9,e934fcda,10720.98,5
1a34cbb9,7703921f,8891.42,6
1a34cbb9,a97ccc2c,7857.92,7
1a34cbb9,d18e3df7,7090.95,8
1a34cbb9,fbe05f0d,6300.69,9
1a34cbb9,a8a688f9,5426.69,10
2aa3a6c1,32bf7d96,6247.80,1
34a2a7e0,1578f747,0.00,1
3ad17de9,c280daf5,2123.95,1
3ad17de9,caddeda1,562.40,2

 */






