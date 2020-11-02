create database if not exists labor_sql;
use labor_sql;

#1
SELECT distinct maker FROM laptop JOIN product
order by maker;

#2
SELECT name FROM passenger
where passenger.name like '% %' and name not like 'j%';

#3
SELECT DISTINCT maker FROM product JOIN laptop
 where laptop.speed >= 500;

#4
SELECT DISTINCT maker
FROM Product
WHERE (maker=SOME(SELECT maker FROM Product WHERE type='PC'))
AND type='Laptop';

#5
SELECT DISTINCT maker FROM Product pc
WHERE type = 'Printer' OR EXISTS (SELECT * FROM PC
WHERE speed = (SELECT MAX(speed) FROM PC )
OR model = ANY (SELECT model FROM Product WHERE maker = pc.maker)) ;

#6
SELECT DATE_FORMAT (date, '%d.%m.%Y') as new_date FROM income_o WHERE income_o.date;

#7  
SELECT count(type), AVG(Price) AS AvgPrice
FROM product JOIN pc where pc.price >= 800 ;


#8
SELECT maker, sum((SELECT COUNT(*) FROM pc WHERE pc.model = product.model)) AS pc,
  sum((SELECT COUNT(*) FROM laptop WHERE laptop.model = product.model)) as laptop,
  sum((SELECT COUNT(*) FROM printer WHERE printer.model = product.model)) AS printer
FROM product
GROUP BY maker;

#9
select c.country,
(select launched from Ships join Classes x using(class)
where x.country = c.country group by 1 order by count(*) desc, 1 limit 1) year,
(select count(*) from Ships join Classes x using(class)
where x.country = c.country group by launched order by count(*) desc, 1 limit 1) numGuns
from Classes c group by 1;

#10
SELECT model, price 
FROM PC 
WHERE model = (SELECT model 
 FROM Product 
 WHERE maker = 'B' AND 
 type = 'PC'
 )
UNION
SELECT model, price 
FROM Laptop 
WHERE model = (SELECT model 
 FROM Product 
 WHERE maker = 'B' AND 
 type = 'Laptop'
 )
UNION
SELECT model, price 
FROM Printer 
WHERE model = (SELECT model 
 FROM Product 
 WHERE maker = 'B' AND 
 type = 'Printer'
 );
