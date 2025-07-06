create database Vehicle;
use vehicle;
select * from electric_vehicle;
select count(*) from electric_vehicle;

-- 1. Write a query to list all electric vehicles with their VIN (1-10), Make, and Model. 

SELECT `VIN (1-10)`,MAKE,MODEL FROM ELECTRIC_VEHICLE;



-- 2. Write a query to display all columns for electric vehicles with a Model Year of 2020 or later.

SELECT * FROM ELECTRIC_VEHICLE 
WHERE `MODEL YEAR`>=2020 ORDER BY `MODEL YEAR`ASC;




-- 3. Write a query to list electric vehicles manufactured by Tesla.
SELECT * FROM ELECTRIC_VEHICLE 
WHERE MAKE="TESLA";




-- 4. Write a query to find all electric vehicles where the Model contains the word Leaf.
SELECT * FROM ELECTRIC_VEHICLE 
WHERE MODEL="Leaf";




-- 5. Write a query to count the total number of electric vehicles in the dataset.
SELECT COUNT(*) FROM ELECTRIC_VEHICLE;


-- 6. Write a query to find the average Electric Range of all electric vehicles.
select Make,avg(`electric range`) as avg_electric_range from ELECTRIC_VEHICLE
group by Make order by avg(`electric range`) desc;


-- 7. Write a query to list the top 5 electric vehicles with the highest Base MSRP, sorted in descending order.
with cte as (
    select Make,model,`Base MSRP`, 
	dense_rank() over (order by `Base MSRP` desc ) as ranks 
    from ELECTRIC_VEHICLE
    )
select distinct(Make),model,`Base MSRP`,ranks from cte 
where ranks<6 
order by ranks asc;



-- 8. Write a query to list all pairs of electric vehicles that have the same Make and Model Year.
-- Include columns for VIN_1, VIN_2, Make, and Model Year
SELECT 
    EV1.`VIN (1-10)` AS VIN_1,
    EV2.`VIN (1-10)` AS VIN_2,
    EV1.Make,
    EV1.`Model Year`
FROM 
    electric_vehicle EV1
JOIN 
    electric_vehicle EV2
    ON EV1.Make = EV2.Make
    AND EV1.`Model Year` = EV2.`Model Year`
    AND EV1.`VIN (1-10)` < EV2.`VIN (1-10)`;
    



    
 -- 9. Write a query to find the total number of electric vehicles for each Make. 
 -- Display Make and the count of vehicles.   
 
 select make,count(make) as count from electric_vehicle
 group by make order by count(make) desc;
 
 
-- 10. Write a query using a CASE statement to categorize electric vehicles into three categories based on their Electric Range:
-- Short Range for ranges less than 100 miles, Medium Range for ranges between 100 and 200 miles, 
-- and Long Range for ranges more than 200 miles.

select *,
case when `Electric Range`<100 then "Short Range"
     when `Electric Range`<200 then "Midium Range"
     Else "Long Range"
     end as Range_Category
     from electric_vehicle;


-- 11. Write a query to add a new column Model_Length to the electric 
-- vehicles table that calculates the length of each Model name.
select *,length(Model) as Model_Length
from electric_Vehicle;

-- 12. Write a query using an advanced function to find the electric vehicle
-- with the highest Electric Range.
with cte as(
select distinct `vin (1-10)`,make,model,`electric range`,`DOL vehicle ID`,
dense_rank()over(order by `electric range` desc) as ranking
from electric_vehicle)
select * from cte 
where ranking=1;


-- 13. Create a view named HighEndVehicles that includes electric vehicles with a 
-- Base MSRP of $50,000 or higher.
 create view HighEndVehicles as 
 select * from electric_vehicle
 where `Base MSRP`>=50000;
 
 select * from HighEndVehicles;
 
 
 
 -- 14. Write a query using a window function to rank electric vehicles
--  based on their Base MSRP within each Model Year.

with cte as (select distinct*, dense_rank() over(
partition by `model year` 
order by `Base MSRP` desc) as ranking
from electric_vehicle)
select * from cte;

-- 15. Write a query to calculate the cumulative count of electric
--  vehicles registered each year sorted by Model Year.

select `Model Year`,
count(*) as cumulative_count
from electric_vehicle
group by `model year`
order by `Model Year`;


-- 16. Write a stored procedure to update the Base MSRP of a 
-- vehicle given its VIN (1-10) and new Base MSRP.
delimiter //
create procedure updatebasemsrp (
    in input_vin varchar(10),
    in new_msrp decimal(10,2))
begin 
    update electric_vehicle
    set `base msrp` = new_msrp
    where vin = input_vin;
end //
delimiter ;





-- 17. Write a query to find the county with the highest average Base MSRP
--  for electric vehicles. Use subqueries and aggregate functions to achieve this.

alter table electric_vehicle
change County Country varchar(50);

select * from(select country,avg(`Base MSRP`) as avg_MSRP
 from electric_vehicle
 group by country 
order by avg_MSRP desc) as AVG_B_MSRP
 limit 1;

 -- 18. Write a query to find pairs of electric vehicles from the 
 -- same City where one vehicle has a longer Electric Range than the other.
 -- Display columns for VIN_1, Range_1, VIN_2, and Range_2.
 
 select 
     a.`VIN (1-10)` as VIN_1,
     a.`Electric Range` as Range_1,
     b.`VIN (1-10)` as VIN_2,
     b.`Electric Range` as Range_2
 from electric_vehicle a
 join electric_vehicle b 
     on a.city=b.city 
     and a.`Electric Range`> b.`Electric Range`
     and a.`VIN (1-10)`<>b.`VIN (1-10)`;

 
 
 
 
 
 
 
 
 
 
 































 

