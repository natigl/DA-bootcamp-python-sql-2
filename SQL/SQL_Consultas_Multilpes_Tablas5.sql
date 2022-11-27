/*1.
Extraed los pedidos con el máximo "order_date" para cada empleado.
Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado.
Para eso nos pide que lo hagamos con una query correlacionada.*/

USE northwind;

SELECT order_id AS OrderID, customer_id AS Customer_id, employee_id AS EmployeeID, order_date AS ODATE, required_date AS RDATE
FROM orders AS f
WHERE f.order_date = (
					SELECT MAX(order_date)
                    FROM orders AS f2
                    WHERE f.employee_id = f2.employee_id
               
/*2.
Extraed el precio unitario máximo (unit_price) de cada producto vendido.
Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario.
De nuevo lo tendréis que hacer con queries correlacionadas. DA FALLO PERO EJECUTADA EN OTRO LUGAR NO LO DA */

SELECT unit_price AS Max_Unit_Price_Sold, product_id 
FROM order_details AS o1
WHERE o1.unit_price ( SELECT MAX(unit_price)
					  FROM orders AS o2
                      WHERE o1.unit_price = o2.unit_price )

/*3.
Ciudades que empiezan con "A" o "B".
Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquelas compañias que están afincadas en ciudades que empiezan por "A" o "B".
Necesita que le devolvamos la ciudad, el nombre de la compañia y el nombre de contacto.*/

SELECT city, company_name AS CompanyName, contact_name AS ContactName
FROM customers
WHERE city LIKE 'A%' OR city LIKE 'B%'
ORDER BY city;

/*4.
Número de pedidos que han hecho en las ciudades que empiezan con L.
En este caso, nuestro objetivo es devolver los mismos campos que en la query anterior el número de total de pedidos que han hecho todas las ciudades que empiezan por "L".*/

#FALTAAAAA, NO SALEEE, Dudando si joins o subconsulta
    
SELECT city AS Ciudad, company_name AS Empresa, contact_name AS persona_contacto, COUNT(orders.order_id) AS numero_pedidos
FROM customers AS c
WHERE city LIKE 'L%' 
ORDER BY numero_pedidos;


/*5.
Todos los clientes cuyo "contact_title" no incluya "Sales".
Nuestro objetivo es extraer los clientes que no tienen el contacto "Sales" en su "contact_title".
Extraer el nombre de contacto, su posisión (contact_title) y el nombre de la compañia.*/

SELECT contact_name, contact_title, company_name
FROM customers
WHERE contact_title NOT LIKE "S%";


/*6. Todos los clientes que no tengan una "A" en segunda posición en su nombre.
Devolved unicamente el nombre de contacto.*/

SELECT contact_name
FROM customers
WHERE contact_name NOT LIKE '_a_%'
ORDER BY contact_name;

/**/