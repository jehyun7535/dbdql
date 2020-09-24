CREATE UNIQUE INDEX idx_emp_u_01 ON emp (empno);
CREATE INDEX idx_emp_02 ON emp (ename);
CREATE INDEX idx_emp_03 ON emp (deptno, sal, loc);