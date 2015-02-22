1.

/* AsText function converts the internal representation of a geometry to a string format. */

SET @b = 'POLYGON((0 0, 100000 0, 100000 100000, 0 100000, 0 0))'; 
/* can use @b in the polygon area. */

SELECT b_id, AsText(b_location) 
FROM building
WHERE contains (GeomFromText('Polygon((0 0, 100000 0, 100000 100000, 0 100000, 0 0))'), b_location);


SELECT s_id, AsText(s_location) 
FROM student 	
WHERE contains (GeomFromText('Polygon((0 0, 100000 0, 100000 100000, 0 100000, 0 0))'), s_location);

SELECT t_id, AsText(t_location) 
FROM tramstop
WHERE contains (GeomFromText('Polygon((0 0, 100000 0, 100000 100000, 0 100000, 0 0))'), t_location);


2.

SET @point = 'POINT(10 10)';  
SET @radius = 200000; 
SELECT b_id, b_name, AsText(b_location) 
FROM  building
WHERE ST_Distance(b_location, GeomFromText(@point)) < @radius;

SET @point = 'POINT(10 10)'; 
SET @radius = 2000; 
SELECT t_id,AsText(t_location) 
FROM  tramstop
WHERE ST_Distance(t_location, GeomFromText(@point)) < @radius;


SET @point = 'POINT(10 10)';  
SET @radius = 2000; 
SELECT b_id, b_name
FROM  building
WHERE ST_Distance(b_location, GeomFromText(@point)) < @radius

UNION

SELECT t_id,AsText(t_location) 
FROM  tramstop
WHERE ST_Distance(t_location, GeomFromText(@point)) < @radius;




SET @point = (SELECT AsText(s_location) FROM student WHERE s_id = 'p1');
SET @radius = 100; 


SELECT b_id, 
FROM  building
WHERE ST_Distance(b_location, GeomFromText(@point)) < @radius

UNION

SELECT t_id
FROM  tramstop
WHERE ST_Distance(t_location, GeomFromText(@point)) < @radius;



3.
/*
SET @s = 'POINT(10,10)';
SET @b = 'POLYGON((0 0, 100000 0, 100000 100000, 0 100000, 0 0))'; 
SET @T =  'POINT()';

SELECT b_id, b_name, AsText(b_location)
FROM building
ORDER BY ST_DISTANCE(@spoint, b_location)
LIMIT 5

UNION

SELECT b_id, b_name, AsText(b_location)
FROM building
ORDER BY ST_DISTANCE(@spoint, b_location)
LIMIT 5;
*/

SET @s = 'POINT(10,10)';
SET @b = 'POLYGON((0 0, 100 0, 100 100, 0 100, 0 0))'; 
SET @T =  'POINT()';

SELECT b_id, b_name, AsText(b_location)
FROM building
ORDER BY ST_DISTANCE(@s, b_location)
LIMIT 5;



SELECT * FROM
(
	SELECT b_id, ST_DISTANCE(s_location, b_location) AS dis
	FROM building, student

	UNION

	SELECT t_id, ST_DISTANCE(s_location, t_location) AS dis
	FROM tramstop, student
) a 
ORDER BY dis ASC
LIMIT 5;



SELECT * FROM
(
SELECT s_id, ST_DISTANCE(s_location, b_location) AS dis
FROM building, student
WHERE b_id = 'b3'

UNION

SELECT t_id, ST_DISTANCE(t_location, b_location) AS dis
FROM building, tramstop
WHERE b_id = 'b3'
) a 
ORDER BY dis ASC
LIMIT 5;




4.1

SELECT b_id FROM building WHERE
st_contains
(
	(SELECT st_intersects
	(GeomFromText("SELECT buffer(t_location, t_radius) FROM tramstop WHERE t_id = 't2ohe'"), 
	 GeomFromText("SELECT buffer(t_location, t_radius) FROM tramstop WHERE t_id = 't6ssl'"))),
     b_location
 )
 
 UNION
 
SELECT s_id FROM student WHERE
st_contains
(
	(SELECT st_intersects
	(GeomFromText("SELECT buffer(t_location, t_radius) FROM tramstop WHERE t_id = 't2ohe'"), 
	 GeomFromText("SELECT buffer(t_location, t_radius) FROM tramstop WHERE t_id = 't6ssl'"))),
     s_location
 )


4.2

SELECT t_id
FROM tramstop
ORDER BY ST_DISTANCE((SELECT t_location FROM tramstop WHERE t_id = 't1psa' ), (SELECT s_location FROM student WHERE s_id = 'p3'))
LIMIT 5;


4.3

SELECT s_id, count(*) AS num
FROM tramstop, student
WHERE ST_DISTANCE(t_location, s_location) < 250
GROUP BY t_id
ORDER BY count(*) DESC
LIMIT 1;


4.4



SELECT s_id, s_location, b_id, b_location, st_distance(s_location, b_location)
FROM student, building
GROUP BY b_id
ORDER BY st_distance(s_location, b_location) ASC



SELECT count(s_id), s_id FROM
(
(
SELECT s_id, s_location, b_id, b_location, st_distance(s_location, b_location)
FROM student, building
WHERE B_ID = 'b3'

ORDER BY st_distance(s_location, b_location) ASC
limit 1
)

union

(
SELECT s_id, s_location, b_id, b_location, st_distance(s_location, b_location)
FROM student, building
WHERE B_ID = 'b1'

ORDER BY st_distance(s_location, b_location) ASC
limit 1
)

union

(
SELECT s_id, s_location, b_id, b_location, st_distance(s_location, b_location)
FROM student, building
WHERE B_ID = 'b2'

ORDER BY st_distance(s_location, b_location) ASC
limit 1
)
) a
GROUP BY s_id
ORDER BY count(s_id) DESC
LIMIT 5
;



4.5

(SELECT min(astext(POINTN(EXTERIORRING(envelope(b_location)),1))) AS p FROM building WHERE b_name like 'SS%' ORDER BY b_id)
union
(SELECT max(astext(POINTN(EXTERIORRING(envelope(b_location)),3)))  AS p FROM building WHERE b_name like 'SS%' ORDER BY b_id)








