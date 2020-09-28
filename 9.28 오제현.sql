
sub3]
CREATE TABLE emp_test AS
SELECT * 
FROM emp;

UPDATE emp_test SET sal = (sal + 200)
WHERE sal < (SELECT AVG(sal)
            FROM emp WHERE deptno = emp_test.deptno);

