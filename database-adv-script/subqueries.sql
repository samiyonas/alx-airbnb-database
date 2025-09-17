SELECT * FROM Property
WHERE rating > (SELECT AVG(rating) FROM Property);
