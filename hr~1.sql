join6
SELECT customer.cid, customer.cnm, cycle.pid, product.pnm,SUM(cycle.cnt)cnt
FROM customer JOIN cycle ON(customer.cid = cycle.cid)  
JOIN product ON(cycle.pid = product.pid)
GROUP BY customer.cid, customer.cnm, cycle.pid, product.pnm,cycle.cnt;

join7
SELECT cycle.pid, product.pnm, SUM(cycle.cnt)cnt
FROM  cycle,  product 
WHERE cycle.pid = product.pid
GROUP BY cycle.pid, product.pnm

join 8
SELECT r.region_id, r.region_name, c.country_name
FROM countries c, regions r
WHERE r. region_id = c. region_id 
AND region_name = 'Europe';

join9
SELECT r.region_id, r.region_name, c.country_name, l.city
FROM countries c, regions r, locations l
WHERE r. region_id = c. region_id AND c.country_id = l.country_id
AND region_name = 'Europe';

join10
SELECT r.region_id, r.region_name, c.country_name, l.city, d.department_name
FROM countries c, regions r, locations l, departments d
WHERE r. region_id = c. region_id
AND c.country_id = l.country_id
AND l.location_id = d.location_id
AND region_name = 'Europe';

join11
SELECT r.region_id, r.region_name, c.country_name, l.city,
d.department_name, CONCAT(e.first_name, e.last_name) name
FROM countries c, regions r, locations l, departments d
, employees e
WHERE r. region_id = c. region_id
AND c.country_id = l.country_id
AND l.location_id = d.location_id
AND d.department_id = e.department_id 
AND region_name = 'Europe';

join12
SELECT e.employee_id, CONCAT(e.first_name, e.last_name) name,
j.job_id, j.job_title
FROM  employees e, jobs j
WHERE e.job_id = j.job_id;

join13
SELECT e.mgr_id, e.mgr_name, e.employee_id, 
CONCAT(e.first_name, e.last_name) name,
j.job_id, j.job_title
FROM  employees e, jobs jd;
WHERE e.job_id = j.job_id;


SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

SELECT e.employee_id mgr_id, 
CONCAT(e.first_name, e.last_name) mgr_name, e.employee_id, 
CONCAT(e.first_name, e.last_name) name,
j.job_id, j.job_title
FROM  employees e, jobs j
WHERE e.job_id = j.job_id(+);





 WHERE e.deptno = d.deptno AND sal > 2500 AND empno > 7600



SELECT *
FROM jobs;

SELECT *
FROM employees;
