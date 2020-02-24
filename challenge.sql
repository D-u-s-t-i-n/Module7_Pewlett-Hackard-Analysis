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
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
	INTO Part1C
FROM employees as e
INNER JOIN titles as t
ON (e.emp_no = t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31') AND (t.to_date = '9999-01-01');
