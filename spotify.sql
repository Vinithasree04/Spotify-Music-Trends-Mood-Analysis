CREATE DATABASE spotify;
use spotify;
show tables;
SELECT * FROM spotify_dataset limit 10;

-- ================================
-- BASIC ANALYSIS
-- ================================

-- Q1: Total songs in dataset
SELECT COUNT(*) AS total_songs 
FROM spotify_dataset;


-- Q2: Songs per language
SELECT Language, COUNT(*) AS total_songs
FROM spotify_dataset
GROUP BY Language
ORDER BY total_songs DESC;

-- Q3: Songs per mood
SELECT Mood, COUNT(*) AS total_songs
FROM spotify_dataset
GROUP BY Mood
ORDER BY total_songs DESC;

-- Q4: Songs per genre
SELECT Genre_category, COUNT(*) AS total_songs
FROM spotify_dataset
GROUP BY Genre_category
ORDER BY total_songs DESC;

-- Q5: Songs per song type (Movie vs Private)
SELECT Song_Type, COUNT(*) AS total_songs
FROM spotify_dataset
GROUP BY Song_Type;

-- ================================
-- POPULARITY ANALYSIS
-- ================================

-- Q6: Average popularity by language
SELECT Language, 
ROUND(AVG(Popularity), 2) AS avg_popularity
FROM spotify_dataset
GROUP BY Language
ORDER BY avg_popularity DESC;

-- Q7: Average popularity by mood
SELECT Mood, 
ROUND(AVG(Popularity), 2) AS avg_popularity,
COUNT(*) AS total_songs
FROM spotify_dataset
GROUP BY Mood
ORDER BY avg_popularity DESC;


-- Q8: Top 10 most popular songs
SELECT `Track Name`, `Artist Name(s)`, Language, Popularity
FROM spotify_dataset
ORDER BY Popularity DESC
LIMIT 10;

-- Q9: Top 10 least popular songs
SELECT `Track Name`, `Artist Name(s)`, Language, Popularity
FROM spotify_dataset
ORDER BY Popularity ASC
LIMIT 10;

-- ================================
-- ARTIST ANALYSIS
-- ================================

/*--- Q10: Count of songs per artist (top 10)
SELECT `Artist Name(s)`, COUNT(*) AS total_songs
FROM spotify_dataset
GROUP BY `Artist Name(s)`
ORDER BY total_songs desc
LIMIT 10; --*/

-- Q10: Top Artists by Average Popularity and Energy 
SELECT
    CASE
        WHEN `Artist Name(s)` LIKE '%Anirudh%' THEN 'Anirudh Ravichander'
        WHEN `Artist Name(s)` LIKE '%Arijit Singh%' THEN 'Arijit Singh'
        WHEN `Artist Name(s)` LIKE '%A.R. Rahman%' THEN 'A.R. Rahman'
        WHEN `Artist Name(s)` LIKE '%Sid Sriram%' THEN 'Sid Sriram'
        WHEN `Artist Name(s)` LIKE '%Armaan Malik%' THEN 'Armaan Malik'
        WHEN `Artist Name(s)` LIKE '%Shreya Ghoshal%' THEN 'Shreya Ghoshal'
        WHEN `Artist Name(s)` LIKE '%Thaman%' THEN 'Thaman S'
        WHEN `Artist Name(s)` LIKE '%Devi Sri Prasad%' 
          OR `Artist Name(s)` LIKE '%DSP%' THEN 'DSP'
        WHEN `Artist Name(s)` LIKE '%G. V. Prakash%' THEN 'G. V. Prakash'
        WHEN `Artist Name(s)` LIKE '%Sai Abhyankkar%' THEN 'Sai Abhyankkar'
    END AS Artist,

    CONCAT(ROUND(AVG(Popularity)), '%') AS Popularity,
    CONCAT(ROUND(AVG(Energy) * 100), '%') AS Energy,
    COUNT(*) AS Total_Songs

FROM spotify_dataset

WHERE `Artist Name(s)` LIKE '%Anirudh%'
   OR `Artist Name(s)` LIKE '%Arijit Singh%'
   OR `Artist Name(s)` LIKE '%A.R. Rahman%'
   OR `Artist Name(s)` LIKE '%Sid Sriram%'
   OR `Artist Name(s)` LIKE '%Armaan Malik%'
   OR `Artist Name(s)` LIKE '%Shreya Ghoshal%'
   OR `Artist Name(s)` LIKE '%Thaman%'
   OR `Artist Name(s)` LIKE '%Devi Sri Prasad%'
   OR `Artist Name(s)` LIKE '%DSP%'
   OR `Artist Name(s)` LIKE '%G. V. Prakash%'
   OR `Artist Name(s)` LIKE '%Sai Abhyankkar%'

GROUP BY Artist
ORDER BY ROUND(AVG(Popularity)) DESC;


-- Q11: Most popular artists by avg popularity
SELECT `Artist Name(s)`, 
ROUND(AVG(Popularity), 2) AS avg_popularity,
COUNT(*) AS total_songs
FROM spotify_dataset
GROUP BY `Artist Name(s)`
HAVING COUNT(*) >= 3
ORDER BY avg_popularity DESC
LIMIT 10;

-- ================================
-- YEAR TREND ANALYSIS
-- ================================

-- Q12: Songs released per year
SELECT `Release Year`, COUNT(*) AS total_songs
FROM spotify_dataset
GROUP BY `Release Year`
ORDER BY `Release Year` DESC;

-- Q13: Average popularity per year
SELECT `Release Year`, 
ROUND(AVG(Popularity), 2) AS avg_popularity
FROM spotify_dataset
GROUP BY `Release Year`
ORDER BY `Release Year` DESC;

-- ================================
-- AUDIO FEATURE ANALYSIS
-- ================================

-- Q14: Average audio features by mood
SELECT Mood,
ROUND(AVG(Danceability), 3) AS avg_danceability,
ROUND(AVG(Energy), 3) AS avg_energy,
ROUND(AVG(Valence), 3) AS avg_valence,
ROUND(AVG(Tempo), 1) AS avg_tempo
FROM spotify_dataset
GROUP BY Mood
ORDER BY avg_energy DESC;

-- Q15: Average audio features by language
SELECT Language,
ROUND(AVG(Danceability), 3) AS avg_danceability,
ROUND(AVG(Energy), 3) AS avg_energy,
ROUND(AVG(Tempo), 1) AS avg_tempo
FROM spotify_dataset
GROUP BY Language
ORDER BY avg_energy DESC;

-- ================================
-- STREAM CATEGORY ANALYSIS
-- ================================

-- Q16: Stream category distribution
SELECT `Stream Category`, COUNT(*) AS total_songs,
ROUND(AVG(Popularity), 2) AS avg_popularity
FROM spotify_dataset
GROUP BY `Stream Category`
ORDER BY avg_popularity DESC;

-- Q17: High streamed songs per language
SELECT Language, COUNT(*) AS high_stream_songs
FROM spotify_dataset
WHERE `Stream Category` = 'High'
GROUP BY Language
ORDER BY high_stream_songs DESC;

-- ================================
-- ADVANCED ANALYSIS
-- ================================

-- Q18: Most popular genre per language
SELECT Language, Genre_category, COUNT(*) AS total_songs
FROM spotify_dataset
GROUP BY Language, Genre_category
ORDER BY Language, total_songs DESC;

-- Q19: Mood distribution per language
SELECT Language, Mood, COUNT(*) AS total_songs
FROM spotify_dataset
GROUP BY Language, Mood
ORDER BY Language, total_songs DESC;

-- Q20: High energy songs (energy > 0.8)
SELECT `Track Name`,Language,
    CONCAT(ROUND(Energy * 100), '%') AS Energy,
    Mood
FROM spotify_dataset
WHERE Energy > 0.8
ORDER BY Energy DESC
LIMIT 15;

-- Q21: Most popular song in each language
SELECT Language,
       MAX(Popularity) AS max_popularity
FROM spotify_dataset
GROUP BY Language;

show tables;
-- Q22: Average popularity by Song Type
SELECT Song_Type,
       ROUND(AVG(Popularity),2) AS avg_popularity
FROM spotify_dataset
GROUP BY Song_Type;

-- Q23: Mood with highest average energy
SELECT Mood,
       ROUND(AVG(Energy),3) AS avg_energy
FROM spotify_dataset
GROUP BY Mood
ORDER BY avg_energy DESC;

-- Q24: Top 5 longest songs
SELECT `Track Name`,
       `Duration (mins)`
FROM spotify_dataset
ORDER BY `Duration (mins)` DESC
LIMIT 5;

-- Q25: Language-wise High Stream Percentage
SELECT Language,
       COUNT(CASE WHEN `Stream Category`='High' THEN 1 END) AS high_streams,
       COUNT(*) AS total_songs
FROM spotify_dataset
GROUP BY Language;