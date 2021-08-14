
--Deliverable #1

-- Retrieve data from Emp & Titles tables into a new table, filter by birthdate and order by emp no
SELECT employees.emp_no, employees.first_name, employees.last_name, titles.title, titles.from_date, titles.to_date
INTO retire_emp_by_title
FROM employees ,titles
WHERE employees.emp_no =titles.emp_no
AND (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no

-- View new table and verfiy data is correct
SELECT * FROM retire_emp_by_title;


--Export table as retirement_titles.csv

-- Use Dictinct with Orderby to remove duplicate rows and order by emp_no into a new table
SELECT DISTINCT ON (rt.emp_no) rt.emp_no,
rt.first_name,
rt.last_name,
rt.title
INTO unique_titles
FROM retire_emp_by_title AS rt
ORDER BY emp_no, to_date DESC;

-- View new table and verfiy data is correct
SELECT * FROM unique_titles;

--Export table as unique_titles.csv

-- Retrieve the number of titles from the Unique Titles table, create a new table and sort the count column
SELECT COUNT(ut.emp_no), ut.title
INTO retiring_titles
FROM unique_titles as ut
GROUP BY title
ORDER BY COUNT(title) DESC;

-- View new table and verfiy data is correct
SELECT * FROM retiring_titles;

--Export table as retiring_titles.csv

--Deliverable #2 / Create mentorship-eligible employees table
SELECT DISTINCT ON(e.emp_no)e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_table
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
			INNER JOIN titles AS t
				ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;

SELECT * FROM mentorship_table;

--Deliverable #3 - Additional Queries

-- Title Count by mentorship-eligible employees
SELECT COUNT(mt.emp_no), mt.title
FROM mentorship_table as mt
GROUP BY title
ORDER BY COUNT(title) DESC;


-- Increase the mentorship program eligibility 
SELECT DISTINCT ON(e.emp_no)e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
INTO mentorship_table_eligibility
FROM employees AS e
	INNER JOIN dept_emp AS de
		ON (e.emp_no = de.emp_no)
			INNER JOIN titles AS t
				ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1964-01-01' AND '1965-12-31')
AND (de.to_date = '9999-01-01')
ORDER BY emp_no;

SELECT * FROM mentorship_table_eligibility;