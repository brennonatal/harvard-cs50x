SELECT avg(r.rating)
FROM movies m
inner join ratings r
on m.id = r.movie_id
WHERE m.year == 2012