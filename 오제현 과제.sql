sub7]
SELECT c.cid, c.cnm, y.pid, p.pnm, y.day, y.cnt
FROM customer c, cycle y, product p
WHERE y.cid = c.cid AND y.pid = p.pid
AND y.cid = 1
AND y.pid IN ( SELECT pid
                FROM cycle
                WHERE cid =2);

sub10]
SELECT *
FROM product
WHERE NOT EXISTS (SELECT *
                FROM cycle
                WHERE cid = 1 
                AND pid = product.pid);

        
