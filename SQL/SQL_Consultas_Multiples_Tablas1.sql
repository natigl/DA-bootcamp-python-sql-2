
USE Northwind;

/* 1pedidos por empresa en UK:
Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos con la que podamos conocer 
cuántos pedidos ha realizado cada empresa cliente de UK. Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.*/

/*EJERCICIOS CONSULTAS EN MULTIPLES TABLAS 1*/

SELECT customers.customer_id AS Identifcador, customers.company_name AS NombreEmpresa , COUNT(orders.customer_id) AS NumeroPedidos
FROM customers INNER JOIN orders
ON customers.customer_id = orders.customer_id 
WHERE orders.ship_country = 'UK'
GROUP BY orders.customer_id;


/*2.Productos pedidos por empresa en UK por año:
Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y han decidido pedirnos una serie de consultas adicionales. 
La primera de ellas consiste en una query que nos sirva para conocer cuántos objetos ha pedido cada empresa cliente de UK durante cada año. Nos piden concretamente 
conocer el nombre de la empresa, el año, y la cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.
El resultado será una tabla similar a esta:*/

SELECT customers.company_name AS NombreEmpresa, YEAR(orders.order_date) AS Año, SUM(order_details.quantity) AS NumObjetos
FROM orders INNER JOIN order_details
ON orders.order_id = order_details.order_id
INNER JOIN customers
ON customers.customer_id = orders.customer_id
WHERE orders.ship_country = 'UK'
GROUP BY customers.company_name, YEAR(orders.order_date)
ORDER BY customers.company_name;


/* 3. Mejorad la query anterior:
Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la cantidad de dinero que han pedido por esa cantidad de objetos, 
teniendo en cuenta los descuentos, etc. Ojo que los descuentos en nuestra tabla nos salen en porcentajes, 15% nos sale como 0.15.
La tabla resultante será:*/

#####   DA FALLLOOOOOOOOOO  ######

SELECT customers.company_name AS NombreEmpresa, YEAR(orders.order_date) AS Año, SUM(order_details.quantity) AS NumObjetos, (order_details.unit_price*order_details.quantity) - ((order_details.unit_price*order_details.quantity)*order_details.discount) AS Dinero_total
FROM orders INNER JOIN order_details
ON orders.order_id = order_details.order_id
INNER JOIN customers
ON customers.customer_id = orders.customer_id
WHERE orders.ship_country = 'UK'
GROUP BY customers.company_name, YEAR(orders.order_date)
ORDER BY customers.company_name;


/*4.BONUS: Pedidos que han realizado cada compañía y su fecha:
Después de estas solicitudes desde UK y gracias a la utilidad de los resultados que se han obtenido, desde la central nos han pedido una consulta que indique el nombre de cada compañia cliente junto con cada pedido que han realizado y su fecha.
El resultado deberá ser:*/




/*BONUS: Tipos de producto vendidos:
Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías, nombre de la categoría y el nombre del producto, y el total de dinero por el que se ha vendido cada tipo de producto (teniendo en cuenta los descuentos).
Pista Necesitaréis usar 3 joins*/

