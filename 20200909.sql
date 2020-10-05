날짜 관련된 함수
TO_CHAR 날짜 ==> 문자
TO_DATE 문자 ==> 날짜

날짜 ==> 문자 ==> 날짜
문자 ==> 날짜 ==> 문자

SYSDATE(날짜)를 이용하여 현재 월의 1일자 날짜로 변경하기
NULL 관련 함수 - NULL과 관련된 연산의 결과는 NULL
총 4가지 존재, 다 외우진 않아도 괜찮음. 본인이 편한 함수로 하나 정해서 사용 방법을 숙지.

1. NVL(exprl, expre2)
    if(expr1 == null)
        System.out.println(expr2);
    else
        System.out.println(expr1);

2. NVL2(expr1, expr2, expr3)
    if(expr1 != null)
        System.out.println(expr2);
    else
        System.out.println(expr3);
        
3. NULLIF(expr1, expr2)
    if(expr1 == expr2)
    System.out.println(NULL);
    else
    System.out.println(expr1);

함수의 인자 개수가 정해지지 않고 유동적으로 변경이 가능한 인자 : 가변인자

4. coalesce(expr1, expr2, expr3 ....) : coalesce의 인자중 가장 처음으로 등장하는 NULL이 아닌 인자를 반환
    if(expr1 != NULL)
        System.out.println(expr1)
    else
        coalesce(expr2, expr3 ....)

coalesce(null, null, 5, 4)
 ==> coalesce(null, 5, 4)
     ==> coalesce(5, 4)
        ==> System.out.println(5);

comm 컬럼이 NULL일때 0으로 변경하여 sal 컬럼과 합계를 구한다
SELECT empno, ename,  mgr, 
        sal + NVL(comm, 0) mgr,
        sal + NVL2(comm, comm, 0) nv12_sum,
        NVL2(comm, sal+comm, sal) nv12_sum2,
        NULLIF(sal, sal) nullif,
        NULLIF(sal, 5000) nullif_sal,
        sal + COALESCE(comm, 0) coalesce_sum,
        COALESCE(sal + comm, sal) coalesce_sum2
FROM emp;

fn4] mgr컬럼의 값이 NULL일때 9999로 표현하고, NULL이 아니면 원본 값 그대로 사용
NVL, NVL2, COALESCE

SELECT empno, ename, mgr, 
NVL(mgr, 9999) mgr_n,
NVL(mgr, 9999) mgr_n_1,
COALESCE(mgr, 9999) mgr_n_2
FROM emp;

fn5]
SELECT userid, usernm, reg_dt,
NVL(reg_dt, SYSDATE) n_reg_dt
FROM users
WHERE userid != 'brown'

조건 : condition 
java 조건 체크 : if, switch

    if(조건)
        실행할 문장
    else if(조건)
    실행할 문장
    else
    실행할 문장

SQL : CASE 절
  
CASE
    WHEN 조건 THEN 반환할 문장
    WHEN 조건2 THEN 반환할 문장
    ELSE 반환할 문장
END
    
emp 테이블에서 job 컬럼의 값이 
    'SALESMAN'이면 sal 값에 5%를 인상한 급여를 반환 sal * 1.05
    'MANAGER'이면 sal 값에 10%를 인상한 급여를 반환 sal * 1.10
    'PRESIDENT'이면 sal 값에 20%를 인상한 급여를 반환 sal * 1.20
    그밖의 직군('CLERK', 'ANALYST')은 sal 값 그대로 반환
    
    
CASE절을 이용 새롭게 계산한 sal_b   
SMITH : 800, ALLEN : 1680
SELECT ename, job, sal, 
        CASE
            WHEN job = 'SALESMAN' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.10
            WHEN job = 'PRESIDENT' THEN sal * 1.20
            ELSE sal 
        END sal_b
FROM emp;

가변인자
DECODE(col|expr1,
                search1, return1,
                search2, return2,
                search3, return3,
                [default])
첫번째 컬럼이 두번째 컬럼(search1)과 같으면 세번째 컬럼(return1)을 리턴
첫번째 컬럼이 두번째 컬럼(search2)과 같으면 다섯번째 컬럼(return2)을 리턴
첫번째 컬럼이 두번째 컬럼(search3)과 같으면 일곱번째 컬럼(return3)을 리턴
일치하는 값이 없을 때는 default 리턴
    
SELECT ename, job, sal, 
        CASE
            WHEN job = 'SALESMAN' THEN sal * 1.05
            WHEN job = 'MANAGER' THEN sal * 1.10
            WHEN job = 'PRESIDENT' THEN sal * 1.20
            ELSE sal 
        END sal_b

 FROM emp;
         DECODE(job, 'SALESMAN', sal * 1.05,
                    'MANAGER', sal * 1.10,
                    'PRESIDENT', sal * 1.20, 
                    sal)sal_decode
 CASE, DECODE 둘다 조건 비교시 사용
 차이점 : DECODE의 경우 값비교가 = (EQUAL)에 대해서만 가능
                복수조건은 DECODE를 중첩하여 표현
            CASE는 부등호 사용가능, 복수개의 조건 사용가능
            (CASE
                WHEN sal > 3000 AND job = 'MANAGER'

실습 cond1
SELECT empno, ename, deptno,
CASE
    WHEN deptno = 10 THEN 'ACCOUNTUNG'
    WHEN deptno = 20 THEN 'RESEARCH'
    WHEN deptno = 30 THEN 'SALES'
    WHEN deptno = 40 THEN 'OPERATIONS'
ELSE 'DDIT'
END dname,
DECODE(deptno, 10, 'ACCOUNTUNG', 20, 'RESEARCH',
30, 'SALES', 40, 'OPERATIONS', 'DDIT') dname2
FROM emp; 
   
cond2]

나머지연산: java %, SQL mod 함수

SELECT empno, ename, hiredate,
CASE
WHEN MOD(TO_CHAR(hiredate, 'YYYY'), 2) = 
MOD(TO_CHAR(SYSDATE, 'YYYY'),1) THEN '건강검진 대상자'
ELSE '건강검진 비대상자'
END contact_to_doctor
FROM emp;


cond3]

SELECT userid, usernm, reg_dt,
CASE
WHEN MOD(TO_CHAR(reg_dt, '2020'), 2) = 
MOD(TO_CHAR(SYSDATE, 'YYYY'), 2) THEN '건강검진 대상자'
ELSE '건강검진 비대상자'
END contact_to_doctor
FROM users;
