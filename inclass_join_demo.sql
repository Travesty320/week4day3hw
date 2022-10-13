SELECT * FROM artist;

SELECT * from favorite_song;



-- FROM CLAUSE (Left Table)
-- JOIN CLAUSE (Right Table)
SELECT *
FROM artist 
INNER JOIN favorite_song
ON favorite_song.artist_id = artist.artist_id;

SELECT *
FROM favorite_song 
INNER JOIN artist
ON favorite_song.artist_id = artist.artist_id;


-- LEFT JOIN
SELECT *
FROM artist 
LEFT JOIN favorite_song
ON favorite_song.artist_id = artist.artist_id;

-- RIGHT JOIN
SELECT *
FROM artist 
RIGHT JOIN favorite_song
ON favorite_song.artist_id = artist.artist_id;

-- FULL JOIN (OUTER JOIN)
SELECT *
FROM artist 
FULL JOIN favorite_song
ON favorite_song.artist_id = artist.artist_id;


-- Extra stuff to know about
SELECT artist_name, favorite_song.song_name, album, favorite_song.artist_id
FROM artist 
INNER JOIN favorite_song
ON favorite_song.artist_id = artist.artist_id;


-- ALIAS (Using AS keyword)
SELECT f_s.artist_id, a.artist_name, song_name 
FROM artist AS a
INNER JOIN favorite_song AS f_s
ON f_s.artist_id = a.artist_id
WHERE artist_name = 'Pop Smoke';