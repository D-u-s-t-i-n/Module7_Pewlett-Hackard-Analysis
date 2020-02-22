------------
-- Part 1 --
------------
-- Generate Initial Retirement Table (InitRetire.csv)
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	s.salary
	INTO Part1A
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31') AND (t.to_date = '9999-01-01');

-- Delete duplicates. DELETE 1265 returned.
DELETE
FROM
	part1a a
		USING part1a b
WHERE
	a.from_date < b.from_date
	AND a.first_name = b.first_name
	AND a.last_name = b.last_name;

-- Frequency count of titles
SELECT
    title,
    COUNT( title)
FROM
    Part1A
GROUP BY
    title


-- Frequency count of titles (ordered by date)
SELECT
    first_name, last_name, title, count(title), from_date
FROM
    part1a
GROUP BY
    first_name, last_name, title, from_date
ORDER BY 
    from_date DESC;

-- Who's Ready for a Mentor?


SELECT
    first_name, last_name,
    COUNT( last_name)
FROM
    Part1A
GROUP BY
    first_name, last_name
--HAVING
--    COUNT( last_name )> 1
ORDER BY
    last_name;



select COUNT(first_name)
FROM Part1A;
--WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31') --'1955-12-31';
--AND (hire_date BETWEEN '1985-01-01' AND '1988-12-31');

Employees - emp_no, first last names;
TItles - emp_no, title; from_date;
Salaries - emp_no, salary