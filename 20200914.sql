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

OUTERJOIN2]
SELECT TO_DATE(:yyyymmdd, 'YYYY/MM/DD') 
b.buy_date, b.buy_prod, p.prod_id, p.prod_name, b.buy_qty
FROM buy_date b, prod p
WHERE b.buy_prod(+) = p.prod_id
AND b.BUY_DATE(+) = TO_DATE(:yyyymmdd, 'YY/MM/DD');

OUTERJOIN3]
SELECT TO_DATE(:yyyymmdd, 'YYYY/MM/DD') 
b.buy_date, b.buy_prod, p.prod_id, p.prod_name, NVL(b.buy_qty 0)
FROM buyprod b RIGHT OUTER JOIN prod p ON (b.buy_prod = p.prod_id)
AND b.BUY_DATE(+) = TO_DATE('2005/01/25', 'YY/MM/DD');

OUTERJOIN4]
SELECT p.pid, p.pnm, :cid cid, NVL(c.day, 0) day,
NVL(c.cnt, 0) cnt
FROM cycle c, product p
WHERE p.pid = c.pid(+)
AND c.cid(+) = :cid;

INNER JOIN : 조인이 성공하는 데이터만 조회가 되는 조인 방식
OUTER JOIN : 조인에 실패해도 기준으로 정한 테이블의 컬럼은 조회가
             되는 조인 방식
             
EMP 테이블 행 건수 (14) * DEPT 테이블의 행 건수 (4) = 56건
SELECT *
FROM emp, dept; 

cross join 실습 1
SELECT *
FROM customer CROSS JOIN product;

SQL 활용에 있어서 매우 중요
서브쿼리 : 쿼리안에서 실행되는 쿼리
1. 서브쿼리 분류 - 서브쿼리가 사용되는 위치에 따른 분류
1.1 SELECT : 스칼라 서브쿼리(SCALAR SUBQUERY)
1.2 FROM : 인라인 뷰(INLINWE-VIEW)
1.3 WHERE : 서브쿼리 (SUB QUERY)
                            (행1, 행 여러개), (컬럼1, 컬럼 여러개)
2.서브쿼리 분류 - 서브쿼리가 반환하는 행, 컬럼의 개수의 따른 분류
(행1, 행 여러개), (컬럼1, 컬럼 여러개) :
(행, 컬럼) : 4가지
2.1 단일행, 단일 컬럼
2.2 단일행, 복수 컬럼 ==> X
2.3 복수행, 단일 컬럼
2.4 복수행, 복수 컬럼

3.서브쿼리 분류 - 메인쿼리의 컬럼을 서브쿼리에서 사용여부에 따른 분류
3.1 상호 연관 서브 쿼리 (CO-RELATED SUB QUERY)
    - 메인 쿼리의 컬럼을 서브 쿼리에서 사용하는 경우
3.2 비상호 연관 서브 쿼리 (NON-CORELATED SUB QUERY)
    - 메인 쿼리의 컬럼을 서브 쿼리에서 사용하지 않는 경우
    
SMITH 가 속한 부서에 속한 사원들은 누가 있을까?
1. SMITH가 속한 부서번호 구하기
2. 1번에서 구한 부서에 속해 있는 사원들 구하기

1. SELECT deptno
   FROM emp
   WHERE ename = 'SMITH';
   
2. SELECT *
   FROM emp
   WHERE deptno = 20;
   
==> 서브쿼리를 이용하여 하나로 합칠수가 있다
SELECT *
FROM emp
WHERE deptno = (SELECT deptno
            FROM emp
            WHERE ename = 'SMITH');
서브쿼리를 사용할 때 주의점
1. 연산자
2. 서브쿼리의 리턴 형태

서브쿼리가 한개의 행 복수컬럼을 조회하고, 단일 컬럼과 = 비교 하는 경우 ==> X

서브쿼리가 여러개의 행, 단일 컬럼을 조회하는 경우
1. 사용되는 위치 : WHERE - 서브쿼리
2. 조회되는 행, 컬럼의 개수 : 복수행, 단일 컬럼
3. 메인쿼리의 컬럼을 서브쿼리에서 사용 유무 : 비상호연관 서브쿼리
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
            FROM emp
            WHERE ename = 'SMITH'
            OR ename = 'ALLEN');
sub 1 실습
SELECT count(*)
FROM emp
WHERE sal >= (SELECT AVG(sal)  
                FROM emp);
 
sub 2 실습
SELECT *
FROM emp
WHERE sal >= (SELECT AVG(sal)  
                FROM emp);       
                
sub 3 실습          
SELECT *
FROM emp
WHERE deptno ALL (SELECT deptno
            FROM emp
            WHERE ename = 'SMITH'
            OR ename = 'WARD');       



    
    








