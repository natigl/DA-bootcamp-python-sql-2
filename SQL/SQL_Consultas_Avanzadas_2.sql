
/* CONSULTAS AVANZADAS 2 */


USE Northwind;


/* 1.Relación entre número de pedidos y máxima carga:
Desde logística nos piden el número de pedidos y la máxima cantidad de carga de entre los mismos (freight) 
que han sido enviados por cada empleado (mostrando el ID de empleado en cada caso).*/

SELECT MAX(freight), employee_id AS Numero_empleado, COUNT(order_id) AS NumPedidos
FROM orders
GROUP BY employee_id; 

/* Si hacemos el select de arriba sin las funciones MAX y COUNT y buscamos por los pedidos de un solo employee, nos devuelve varias filas. Como queremos solo una
fila con calculos especificos, tenemos que poner el group by para agruparlos por el employee_id, y entonces podemos usar funciones MAX y COUNT

SELECT freight, employee_id AS Numero_empleado, order_id AS NumPedidos
FROM orders
WHERE employee_id= 5; 

*/




/* 2. Descartar pedidos sin fecha y ordénalos:
Una vez han revisado los datos de la consulta anterior, nos han pedido afinar un poco más el "disparo". 
En el resultado anterior se han incluido muchos pedidos cuya fecha de envío estaba vacía, por lo que tenemos 
que mejorar la consulta en este aspecto. También nos piden que ordenemos los resultados según el ID de empleado 
para que la visualización sea más sencilla.*/

SELECT MAX(freight), employee_id AS Numero_empleado, COUNT(order_id) AS NumPedidos
FROM orders
WHERE NOT shipped_date = 0000-00-00
GROUP BY employee_id
ORDER BY employee_id;  /*Ordenar por employee_id*/


/*3.Números de pedidos por día:
El siguiente paso en el análisis de los pedidos va a consistir en conocer mejor la distribución de los mismos según las fechas. 
Por lo tanto, tendremos que generar una consulta que nos saque el número de pedidos para cada día, mostrando de manera 
separada el día (DAY()), el mes (MONTH()) y el año (YEAR()).*/

SELECT COUNT(order_id) AS NumPedidos, DAY(order_date), MONTH(order_date), YEAR(order_date)
FROM orders
GROUP BY order_date;


/* 4. Número de pedidos por mes y año:
La consulta anterior nos muestra el número de pedidos para cada día concreto, pero esto es demasiado detalle. 
Genera una modificación de la consulta anterior para que agrupe los pedidos por cada mes concreto de cada año.*/

SELECT COUNT(order_id) AS NumPedidos, MONTH(order_date), YEAR(order_date)
FROM orders
GROUP BY MONTH(order_date), YEAR(order_date);  /* Debido a que tenemos que mostrar todos los pedidos en cada mes de cada año, el group by tiene que ser en los dos, mes y año */

/* 5. Seleccionad las ciudades con 4 o más empleadas:
Desde recursos humanos nos piden seleccionar los nombres de las ciudades con 4 o más empleadas de cara 
a estudiar la apertura de nuevas oficinas.*/


SELECT COUNT(DISTINCT employee_id) AS Numero_empleado, city 
FROM  employees
GROUP BY city
HAVING Numero_empleado >=4;

/* 6. Cread una nueva columna basándonos en la cantidad monetaria:
Necesitamos una consulta que clasifique los pedidos en dos categorías ("Alto" y "Bajo") en función de la 
cantidad monetaria total que han supuesto: por encima o por debajo de 2000 euros.*/

SELECT order_id, SUM(unit_price * quantity) AS 'Coste total',
CASE   
    WHEN SUM(unit_price * quantity) < 2000 THEN "Bajo"   
    ELSE "Alto"  
    END AS 'Costes'
FROM order_details
GROUP BY order_id;



