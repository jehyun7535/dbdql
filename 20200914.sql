customer : 고객
cid : customer id
cnm : customer name

SELECT *
FROM customer;

product : 제품
pid : product id : 제품 번호
pnm : product name : 제품 이름
SELECT *
FROM product;

cycle : 고객애음주기
cid : customer id 고객 id
pid : product id 제품 id
day : 1-7(월-토)
cnt : COUNT, 수량
SELECT *
FROM cycle;

ORACLE
SELECT customer.cid, cnm, cycle.pid, cycle.day, cycle.cnt
FROM customer, cycle
WHERE cycle.cid = customer.cid 
AND customer.cnm IN ('brown', 'sally');

join5]
SELECT customer.cid, cnm, cycle.pid, product.pnm, 
cycle.day, cycle.cnt
FROM customer, cycle, product
WHERE cycle.cid = customer.cid 
AND cycle.pid = product.pid
AND customer.cnm IN ('brown', 'sally');
SUM(cycle.cnt)cnt
join6]

SELECT customer.cid, customer.cnm, cycle.pid, product.pnm, SUM(cycle.cnt)cnt
FROM customer, cycle, product
WHERE cycle.cid = customer.cid 
AND cycle.pid = product.pid
GROUP BY customer.cid, customer.cnm, cycle.pid, product.pnm, cycle.cnt;

join7]
SELECT cycle.pid, product.pnm, SUM(cycle.cnt)cnt
FROM  cycle, product
WHERE cycle.pid = product.pid
GROUP BY cycle.pid, product.pnm, cycle.cnt;

SELECT cycle.pid, product.pnm, SUM(cycle.cnt)cnt
FROM  cycle,  product 
WHERE cycle.pid = product.pid
GROUP BY cycle.pid, product.pnm;


OUTER JOIN : 자주 쓰이지는 않지만 중요
JOIN구분
1. 문법에 따른 구분 : ANSI-SQL, ORACLE
2. join의 형태에 따른 구분 : SELF-JOIN, NONEQUI-JOIN, CROSS-JOIN
3. join 성공여부에 따라 데이터 표시여부 
    : INNER JOIN - 조인이 성공했을때 데이터를 표시
    : OUTER JOIN - 조인이 실패해도 기준으로 정한 테이블의 컬럼 정보는 표시
    
사번, 사번의이름, 관리자 사번, 관리자 이름
KING(PRESIDENT)의 경우 MGR 컬럼의 값이 NULL 이기 때문에
조인에 실패.


SELECT e.empno, e.ename, e.mgr, m.ename 
FROM emp e, emp m
WHERE e.mgr = m.empno;

ANSI-SQL
SELECT e.empno, e.ename, e.mgr, m.ename 
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno);

행에 대한 제한 조건 기술시 WHERE절에 기술 했을 때와 ON 절에 기술 했을 때
결과가 다르다

사원의 부서가 10번인 사람들만 조회 되도록 부서 번호 조건을 추가
SELECT e.empno, e.ename, e.mgr, m.ename 
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno AND e.deptno = 10);

조건을 WHERE 절에 기술한 경우 ==> OUTER JOIN이 아닌 INNER 조인 결과가 나온다
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
WHERE e.deptno = 10;

ANSI-SQL
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno);

ORACLE = SQL : 데이터가 없는 쪽의 컬럼에 (+) 기호를 붙인자
                ANSI-SQL 기준 테이블 반대편 테이블의 컬럼에 (+)을 붙인다
SELECT e.empno, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno(+);

SELECT e.empno, e.ename, e.mgr, m.empno, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno);
ORDER BY deptno;

SELECT e.ename, m.ename
FROM emp e LEFT OUTER JOIN emp m ON (e.mgr = m.empno)
UNION
SELECT e.ename, m.ename
FROM emp e RIGHT OUTER JOIN emp m ON (e.mgr = m.empno)
INTERSECT
SELECT e.ename, m.ename
FROM emp e FULL OUTER JOIN emp m ON (e.mgr = m.empno);

OUTERJOIN1]
SELECT b.buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buyprod b RIGHT OUTER JOIN prod p ON (b.buy_prod = p.prod_id)
AND b.BUY_DATE(+) = TO_DATE('2005/01/25', 'YY/MM/DD');







    
    








