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

OUTERJOIN5]
SELECT p.pid, p.pnm, :cid cid, NVL(a.cnm, 'brown'), NVL(c.day, 0) day,
NVL(c.cnt, 0) cnt
FROM cycle c, product p, customer a
WHERE p.pid = c.pid(+)
AND a.cid(+) = c.cid
AND c.cid(+) = :cid;

SELECT *
FROM customer;

SELECT *
FROM cycle;

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
WHERE deptno IN (SELECT deptno
            FROM emp
            WHERE ename = 'SMITH'
            OR ename = 'WARD'); 

복습
NOT IN 연산자와 NULL

pair wise 개념 : 순서쌍, 두가지 조건을 동시에 만족시키는 데이터를 조회 할때 사용
                AND 논리연산자와 결과 값이 다를 수 있다(아래 예시 참조)
SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499, 7782));


SCALAR SUBQUERY : SELECT 절에 기술된 서브쿼리
                    하나의 컬럼
***스칼라 서브 쿼리는 하나의 행, 하나의 컬럼을 조회하는 쿼리 이어야한다
SELECT dummy, (SELECT SYSDATE
                FROM dual)
FROM dual;

스칼라 서브쿼리가 복수개의 행(4개), 단일 컬럼을 조회 ==> 에러
SELECT empno, ename, deptno, (SELECT dname FROM dept)
FROM emp;

emp 테이블과 스칼라 서브 쿼리를 이용하여 부서명 가져오기
기존 : emp 테이블과 dept 테이블을 조인하여 컬럼을 확장

SELECT empno, ename, deptno, 
(SELECT dname FROM dept WHERE deptno = emp.deptno)
FROM emp;

상호연관 서브쿼리 : 메인 쿼리의 컬럼을 서브쿼리에서 사용한 서브쿼리 
                - 서브쿼리만 단독으로 실행하는 것이 불가능 하다
                - 메인쿼리와 서브 쿼리의 실행 순서가 정해져 있다
                메인쿼리가 항상 먼저 실행된다
비상호연관 서브쿼리 : 메인 쿼리의 컬럼을 서브쿼리에서 사용하지 않은 서브쿼리
                - 서브쿼리만 단독으로 실행되는 것이 가능하다
                - 메인쿼리와 서브 쿼리의 실행 순서가 정해져 있지 않다.
                  메인 => 서브, 서브=> 메인 둘다 가능
SELECT *
FROM dept
WHERE deptno IN (SELECT deptno
                    FROM emp);
