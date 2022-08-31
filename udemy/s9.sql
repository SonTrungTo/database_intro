-- My notes
SELECT MIN(released_year) AS earliest_year, CONCAT_WS(' ', author_fname, author_lname) AS author FROM books GROUP BY CONCAT_WS(' ', author_fname, author_lname);
CREATE VIEW (earliest_year, author) AS SELECT MIN(released_year) AS earliest_year, CONCAT_WS(' ', author_fname, author_lname) AS author FROM books GROUP BY CONCAT_WS(' ', author_fname, author_lname);
SELECT SUM(pages), author_fname, author_lname FROM books GROUP BY author_fname, author_lname;
-- Number of books
SELECT COUNT(*) AS 'number_of_books' FROM books;
-- Number of books per year
SELECT COUNT(*) AS number_of_books, released_year FROM books GROUP BY released_year;
-- Total quantity available
SELECT SUM(stock_quantity) AS total_quantity FROM books;
-- Average released year for each author
SELECT AVG(released_year), author_fname, author_lname FROM books 
    GROUP BY author_fname, author_lname;
-- Fullname of author who writes the longest book
SELECT CONCAT_WS(' ', author_fname, author_lname) AS fullname, pages FROM books WHERE pages = (SELECT MAX(pages) FROM books);
-- Printout
SELECT released_year AS year, COUNT(DISTINCT title) AS '# books', AVG(pages) AS 'avg pages' FROM books GROUP BY released_year;
