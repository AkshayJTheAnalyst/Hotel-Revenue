-- Union query to combine datasets
with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'] )

select * from hotels



-- Checking if revenue is growing each year... Note: adr(column) = daily rate 
-- # First creating a Revenue Column 

with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'] )

select (stays_in_week_nights+stays_in_weekend_nights)*adr as Revenue from hotels



-- Checking if revenue is growing each year...

with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'] )

select 
arrival_date_year,
sum((stays_in_week_nights+stays_in_weekend_nights)*adr) as Revenue 
from hotels
group by arrival_date_year


-- Checking if revenue is growing each year... Note: Was advised later that data is incomplete for 2020 

with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'] )

select 
arrival_date_year,
hotel,
round(sum((stays_in_week_nights+stays_in_weekend_nights)*adr),2) as Revenue 
from hotels
group by arrival_date_year,hotel
order by hotel desc, Revenue desc


-- Merging datsets for Power BI analysis now... 
-- Using left join for merging datsets Would use this query for Power BI

with hotels as (
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'] )

select * from hotels

left join dbo.market_segment$
on hotels.market_segment = market_segment$.market_segment

left join dbo.meal_cost$
on meal_cost$.meal = hotels.meal


