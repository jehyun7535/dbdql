SELECT *
FROM prod;

SELECT *
FROM lprod;

SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
ORDER BY deptno;


데이터결합 실습 join1
SELECT lprod_gu, lprod_nm, prod_id, prod_name
FROM prod , lprod 
WHERE prod.prod_lgu = lprod.lprod_gu;

실습 join2
SELECT buyer_id, buyer_name, prod_id, prod_name
FROM prod , buyer
WHERE prod.prod_buyer = buyer.buyer_id;

실습 join3
SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM prod, cart, member
WHERE member.mem_id = cart.cart_member AND 
cart.cart_prod = prod.prod_id;

ANSI-SQL
테이블 jOIN 테이블 ON ()
      join 테이블 ON ()

SELECT mem_id, mem_name, prod_id, prod_name, cart_qty
FROM member JOIN cart ON(member.mem_id = cart.cart_member)
JOIN prod ON(cart.cart_prod = prod.prod_id);
