create table blinkit
(
Item_Fat_Content varchar(20) ,
Item_Identifier varchar(20),
Item_Type varchar(50),
Outlet_Establishment_Year int,
Outlet_Identifier varchar(30),
Outlet_Location_Type varchar(10),
Outlet_Size varchar(15),
Outlet_Type	varchar(50),
Item_Visibility	float,
Item_Weight	float,
Sales float,
Rating float
);

select * from blinkit;

select count(*) from blinkit;

update blinkit 
set item_fat_content = 
case
when item_fat_content In ('LF' , 'low fat') then 'Low Fat'
when item_fat_content= 'reg' then 'Regular'
else item_fat_content
end;

select distinct(Item_fat_content) from blinkit;

--Cast : Convert one datatype into Another
select  cast(sum(sales) /1000000 AS DECIMAL(10,2))  as Total_Sales_Millions from blinkit;

select cast(avg(sales) As int) as Average_Sales from blinkit;

select cast(sum(sales) / 1000000 AS Decimal(10,2)) as Total_sales from blinkit
where
item_fat_content = 'Low Fat';

select cast(avg(rating) as Decimal(10,2)) As Average_Rating from blinkit;

select item_fat_content , 
		cast(sum(sales) as Decimal(10,2)) As Total_Sales ,
		cast(avg(sales) as Decimal(10,2)) Average_sales ,
		count(*) As Total_count,
		cast(avg(rating) as Decimal(10,2)) As Average_Rating
from blinkit
group by item_fat_content; 

select item_fat_content , 
		cast(sum(sales) as Decimal(10,2)) As Total_Sales ,
		cast(avg(sales) as Decimal(10,2)) Average_sales ,
		count(*) As Total_count,
		cast(avg(rating) as Decimal(10,2)) As Average_Rating
from blinkit
where outlet_establishment_year = 2022
group by item_fat_content; 

select item_type , cast(sum(sales) as decimal(10,2)) As Total_sales 
from blinkit
group by item_type
order by Total_Sales desc
limit 5;

select item_type , 
		cast(sum(sales) as Decimal(10,2)) As Total_Sales ,
		cast(avg(sales) as Decimal(10,2)) Average_sales ,
		count(*) As Total_count,
		cast(avg(rating) as Decimal(10,2)) As Average_Rating
from blinkit
group by item_type
order by Total_Sales DESC;

select outlet_location_type , item_fat_content , 
	cast(sum(sales) as decimal(10,2)) As Total_Sales ,
	cast(avg(sales) as decimal(10,2))As Average_Sales 
from blinkit
group by outlet_location_type , item_fat_content
order by Total_Sales ASC;

--PIVOT is used to convert rows into columns.
SELECT 
    outlet_location_type,
    ISNULL([Low Fat], 0)  AS Low_Fat,
    ISNULL([Regular], 0)  AS Regular
FROM
(
    SELECT 
        outlet_location_type,
        item_fat_content,
        CAST(SUM(sales) AS DECIMAL(10,2)) AS Total_Sales
    FROM blinkit
    GROUP BY 
        outlet_location_type,
        item_fat_content
) AS SourceTable
PIVOT
(
    SUM(Total_Sales)
    FOR item_fat_content IN ([Low Fat], [Regular])
) AS PivotTable
ORDER BY 
    outlet_location_type;

SELECT
    outlet_size,
    CAST(SUM(Sales) AS DECIMAL(10,2)) AS total_sales,
    CAST(
        SUM(Sales) * 100.0
        / SUM(SUM(Sales)) OVER ()
        AS DECIMAL(10,2)
    ) AS sales_percentage
FROM blinkit
GROUP BY outlet_size
ORDER BY total_sales DESC;


select outlet_location_type , cast(sum(sales) as decimal(10,2)) As Total_Sales
from blinkit
group by outlet_location_type
order by outlet_location_type;


