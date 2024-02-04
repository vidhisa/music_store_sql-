 Q1: Who is the senior most employee based on job title?

SELECT * FROM EMPLOYEE
ORDER BY LEVELS DESC 
LIMIT 1
Q2: WHICH COUNTRIES HAVE MOST INVOICES?

SELECT COUNT(*) AS C ,billing_country
FROM INVOICE
group by billing_country
order by c desc

Q3: WHAT ARE TOP 3 VALUES OF TOTAL INVOICES?

SELECT TOTAL FROM INVOICE
ORDER BY TOTAL DESC
LIMIT 3

Q4: WHICH CITY HAS THE BEST CUSTOMERS? WE WOULD LIKE TO THROW A PROMOTIONAL MUSIC FESTIVAL IN THE CITY WE MADE THE MOST MONEY. WRITE A QUERY THAT RETURNS ONE CITY 
THAT HAS THE HIGHEST SUM OF INVOICE TOTALS. RETURN BOTH THE CITY NAME AND SUM OF ALL INVOICE TOTALS.

SELECT SUM(TOTAL)  AS INVOICE_TOTAL, billing_city FROM INVOICE
GROUP BY billing_city 
order by invoice_total desc

Q5. who is the best customer? the customer who has spent the most money will be declared the best customer. WRITE  a query that returns the person who has spent the most money.

select customer.customer_id, customer.first_name,customer.last_name,sum(invoice.total) as total from customer join invoice on customer.customer_id = invoice.customer_id 
group by customer.customer_id
order by total desc
limit 1

question set 2 - moderate

q1. write query to return the email,first name ,last name, & genre of all rock music listeners. 
return your list ordered alphabetically by email starting with a.

select distinct email,first_name,last_name
from customer
join invoice on customer.customer_id = invoice.customer_id 
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in(
  select track_id from track
   join genre on track.genre_id = genre.genre_id
    where genre.name like  'Rock'
)
order by email;


q2: lets invite the artists who have written the most rock music in our dataset. WRITE A QUERY THAT RETURNS THE ARTIST NAME AND TOTAL TRACK COUNT OF THE TOP 10 ROCK BANDS.

select artist.artist_id, artist.name ,count (artist.artist_id )
as number_of_songs
from track
join album on album.album_id = track.album_id
join artist on artist.artist_id = album.artist_id
join genre on genre.genre_id = track.genre_id
where genre.name like 'Rock'
group by artist.artist_id
order by number_of_songs desc
limit 10;

q3: return all the track names that have a song length longer than the average song length.
return the name and milliseconds for each track. order by the song length with the longest songs listed first. 


select name, milliseconds
from track 
where milliseconds >(
   select avg (milliseconds) as avg_track_length
   from track)
order by milliseconds desc;




