use employees_db;
select * from  employees_cleaned;

#AVG SALARY,MIN SALARY,MAX SALARY OF THE COMPANY employees
select avg(salary) as avg_salary,min(salary) as min_salary
           ,max(salary) as max_salary from  employees_cleaned;
		    
            
# GENDER WISE TOTAL SALARY DISTRIBUTION

select gender,sum(salary) as total_salary from employees_cleaned
group by gender;

# TOP THREE MOST PAID EMPLOYEES
select * from employees_cleaned
order by salary desc
limit 3;


# 5 LEAST PAID EMPLOYEES
select * from employees_cleaned
order by salary asc
limit 5;

# SECOND HIGHEST PAID EMPLOYEES IN THE COMPANY
select * from employees_cleaned
order by salary desc
limit 1 offset 1;

# DEPARTMENTs AVG SALARY SALARY DISTRIBUTION

select department,avg(salary) as AVG_SALARY
from employees_cleaned
group by department;

#employees whose salary is greater than avg salary of 
select name, salary from employees_cleaned
where salary>( select AVG(salary) from employees_cleaned);

# COUNT OF EMPLOYEES FROM EACH CITY
select  city,count(empid) as EMPLOYEE_COUNT
from employees_cleaned
group by city;

# TOP EARNING EMPLOYEE FROM EACH CITY
select e.name,e.city,e.salary from employees_cleaned e
join ( select city,max(salary) as max_salary from employees_cleaned 

      group by city)m
on e.city=e.city and e.salary=m.max_salary;

# HIGHEST PAID EMPLOYEES FROM EACH GENDER
select e.name ,e.gender,e.salary from employees_cleaned e
join (select gender,max(salary) as max_salary from employees_cleaned
      group by gender)m
      
	on e.gender=m.gender and e.salary=m.max_salary;
    
#EMPLOYEES WITH EXCELLENT PERFORMANCE

select * from employees_cleaned
where performance='EXCELLENT';

# TOP 5 MOST EXPERIENCED EMPLOYEES
select * from employees_cleaned
order by experience_year desc
limit 5;

# COUNT OF EMPLOYEES JOINED IN each QUARTER OF THE YEAR

select count(empid) as total_employees,join_quarter
from employees_cleaned
group by join_quarter




