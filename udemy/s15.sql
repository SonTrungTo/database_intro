-- Find 5 oldest users
-- SELECT * FROM users ORDER BY created_at LIMIT 5;

-- What day of week most users register on?
CREATE OR REPLACE VIEW most_users AS SELECT
    DAYNAME(created_at) AS week_day,
    COUNT(*) AS number_of_users
FROM users
GROUP BY DAYNAME(created_at);

SELECT week_day FROM most_users
WHERE number_of_users = (SELECT MAX(number_of_users) FROM most_users);

-- Find inactive users, those who have not posted photo
SELECT u.id, u.username, u.created_at
  FROM users u
  LEFT JOIN photos p
  ON u.id = p.user_id
  WHERE p.user_id IS NULL;

-- Find who gets the most likes on a single photo
CREATE OR REPLACE VIEW likes_by_photo AS SELECT
    photo_id,
    COUNT(*) AS numberOfLikes
FROM likes
GROUP BY photo_id;

CREATE OR REPLACE VIEW most_likes_by_user AS SELECT
    p.user_id,
    MAX(lp.numberOfLikes) AS numberOfLikes
FROM photos p
INNER JOIN likes_by_photo lp ON p.id = lp.photo_id
GROUP BY p.user_id
ORDER BY MAX(lp.numberOfLikes);

SELECT u.id, u.username, mlu.numberOfLikes FROM users u
    INNER JOIN most_likes_by_user mlu ON u.id = mlu.user_id
    WHERE mlu.numberOfLikes = (SELECT MAX(numberOfLikes) FROM most_likes_by_user);

-- What is the average of photos per user?
select (count(distinct p.id)/count(distinct u.id)) from users u left join photos p on u.id = p.user_id;

-- Top 5 hashtags used?
SELECT t1.tag_name FROM tags t1
INNER JOIN (
    SELECT tag_id, COUNT(*) AS time_used
    FROM photo_tags
    GROUP BY tag_id
    ORDER BY COUNT(*) DESC
    LIMIT 5
) t2 ON t1.id = t2.tag_id;

-- Users who like every post
SELECT u.id, u.username, t.numberOfLikes FROM users u
INNER JOIN (SELECT user_id, COUNT(*) as numberOfLikes FROM likes l GROUP BY user_id HAVING COUNT(*) = (SELECT COUNT(*) FROM photos)) t
ON u.id = t.user_id;
