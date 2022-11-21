USE northwind;
#Consultas en multiples tablas 3

#Creando tablas temporales, codigo de ejemplo

SELECT  'Hola!'  AS tipo_nombre
FROM customers;

#Extraer toda la información sobre las compañias que tengamos en la BBDD
#Nuestros jefes nos han pedido que creemos una query que nos devuelva todos los clientes y proveedores que tenemos en la BBDD. Mostrad la ciudad a la que pertenecen, el nombre de la empresa y el nombre del contacto, además de la relación (Proveedor o Cliente). Pero importante! No debe haber duplicados en nuestra respuesta. La columna Relationship no existe y debe ser creada como columna temporal. Para ello añade el valor que le quieras dar al campo y utilizada como alias Relationship.
#Nota: Deberás crear esta columna temporal en cada instrucción SELECT.

SELECT city AS Ciudad, company_name AS CompanyName, contact_name AS ContactName, 'Customers' AS Relationship
FROM customers
UNION 
SELECT city AS Ciudad, company_name AS CompanyName, contact_name AS ContactName, 'Supplier' AS Relationship
FROM suppliers ;

#2 Extraer todos los pedidos gestinados por "Nancy Davolio"
#En este caso, nuestro jefe quiere saber cuantos pedidos ha gestionado "Nancy Davolio", una de nuestras empleadas. Nos pide todos los detalles tramitados por ella.

SELECT *
FROM orders
WHERE employee_id = 1 IN (
    SELECT employee_id
    FROM employees);
    
#3 Extraed todas las empresas que no han comprado en el año 1997
#En este caso, nuestro jefe quiere saber cuántas empresas no han comprado en el año 1997.
#💡 Pista 💡 Para extraer el año de una fecha, podemos usar el estamento year. Más documentación sobre este método aquí.

SELECT company_name AS CompanyName, country AS Country
FROM customers
WHERE customer_id NOT IN (
				SELECT customer_id
                FROM orders
                WHERE YEAR(order_date) = 1997 );

#4 Extraed toda la información de los pedidos donde tengamos "Konbu"
#Estamos muy interesados en saber como ha sido la evolución de la venta de Konbu a lo largo del tiempo. Nuestro jefe nos pide que nos muestre todos los pedidos que contengan "Konbu".
#💡 Pista 💡 En esta query tendremos que combinar conocimientos adquiridos en las lecciones anteriores como por ejemplo el INNER JOIN.

SELECT *
FROM order_details
INNER JOIN products
ON products.product_id = order_details.product_id
WHERE products.product_name = 'Konbu';

