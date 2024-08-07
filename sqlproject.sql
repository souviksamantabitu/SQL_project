create database painting;
use painting;
show tables;
-- Joining Tables:
-- 1. Retrieve the full name of artists along with the names
-- of the museums where their works are displayed.

select full_name,name
from artist
cross join museum;
-- 2. Group By and Count:
-- How many works does each artist have in the database?
-- Display the artist's full name along with the count of their works
select artist.artist_id,artist.full_name,count(work.work_id) as num_work
from artist
left join work on artist.artist_id=work.artist_id
group by artist.artist_id,artist.full_name;
-- 3. Order By and Limit:
-- List the top 5 museums with the highest number of works displayed in the database, 
-- along with their respective counts.
select museum.name,museum.museum_id, count(work.work_id) as workcount
from museum
left join work on museum.museum_id=work.museum_id
group by  museum.name,museum.museum_id
order by workcount desc
limit 5;
-- 4. Join, Order By, and Limit:
-- Display the names and styles of the works along with the corresponding museum names,
-- ordered by the museum name in ascending order. Limit the results to 10.
select museum.name as mname, work.name as wname ,work.style from museum
left join work on museum.museum_id=work.museum_id
order by museum.name asc
limit 10;

-- 5.Join, Group By, and Sum:
-- Show the total sale price for each artist's works. 
--  Display the artist's full name along with the total sale price, 
-- ordered by the total sale price in descending order.
select artist.full_name, sum(sale_price)  as totalsale from artist
join work on artist.artist_id=work.artist_id
join product_size on work.work_id=product_size.work_id
group by artist.full_name
order by totalsale;
-- 6. Join, Group By, and Having:
-- List artists who have more than 3 works in the database, 
-- along with the count of their works.
select artist.full_name,count(work.work_id) as count_work from artist
left join work on artist.artist_id=work.artist_id
group by artist.full_name
having count_work>3;

-- 7. Join, Where, and Order By:
-- Retrieve the names of works and their corresponding artists' full names 
-- for works that have a sale price smaller than their regular price. 
select work.work_id,work.name,artist.full_name as artistfullname,product_size.regular_price,
product_size.sale_price from work
join artist on work.artist_id=artist.artist_id
join product_size on work.work_id=product_size.work_id
where sale_price < regular_price
order by work.name;

-- 8. Join, Group By, and Average:
-- Calculate the average height and width of the artworks in the database. 
-- Display the average height and width.
select work.name,AVG(height) as avg_height,
avg(width) as avg_width from canvas_size
join product_size on canvas_size.size_id=product_size.size_id
join work on product_size.work_id=work.work_id
group by work.name;
-- Join, Group By, and Max:
-- 9 Find the maximum sale price among all the works in each museum.
-- Display the museum name along with the maximum sale price.
select museum.name,max(sale_price) as max_saleprice from product_size
join work on product_size.work_id=work.work_id
join museum on work.museum_id=museum.museum_id
group by museum.name;
-- Join, Group By, and Concatenate:
-- 10. Concatenate the first name and last name of artists along with their nationality,
-- separated by a comma. Display the concatenated string along with the count of works
-- by each artist, ordered by the count in descending order.
select concat(first_name,' ',last_name,',',museum.country) as fullname, 
count(work.work_id) as countwork from artist
join work on artist.artist_id=work.artist_id
join museum on work.museum_id=museum.museum_id
group by fullname
order by countwork desc;





