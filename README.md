# Module7_Pewlett-Hackard-Analysis

# Part 1
Please refer to the challenge.sql
## Number of [titles] Retiring
Please refer to the Part1A.csv file.
## Only the Most Recent Titles
Please refer to the Part1B.csv file.
## Who's Ready for a Mentor?
Please refer to the Part1C.csv file.

# Part 2
## Project Summary
Of the 300024 employees, 71193 employees are likely to retire based on the 1952-1955 birth date criteria. Only 1549 are ready for mentoring based on the 1965 birth date criteria. Based on these numbers, mentoring process must begin immediately to prevent a shortage of eligible replacements for the retirees.
If more time for analysis was given, I would look into the number of retirees and eligible mentors per department, to see which department requires most attention in terms of mentoring expertise.

## PNG of ERD
Please refer to EmployeeDB.png

## Code for the requested queries
- Part 1A - Number of [titles] Retiring

-- Generate Initial Retirement Table (InitRetire.csv)
'''
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
'''
-- 1A Example output: 
emp_no	first_name	last_name	title	from_date	salary
10194	Josyula	Hofmeyr	Senior Staff	2/14/2002	64941
10001	Georgi	Facello	Senior Engineer	6/26/1986	60117
10004	Chirstian	Koblick	Senior Engineer	12/1/1995	40054
10005	Kyoichi	Maliniak	Senior Staff	9/12/1996	78228

- Part 1B - Only the Most Recent Titles
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

-- 1B Example output CSV:
emp_no	first_name	last_name	title	from_date	salary
10194	Josyula	Hofmeyr	Senior Staff	2/14/2002	64941
10001	Georgi	Facello	Senior Engineer	6/26/1986	60117
10004	Chirstian	Koblick	Senior Engineer	12/1/1995	40054
10005	Kyoichi	Maliniak	Senior Staff	9/12/1996	78228

-- 1B Example output frequency:
"Engineer"	"9163"
"Senior Engineer"	"25436"
"Manager"	"2"
"Assistant Engineer"	"1075"
"Staff"	"7541"
"Senior Staff"	"24466"
"Technique Leader"	"3510"

-- 1B Frequency count of titles (ordered by date)
SELECT
    first_name, last_name, title, count(title), from_date
FROM
    part1a
GROUP BY
    first_name, last_name, title, from_date
ORDER BY 
    from_date DESC;

-- 1B Example output descending by date:
I'm unable to copy/paste data output window, unless it is saved in table schema. Please advise.

- Part 1C - Who's Ready for a Mentor?
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

-- 1C Example Output
emp_no	first_name	last_name	title	from_date	to_date
10095	Hilari	Morton	Senior Staff	3/9/2000	1/1/9999
10122	Ohad	Esposito	Technique Leader	8/6/1998	1/1/9999
10291	Dipayan	Seghrouchni	Senior Staff	3/30/1994	1/1/9999
10476	Kokou	Iisaka	Senior Staff	9/20/1994	1/1/9999
 
