CREATE UNIQUE INDEX idx_emp_u_01 ON emp(empno, ename);
CREATE INDEX idx_emp_n_02 ON emp(deptno, empno); 
CREATE INDEX idx_emp_n_03 ON emp(deptno, sal); 
CREATE INDEX idx_emp_n_04 ON emp(deptno, mgr, empno); 
CREATE INDEX idx_emp_n_05 ON emp(deptno);