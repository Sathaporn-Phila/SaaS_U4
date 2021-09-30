SELECT movies.*
  FROM movies JOIN reviews ON movies.id = reviews.movie_id
  JOIN moviegoers ON moviegoers.id = reviews.moviegoer_id
  WHERE moviegoers.id = 1;