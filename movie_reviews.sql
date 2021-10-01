SELECT reviews.* 
  FROM movies JOIN reviews ON movies.id=reviews.movie_id
  WHERE movies.id = 41;