DROP TABLE IF EXISTS query1 CASCADE;
CREATE TABLE query1 AS SELECT COUNT(*) AS "count of comments"
FROM comments
WHERE author = 'xymemez';


DROP TABLE IF EXISTS query2 CASCADE;
CREATE TABLE query2 AS SELECT 
    subreddit_type AS "subreddit type", 
    COUNT(*) AS "subreddit count"
FROM 
    subreddits
GROUP BY 
    subreddit_type;


DROP TABLE IF EXISTS query3 CASCADE;
CREATE TABLE query3 AS SELECT 
    sub.display_name AS "name", 
    COUNT(cmt.id) AS "comments count", 
    ROUND(AVG(cmt.score), 2) AS "average score"
FROM 
    subreddits sub
JOIN 
    comments cmt ON sub.display_name = cmt.subreddit
GROUP BY 
    sub.display_name
ORDER BY 
    "comments count" DESC
LIMIT 10;


DROP TABLE IF EXISTS query4 CASCADE;
CREATE TABLE query4 AS SELECT 
    name AS "name", 
    link_karma AS "link karma", 
    comment_karma AS "comment karma", 
    CASE WHEN link_karma >= comment_karma THEN 1 ELSE 0 END AS "label"
FROM 
    authors
WHERE 
    (link_karma + comment_karma) / 2 > 1000000
ORDER BY 
    (link_karma + comment_karma) / 2 DESC;


DROP TABLE IF EXISTS query5 CASCADE;
CREATE TABLE query5 AS SELECT 
    sub.subreddit_type AS "sr type", 
    COUNT(cmt.id) AS "comments num"
FROM 
    comments cmt
JOIN 
    subreddits sub ON cmt.subreddit = sub.display_name
WHERE 
    cmt.author = '[deleted_user]'
GROUP BY 
    sub.subreddit_type
ORDER BY 
    "comments num" DESC;