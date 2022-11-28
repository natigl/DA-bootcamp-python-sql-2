/*EJERCICIOS CONSULTAS EN MULTIPLES TABLAS 2*/

USE Northwind;


/*1.Qué empresas tenemos en la BBDD Northwind:
Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre de todas las empresas cliente, los ID de sus pedidos y las fechas.
Los resultados deberán similares a la siguiente tabla:*/

SELECT orders.order_id AS OrderID, customers.company_name AS CompanyName, orders.order_date AS OrderDate
FROM orders
LEFT JOIN customers
ON orders.customer_id = customers.customer_id
ORDER BY company_name;

/*2.Pedidos por cliente de UK:
Desde la oficina de Reino Unido (UK) nos solicitan información acerca del número de pedidos que ha realizado cada cliente del propio Reino Unido de cara a conocerlos mejor y poder adaptarse al mercado actual. Especificamente nos piden el nombre de cada compañía cliente junto con el número de pedidos.
La tabla resultante será:*/

SELECT customers.company_name AS NombreCliente, COUNT(orders.order_id) AS NumeroPedidos
FROM customers
LEFT JOIN orders
ON orders.customer_id = customers.customer_id
WHERE customers.country = "UK"
GROUP BY customers.customer_id;

/*3.Empresas de UK y sus pedidos:
También nos han pedido que obtengamos todos los nombres de las empresas cliente de Reino Unido (tengan pedidos o no) junto con los ID de todos los pedidos que han realizado, el nombre de contacto de cada empresa y la fecha del pedido.
Los resultados de la query deberán ser:*/

SELECT customers.company_name AS NombreCliente, customers.contact_name AS NombreContacto, orders.order_date AS FechaPedido, orders.order_id AS OrderID
FROM customers
LEFT JOIN orders
ON orders.order_id = customers.customer_id
WHERE customers.country = "UK"
GROUP BY company_name, order_id;

/*4Empleadas que sean de la misma ciudad:
Ejercicio de SELF JOIN: Desde recursos humanos nos piden realizar una consulta que muestre por pantalla los datos de todas las empleadas y sus supervisoras. Concretamente nos piden: la ubicación, nombre, y apellido tanto de las empleadas como de las jefas. Investiga el resultado, ¿sabes decir quién es el director?
La tabla resultado de la query deberá ser:* PARA DISTINGUIR ENTRE EMPLEADAS Y TRABAJADORAS, TENDRIAMOS QUE UTILIZAR LA COLUMNA TITLE.*/

SELECT A.city AS CityEmployee, A.first_name AS NombreEmpleada, A.last_name AS NombreEmpleada, B.city AS CityBoss, B.first_name AS NombreBoss, B.last_name AS ApellidoBoss
FROM employees AS A, employees AS B
WHERE A.employee_id <> B.employee_id  
AND A.city = B.city

