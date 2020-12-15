SELECT m.title, r.rating
FROM movies m
inner join ratings r
on m.id = r.movie_id
WHERE m.year == 2010
order by r.rating desc, m.title asc
