/*1.
Extraer en una CTE todos los nombres de las compañias y los id de los clientes.
Para empezar nos han mandado hacer una CTE muy sencilla el id del cliente y el nombre de la compañia de la tabla Customers.
*/

WITH info_clientes (id_cliente, nombre_empresa)    /*Creamos la CTE*/
AS (
	SELECT customer_id, company_name
	FROM customers
    ) 
    
SELECT *                   /*"Llamamos" a la CTE y seleccionamos, en este caso, todos los registros de esta*/
FROM info_clientes;

/*2.
Selecciona solo los de que vengan de "Germany"
Ampliemos un poco la query anterior. En este caso, queremos un resultado similar al anterior, pero solo queremos los que pertezcan a "Germany".
*/ /*MIRAR DETENIDAMENTE PARA INTENTAR CUMPLLIR EL QUE SUPONEMOS QUE ES EL OBJETIVO*/

WITH info_germany (id_cliente, nombre_empresa)    #Creamos otra CTE y filtramos por país.
AS (                                                       #Dudamos sobre la manera de filtrar el país reutilizando la CTE anterior, sin tener que modificar, ya que pensamos que es el objetivo de las Cte's
	SELECT customer_id, company_name
	FROM customers
    WHERE country = "Germany"
    ) 
    
SELECT *
FROM info_clientes;


/*3.
Extraed el id de las facturas y su fecha de cada cliente.
En este caso queremos extraer todas las facturas que se han emitido a un cliente, su fecha la compañia a la que pertenece.
📌 NOTA En este caso tendremos columnas con elementos repetidos(CustomerID, y Company Name).
*/

WITH datos_facturas (id_cliente, id_pedido, fecha_pedido, nombre_empresa)
AS (
	SELECT orders.order_id, orders.order_date, customers.customer_id, customers.company_name
    FROM orders 
    INNER JOIN customers
    ON orders.customer_id = customers.customer_id )
    
SELECT *
FROM datos_facturas;


/*4.
Contad el número de facturas por cliente       #POR CLIENTE nos indica que necesitaremos un GROUP BY. 
Mejoremos la query anterior. En este caso queremos saber el número de facturas emitidas por cada cliente. #Para saber el numero de facturas hemos contado el numero de registros de order_id. 
*/

WITH datos_facturas (numero_facturas, id_cliente, id_pedido, fecha_pedido, nombre_empresa)
AS (
	SELECT COUNT(orders.order_id),orders.order_id, orders.order_date, customers.customer_id, customers.company_name
    FROM orders 
    INNER JOIN customers
    ON orders.customer_id = customers.customer_id
    GROUP BY customers.company_name)
    
SELECT *
FROM datos_facturas;

/*5.
Cuál la cantidad media pedida de todos los productos ProductID. #AVG products/orders
Necesitaréis extraer la suma de las cantidades por cada producto y calcular la media.
*/

WITH media_productos_pedidos (nombre_producto, media_productos)
AS(
	SELECT products.product_name,  SUM(order_details.quantity) / COUNT(products.product_name) AS media_productos_pedidos
    FROM order_details
    INNER JOIN products
    ON products.product_id = order_details.product_id
    GROUP BY product_name
    )
SELECT *
FROM media_productos_pedidos;

