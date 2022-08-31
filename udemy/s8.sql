SELECT title FROM books WHERE title LIKE '%stories%';
SELECT title, pages FROM books ORDER BY pages DESC LIMIT 1;
SELECT title, pages FROM books WHERE pages = (SELECT MAX(pages) FROM books); -- Solution 2
SELECT CONCAT(title,' - ',released_year) AS summary FROM books ORDER BY released_year DESC LIMIT 3;
SELECT title, author_lname FROM books WHERE author_lname LIKE '% %';
SELECT title, released_year AS year, stock_quantity FROM books ORDER BY stock_quantity, title ASC LIMIT 3;
SELECT title, author_lname FROM books ORDER BY author_lname, title ASC;
SELECT UPPER(CONCAT('My favorite author is ', author_fname, ' ', author_lname, '!')) AS yell FROM books ORDER BY author_lname ASC;
