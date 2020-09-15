join0
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
ORDER BY deptno;

join0_1
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.deptno IN (10, 30);

join0_2
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND sal > 2500
ORDER BY deptno;

join0_3
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND sal > 2500 AND empno > 7600
ORDER BY deptno;

join0_4
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND sal > 2500 AND empno > 7600
AND d.dname = 'RESEARCH';

grp5
 
SELECT TO_CHAR(hiredate, 'YYYY') hire_yyyy, count(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY');

grp6
SELECT count(*) cnt
FROM dept;

grp7

SELECT count(COUNT(*)) cnt
FROM emp
GROUP BY deptno;

