-- 1. Find the titles of all movies directed by Steven Spielberg.

select title
from Movie
where director = "Steven Spielberg";

-- 2. Find all years that have a movie that received a rating of 4 or 5, and sort them in increasing order.

select distinct year
from Movie, Rating
where stars >= 4 and Movie.mId = Rating.mId
order by year;

-- 3. Find the titles of all movies that have no ratings. 

select title
from Movie
where Movie.mId not in (select Rating.mId from Rating);

-- 4. Some reviewers didn't provide a date with their rating. Find the names of all reviewers who have ratings with a NULL value for the date.

select name
from Reviewer, Rating
where Reviewer.rId = Rating.rId and ratingDate is null;

-- 5. Write a query to return the ratings data in a more readable format: reviewer name, movie title, stars, and ratingDate. Also, sort the data, first by reviewer name, then by movie title, and lastly by number of stars.

select distinct name, title, stars, ratingDate
from Movie, Reviewer, Rating
where Movie.mId = Rating.mId AND Reviewer.rId = Rating.rId
order by name, title, stars;

-- 6. For all cases where the same reviewer rated the same movie twice and gave it a higher rating the second time, return the reviewer's name and the title of the movie.

select name, title
from Movie
INNER JOIN Rating R1 USING(mId)
INNER JOIN Rating R2 USING(rId)
INNER JOIN Reviewer USING(rId)
where R1.mId = R2.mId AND R1.ratingDate < R2.ratingDate AND R1.stars < R2.stars;

-- 7. For each movie that has at least one rating, find the highest number of stars that movie received. Return the movie title and number of stars. Sort by movie title.

select title, max(stars)
from Movie, Rating
where Movie.mId = Rating.mId
GROUP BY Movie.mId
order by title;

-- 8. For each movie, return the title and the 'rating spread', that is, the difference between highest and lowest ratings given to that movie. Sort by rating spread from highest to lowest, then by movie title. 

select title, (max(stars) - min(stars)) as rating_spread
from Movie, Rating
where Movie.mId = Rating.mId
GROUP BY Movie.mId
order by rating_spread DESC, title;


