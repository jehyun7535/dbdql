많이 쓰이는 함수, 잘 알아두자
(개념 적으로 혼돈하지 말고 잘 정리하자 - SELECT 절에 올 수 있는 컬럼에 대해 잘 정리)

그룹함수 : 여러개의 행을 입력으로 받아 하나의 행으로 결과를 반환하는 함수

오라클 제공 그룹함수
MIN(컬림|익스프레션) : 그룹중에 최소값을 반환
MAX(컬럼|익스프레션) : 그룹중에 최대값을 반환
AVG(컬럼|익스프레션) : 그룹의 평균값을 반환
SUM(컬름|익스프레션) : 그룹의 합계값을 반환
COUNT(컬럼 | 익스프레션 | * ) : 그룹핑된 행의 갯수

SELECT 행을 묶을 컬럼, 그룹함수
FROM 테이블명
[WHERE]
GROUP BY 행을 묶을 컬럼;

SELECT *
FROM emp;
ORDER BY deptno;

그룹함수에서 많이 어려워 하는 부분
SELECT 절에 기술할수 있는 컬럼의 구분 : GROUP BY 절에 나오지 않은 컬럼이 SELECT 절에 나오면 에러

SELECT deptno, MIN(ename), COUNT(*), MIN(sal), MAX(sal), SUM(sal), AVG(sal)
FROM emp
GROUP BY deptno, ename;

전체 직원(모든 행을 대상으로) 중에 가장 많은 급여를 받는 사람의 값
: 전체 행을 대상으로 그룹핑 할 경우 GROUP BY 절을 기술하지 않는다

SELECT deptno, MAX(sal)
FROM emp
GROUP BY deptno;

전체직원중에 가장 큰 급여 값을 알수는 있지만 해당 급여를 받는 사람이 누군지는 그룹 함수만
이용 해서는 구할수가 없다.
emp 테이블 가장 큰 급여를 받는 사람의 값이 5000인 것은 알지만 해당 사원이 누구인지는
그룹함수만 사용해서는 누군지 식별할 수 없다
    ==> 추후 진행
SELECT MAS(sal)
FROM emp;


COUNT 함수 * 인자
* : 행의 개수를 반환
컬럼 | 익스프레션 : NULL값이 아닌 행의 개수

SELECT COUNT(*), COUNT(mgr), COUNT(comm)
FROM emp;

그룹함수의 특징 : NULL값을 무시
NULL 연산의 특징 : 결과 항상 NULL이다 

SELECT SUM(sal + comm), SUM(sal) + SUM(comm)
FROM emp;

그룹함수 특징2 : 그룹화 관련없는 상수들은 SELECT 절에 기술할 수 있다
SELECT deptno, SYSDATE, 'TEST', 1, COUNT(*)
FROM emp
GROUP BY deptno;

그룹함수 특징3 :
    SINGLE ROW 함수의 경우 WHERE 에 기술하는 것이 가능하다
    ex : SELECT *
         FROM emp
         WHERE enamme = UPPER('smith');
         
         그룹함수의 경우 WHERE에서 사용하는 것이 불가능 하다
         ==> HAVING 절에서 그룹함수에 대한 조건을 기술하여 행을 제한 할 수 있다
         
         그룹함수는 WHERE절에 사용 불가
         SELECT deptno, COUNT(*)
         FROM emp
         WHERE COUNT(*) >= 5
         GROUP BY deptno;
        
      질문1]  그룹함수에 대한 행 제한은 HAVING 절에 사용 못하냐?
        GROUP BY에 대상이 되는 행들을 제한할 떄 WHERE 절을 사용
        
        SELECT deptno, COUNT(*)
         FROM emp
         WHERE sal > 1000
         GROUP BY deptno;

grp1

SELECT MAX(sal) MAX_SAL, MIN(sal) MIN_SAL,  TRUNC(AVG(sal),2) AVG_SAL, SUM(sal), COUNT(sal) COUNT_SAL
, COUNT(mgr) COUNT_MGR, COUNT(*) COUNT_ALL
  FROM emp;
  
grp2

SELECT deptno, MAX(sal) MAX_SAL, MIN(sal) MIN_SAL,  TRUNC(AVG(sal),2) AVG_SAL, SUM(sal), COUNT(sal) COUNT_SAL
, COUNT(mgr) COUNT_MGR, COUNT(*) COUNT_ALL
FROM emp
GROUP BY deptno;

grp3

SELECT 
CASE
    WHEN deptno = 10 THEN 'ACCOUNTUNG'
    WHEN deptno = 20 THEN 'RESEARCH'
    WHEN deptno = 30 THEN 'SALES'
    ELSE 'DDIT'
    END dname,
    MAX(sal) MAX_SAL, MIN(sal) MIN_SAL,  TRUNC(AVG(sal),2) AVG_SAL, SUM(sal), COUNT(sal) COUNT_SAL
    ,COUNT(mgr) COUNT_MGR, COUNT(*) COUNT_ALL
FROM emp
GROUP BY deptno
ORDER BY deptno;

grp4
SELECT TO_CHAR(hiredate, 'YYYYMM') hire_yyyymm, count(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM');


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


******WHERE + JION SELECT SQL의 모든 것******
JOIN : 다른 테이블과 연결하여 데이터를 확장하는 문법
        . 컬럼을 확장
** 행을 확장 - 집합연산자(UNION, INTERSECT, MINUS)

JOIN 문법 구분
  1. ANSI - SQL
        : RDBMS에서 사용하는 SQL 표준
          ( 표준을 잘 지킨 모든 RDMBS-MYSQL, MSSQL, POSTGRESQL... 에서 실행가능
  2. ORACLE - SQL
        : ORACLE 사만의 고유 문법
        
회사에서 요구하는 형태로 따라가자
7(oracle) : 3(ansi)

NATURAL JOIN : 조인하고자 하는 테이블의 컬럼명이 같은 컬럼끼리 연결
               컬럼의 값이 같은 행들끼리 연결 
    ANSI-SQL
    
    SELECT 컬럼
    FROM 테이블명 NATURAL JOIN 테이블명;

조인 컬럼에 테이블 한정자를 붙이면 NATURAL JOIN에서는 에러로 취급  
emp.deptno (x) ==> deptno (O)

컬럼명이 한쪽 테이블에만 존재할 경우 테이블 한정자를 붙이지 않아도 상관 없다
emp.empno (o), empno (o)

SELECT emp.empno, deptno, dname
FROM emp NATURAL JOIN dept;

NATURAL JOIN을 ORACLE 문법으로
1. FROM 절에 조인할 테이블을 나열한(,)
2. WHERE절에 테이블 조인 조건을 기술한다
  
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

ORA-00918: column ambiguously defined
컬럼이 여러개의 테이블에 동시에 존재하는 상황에서 테이블
한정자를 붙이지 않아서 오라클 입장에서는 해당 컬럼이 어떤 테이블의 컬럼인지
알수가 없을 때 발생. deptno 컬럼은 emp, dept 테이블 양쪽 모두에 존재한다.

SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

인라인뷰 별칭처럼, 테이블 별칭을 부여하는게 가능
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT *
FROM emp e, dept d
WHERE e.deptno = d.deptno;

ANSL-SQL : JOIN WITH USING
    조인 하려는 테이블간 같은 이름의 컬럼이 2개 이상일 때
    하나의 컬럼으로만 조인을 하고 싶을 때 사용
SELECT *
FROM emp JOIN dept USING (deptno);
    
    ORACLE 문법
    SELECT *
    FROM emp, dept
    WHERE emp.deptno = dept.deptno;
    
    ANSI-SQL : JOIN WITH ON - 조인 조건을 개발자가 직접 기술
               NATURAL JOIN, JOIN WITH USING 절을 JOIN WITH ON 절을 통해 표현 가능
               
SELECT *
FROM emp JOIN dept on(emp.deptno = dept.deptno)
WHERE emp.deptno IN (20, 30);

ORACLE    
SELECT *
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.deptno IN (20, 30);

논리적인 형태에 따른 조인 구분
1. SELF JOIN  : 조인하는 테이블이 서로 같은 경우

SELECT e.ename, e.ename, e.mgr, m.ename
FROM emp e JOIN emp m ON ( e.mgr = m.empno);

ORACLE 문법   
SELECT e.ename, e.ename, e.mgr, m.ename
FROM emp e, emp m
WHERE e.mgr = m.empno;

KING의 경우 mgr 컬럼의 값이 NULL 이기 때문에 e.mgr = m.empno 조건을 충족 시키지 못함
그래서 조인 실패해서 14건중 13건에 데이터만 조회
    
2. NONEQUI JOIN : 조인 조건이 =이 아닌 조인
SELECT *
FROM emp, dept
WHERE emp.empno=7369
AND emp.deptno != dept.deptno;
    
sal를 이용하여 등급을 구하기
SELECT *
FROM salgrade;

empno, ename, sal, 등급(grade)
    
SELECT empno, ename, sal, grade
FROM emp, salgrade
WHERE sal BETWEEN losal AND hisal;

위의 SQL을 ANSI-SQL로 변경
SELECT empno, ename, sal, grade
FROM emp JOIN salgrade ON ( sal >= losal AND sal <= hisal);
    
join0
SELECT *
FROM dept;

SELECT *
FROM emp;

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
AND d.dname = 'RESEARCH'
ORDER BY deptno;