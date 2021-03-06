
| : OR
{} : 여러개가 반복
[] : 옵션- 있을 수도 있고, 없을 수도 있다

==SELECT 쿼리문법 ==
SELECT * | { column | expression [alias] }
FROM 테이블 이름;

SQL 실행 방법
1. 실행하려고 하는 SQL을 선택후 Ctrl + enter;
2. 실행하려는 sql 구문에 커서를 위치시키고 ctrl + enter;
SELECT *
FROM emp;

select empno, ename
from emp;

SELECT *
FROM dept;



자바언어와 다른점
SQL의 경우 KEY워드의 대소문자를 구분하지 않는다

select*
from dept

[ 실습 select1 ]

SELECT *
FROM lprod;

SELECT buyer_id, buyer_name
FROM buyer;

SELECT *
FROM cart;

SELECT mem_id, mem_pass, mem_name
FROM member;


연산

SELECT 쿼리는 테이블의 데이터에 영향을 주지 않는다.
SELECT 쿼리를 잘못 작성 했다고 해서 데이터가 망가지지 않음.

SELECT ename, sal, sal + 100
FROM emp;

데이터 타입
DESC 테이블명 (테이블 구조를 확인)
DESC emp;


SELECT *
FROM emp;

숫자 + 숫자 = 숫자값
5 + 6 = 11

문자 + 문자 = 문자 ==> java에서는 문자열을 이은, 문자열 결합으로 처리

수학적으로 정의도니 개념이 아님
오라클에서 정의한 개념
날짜에다가 숫자를 일수로 생각하여 더하고 뺀 일자가 결과가 된다.
날짜 + 숫자 = 날짜

hiredate에서 365일 미래의 일자

=중요하지는 않음=
별칭 : 칼럼, expression에 새로운 이름을 부여 (별청을 부여할 때 주의점은 공백이나 특수문자가 있는경우 더블 쿼테이션으로 감싸줘야한다)
컬럼 | expression [AS] [컬럼명]
SELECT ename AS emp_name, hiredate,
     hiredate +365 after_1year, hiredate -365 before_1year
FROM emp;

별청을 부여할 때 주의점
1.공백이나 특수문자가 있는경우 더블 쿼테이션으로 감싸줘야한다
2.별칭명은 기본적으로 대문자로 취급되지만 소문자로 지정하고 싶으면 더블 쿼테이션을 적용한다.

SELECT ename "emp name", empno emp_no, empno "emp_no2"
FROM emp;

자바에서 문자열 : "Hello, World"
SQL에서 문자열 : 'Hello, World'

==매우중요==
NULL : 아직 모르는 값
숫자 타입 : 0이랑 NULL은 다르다
문자 타입 : '' 공백문자와 NULL은 다르다

*** NULL을 포함한 연산의 결과는 항상 NULL
5 * NULL = NULL
800 + NULL = NULL

emp 테이블 컬럼 정리
1. empno : 사원번호
2. ename : 사원이름
3. job : (담당)업무
4. mgr : 매니저 사원번호
5. hiredate : 입사일자
6. sal : 급여
7. comm : 성과금
8. deptno : 부서번호


emp 테이블에서 NULL값을 확인

SELECT ename, sal, comm, sal + comm AS total_sal
FROM emp;

SELECT userid, usernm, reg_dt,  reg_dt +5
FROM users;

column alias 실습2

SELECT prod_id "id", prod_name "name"
FROM prod

SELECT lprod_gu "gu", lprod_nm "nm"
FROM lprod

SELECT buyer_id "바이어아이디", buyer_name "이름"
FROM buyer

select2]

literal : 값 자체
literal 표기법 : 값을 표현하는 방법

숫자 10 이라는 값을
java : int a = 10;
sql : SELECT empno, 10
FROM emp;

문자 Hello, World 라는 문자 값을
java : String str = "Hello, World";

sql : SELECT empno e, 'hello, World' h
FROM emp;

날짜 2020년 9월 2일이라는 날짜 값
java : primitive type : 8개 - in, long, shot, byte, char, boolean, float, double
문자열==> String class
날짜==> Date class
slq : ???나중에

문자열 연산
java + ==> 결합 연산
"Hello," + "World" ==> "Hello,World"
"Hello," - "World" : 연산자가 정의되어 있지 않다
"Hello," * "World" : 연산자가 정의되어 있지 않다

python
"Hello," * 3 ==> "Hello,Hello,Hello,"
sql ||, CONCAT 함수 ==> 결합 연산
emp테이블의 ename, job 커럼이 문자열

ename || ' ' || job
SELECT ename || ' ' || job
FROM emp;

CONCAT(문자열1, 문자열2) : 문자열1과 문자열2를 합쳐서 결과값을 반환해준다

    SELECT ename || ' ' || job, 
    CONCAT( CONCAT(ename,  ' '), job)
    FROM emp;       

USER_TABLES : 오라클에서 관리하는 테이블(뷰)
              접속한 사용자가 보유하고 있는 테이블 정보를 관리
              
     SELECT table_name
     FROM user_tables;
     
     
     SELECT  CONCAT('SELECT * FROM ', table_name || ';' ) QUERY
    FROM user_tables;
    
    테이블의 구조(컬럼명, 데이터타입) 확인하는 방법
    1. DESC 테이블명 : DESCRIBE
    2. 컬러 이름만 알 수 있는 방법(데이터 타입은 유추)
    SELECT *
    FROM 테이블명;
    3.툴에서 제공하는 메뉴 이용
    접속정보 - 테이블 -확인하고자하는 테이블 클릭
    
    SELECT 절 : 컬럼을제한
    
    ******매우중요******
    WHERE 절 : 조건에 만족하는 행들만 조회되도록 제한 (행을 제한)
    ex ) sal 컬럼의 값이 1500보다 큰 사람들만 조회 ==> 7명
    WHERE절에 기술된 조건을 참 (TRUE)으로 만족하는 행들만 조회가 된다
    
    SELECT userid, usernm, alias, reg_dt 
    FROM users
    WHERE 1=1;
    
    조건 연산자
    동등 비교(equal)
    java : int a = 5;
    primitive typea : ==  ex ) a == 5,
    object : "+".equals("_")
    sql : sal = 1500
    not equal
    java : !=
    sql : !=, <>
    
    대입연산자
    java:          =
    pl/sql :     :=
    
    users테이블에는 총 5명의 캐릭터가 등록이 되어있는데
    그중에서 userid 컬럼의 값이 'brown'인 행만 조회되도록
    WHERE절에 조건을 기술
    
    
    SELECT userid, usernm, alias, reg_dt 
    FROM users
    WHERE userid = 'brown';
    
    SQL은 대소문자를 가리지 않는다. : 키워드, 테이블명, 컬럼명
    데이터는 대소문자를 가린다

    emp 테이블에서 부서번호(deptno)가 30보다 크거나 같은 사원들만 조회
    컬럼은 모든 컬럼 조회
    
    SELECT *
    FROM emp
    WHERE deptno >= 30
    
    날짜 비교
    1982년 01월 01일 이후에 입사한 사람들 만 조회(이름, 입사일자)
    dhiredate type : date
    문자 리터럴 표기법: '문자열'
    숫자 리터럴 표기법: 숫자
    날짜 리터럴 표기법: 항상 정해진 표기법이 아니다.
                     서버 설정마다 다르다. yy/mm/dd
                     서양권: mm/dd/yy
    결론: 문자열 형태로 표현하는 것이 가능하나 서버 설정마다 다르게 해석할 수 있기 때문에 서버 설정과 관계없이 동일하게
        해석할 수 있는 방법으로 사용
        TO_DATE('날짜문자열',' 날짜문자열형식')
        : 문자열 ==> 날짜 타입으로 변경
    
    년도 : yyyy
    월 : mm
    일 :dd
    SELECT ename, hiredate
    FROM emp
    WHERE hiredate >=TO_DATE('1982/01/01', 'yyyy/mm/dd');
    
    BETWEEN AND 연산자
    WHERE 비교대상 BETWEEN 시작값 AND 종료값;
    비교대상의 값이 시작값과 종료값 사이에 있을 때 참(TRUE)으로 인식
    (시작값과, 종료값을 포함 비교대상 >= 시작값, 비교대상 <= 종료값)
    
    emp테이블에서 sal 컬럼의 값이 1000이상 2000이하인 사원들의 모든 컬럼을 조회
    SELECT *
    FROM emp
    WHERE sal BETWEEN 1000 AND 2000;
    
    비교연산자를 이용한 풀이
    SELECT *
    FROM emp
    WHERE sal >= 1000 AND sal <= 2000;

    조건에 맞는 데이터 조회하기 실습 where1
    
    SELECT ename, hiredate
    FROM emp
    WHERE hiredate BETWEEN TO_DATE('1982/01/01', 'yyyy/mm/dd')  
    AND TO_DATE('1983/01/01', 'yyyy/mm/dd');
    
    실습 where2
    
    SELECT ename, hiredate
    FROM emp
    WHERE hiredate >=  TO_DATE('1982/01/01', 'yyyy/mm/dd') 
    AND hiredate  <= TO_DATE('1983/01/01', 'yyyy/mm/dd')
    
    IN 연산자
    특정 값이 집합(여러개의 값을 포함)에 포함되어 있는지 여부를 확인
    
    WHERE 비교대상 IN (값1, 값2....)
    ==> 비교대상이 값1 이거나(=)
        비교대상이 값2 이거나(=)
    
    WHERE 비교대성 = 값1 
       OR 비교대상 = 값2
    
    emp 테이블에서 사원이 10번부서 혹은 30번부서에 속한 사원들 정보를 조회(모든 컬럼)
    SELECT *
    FROM emp
    WHERE deptno IN (10, 30);
      
    
    AND ==> 그리고
    OR ==> 또는
    
    조건1 AND 조건2 ==> 조건1과 조건2를 동시에 만족
    조건1 OR 조건2 ==>  조건1을 만족하거나, 조건2를 만족하거나
                       조건1과 조건2를 동시 만족하거나
    
    SELECT *
    FROM emp
    WHERE deptno = 10
       OR deptno = 30;
       
    SELECT userid, usernm, alias
    FROM users
    WHERE userid IN ('brown', 'cony', 'sally');
    
    SELECT userid 아이디,  usernm 이름, alias 별명
    FROM users
    WHERE userid = 'brown' OR userid = 'cony' OR userid = 'sally';
    WHERE 절 : 스프레드 시트
               - filter : 전체 데이터중에서 내가 원하는 행만 나오도록 제한
               비교 연산 <, >, =, !=, <>, <=, >=
               
    BETWEEN AND 
    IN
    연산자를 배울 때 (복습할 때) 기억할 부분은 해당 연산자 x항 연산자 인지하자    
    
    1           +           5
 피연산자      연산자      피연산자
 
 a++ : 단항연산자
 
 int a = b > 5 ? 10 : 20;
 
 BETWEEN AND : 비교대상 BETWEEN 시자값 AND 종료값
 IN :   비교대상 IN (값1, 값2...)
 LIKE : 비교대상 LIKE '매칭문자열 % _ '
 
 WHERE BETWEEN 30 AND 50;
 
 SELECT *
 FROM emp
 WHERE 10 BETWEEN 10 AND 50;