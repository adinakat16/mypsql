create table movies (
	movie_id BIGSERIAL NOT NULL PRIMARY KEY,
	movie_name VARCHAR(100) NOT NULL,
	movie_genre VARCHAR(70),
	imdb_ratings DECIMAL(2,1)
);
-- insert entry, update entry,delete enetry
insert into movies (movie_id, movie_name, movie_genre, imdb_ratings) values (1, 'Day for Night (La Nuit Américaine)', 'Comedy|Drama|Romance', 1.6);
update movies set movie_genre = 'drama,crime' where movie_id = 2;
delete from movies where movie_id = 3;
select * from movies;

-- where clause: beetween,in relatinal operator
select * from movies where imdb_ratings >=4;
select * from movies where imdb_ratings between 2 AND 4;
select * from movies where movie_genre = 'Action';
select movie_name,movie_genre from movies where imdb_ratings < 3.5;
select * from movies where imdb_ratings in (2.9,3.6,4.0);

--------create drop database or table------------
drop table employees;
create table employees (
	emp_id BIGSERIAL NOT NULL PRIMARY KEY,
	emp_name VARCHAR(50) NOT NULL,
	email VARCHAR(50),
	gender VARCHAR(50) NOT NULL,
	department VARCHAR(50),
	address VARCHAR(50),
	salary DECIMAL(3,1) NOT NULL
);
-- to import csv rightclick on table name and then import select file then tick header check columns and proceed

select * from employees;

----- conditioning quieries with disticnt, and ,or,is null---------
select distinct department from employees;
select * from employees where address is null;
select * from employees where address is null AND department is null;
select * from employees where email is null OR department is null;
select * from employees where department = 'Marketing' AND salary >20.3;
select * from employees where gender<>'Female' AND department='Marketing'; 

------------- order by----------------------
select * from employees order by salary;
select * from employees order by salary desc;


--------limit,offset,fetch,like-------
select * from employees order by salary desc limit 5;
select * from employees order by salary offset 145;
select * from employees order by salary desc fetch first 5 row only;
select * from employees order by salary desc offset 3 fetch  first 5 rows only;
select emp_name,email from employees where emp_name like 'A%';  --starts with a
select emp_name,email from employees where emp_name like 'Ah%';  --starts with Ah
select emp_name,email from employees where emp_name like '%d';  --ends with d
select emp_name,email from employees where emp_name like '%lli%';  --have lli
select emp_name,email from employees where emp_name like '_l%';  --second letter l
select emp_name,email from employees where emp_name like '_la%';  --second letter la


------- to make chnages in the table not entry---------
alter table employees rename column address to street;
alter table employees rename column street to address;

-------------sql inbuild functions--------------------
select sum(salary) from employees;
select sum(salary) As Total_salaries from employees;
select avg(salary) As mean_salary from employees;
select max (salary) As max_salary from employees;
select min (salary) As min_salary from employees;
select count(distinct department) As total_departments from employees;
select distinct department from employees;

------------group by clause----------------
select department,avg(salary) as avg_salary from employees group by department order by avg_salary;
select gender,max(salary) as max_salary from employees group by gender;
select department,count(emp_id) as no_of_employees from employees group by department;
select department,count(emp_id) as no_of_employees from employees where department is not null group by department;

---------having clause-------------------
-- vary imp which works like where clause but it can be used with
-- aggregate functions
-- it is used with group by clause to return rows satisfying condition
select department ,avg(salary) as avg_salary from employees where department is not null group by department having avg(salary)>30.3;
select department, count(emp_id) from employees group by department having count(emp_id)<10 order by count(emp_id);


---------------manupulation demo--------------
select count(distinct department) As total_departments from employees;
select distinct department from employees;
--these are entries whose department is null so let's display wihtout null
select distinct department from employees where department is not null;
--lets update department of entry whose id is 25 and department is null
update employees set department ='Accounting' where emp_id=25;
--lets change null department to aditya
update employees set department ='Aditya' where department is null;
select * from employees where department ='Aditya';
update employees set department = null where department ='Aditya';
select * from employees where department is null;

--------case statement----------------
--we will create new column stating salary range of that entry
select emp_name,department,salary,
Case
when salary<27 then 'low salary'
when salary>27 and salary<60 
then 'average salary'
when salary>60 then 'high salary'
end as salary_range
from employees order by salary desc;

------subqueries---------------------
select emp_name,department,salary from employees where salary>(select avg(salary) from employees) order by salary;

/*_________sql function______*/
--math functions
select abs(-100) as absolute_number;
select greatest(2,54,67,4,90,56.5,70);
select least(2,54,67,4,90,56.5,70);
select mod(54,10);
select power(2,3);
select sqrt (144);
select sine(0);
select cos(90);
select ceiling(20.45);
select floor(20.68);
--string functions
select char_length('aditya nakat');
select concat('postgres','SQL',' is',' instresting');
select left('aditya nakat is awesome',8);
select right('aditya nakat is awesome',9);
select repeat('INDIA ',5);
select reverse('funny');
--userdefine function
/*total email id present in table*/
create or replace function count_emails()
returns integer as $total_emails$
declare
	total_emails integer;
begin
	select count(email) into total_emails from employees;
	return total_emails;
end;
$total_emails$ language plpgsql;
--call function
select count_emails();--not included null emails


