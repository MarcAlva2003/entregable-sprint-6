-- Crear una vista con las columnas id, numero sucursal, nombre, apellido, DNI y edad de la tabla cliente calculada a partir de la fecha de nacimiento
-- o Mostrar las columnas de los clientes, ordenadas por el DNI de menor a mayor y cuya edad sea superior a 40 años

create VIEW v_cliente
as 
select 
	customer_id,
	branch_id,
	customer_name,
	customer_surname,
	customer_DNI,
	strftime('%Y', CURRENT_DATE)- strftime('%Y', dob) as EDAD  
	from cliente
SELECT customer_id,branch_id,customer_name,customer_surname,customer_DNI,EDAD FROM v_cliente

SELECT customer_id,branch_id,customer_name,customer_surname,customer_DNI,EDAD FROM v_cliente WHERE EDAD > 40 ORDER BY customer_DNI DESC 

-- Mostrar todos los clientes que se llaman “Anne” o “Tyler” ordenados por edad de menor a mayor

SELECT customer_id,branch_id,customer_name,customer_surname,customer_DNI,EDAD FROM v_cliente WHERE customer_name like 'Anne' or customer_name like 'Tyler' ORDER BY EDAD ASC

-- Dado el siguiente JSON. Insertar 5 nuevos clientes en la base de datos y verificar que se haya realizado con éxito la inserción

INSERT INTO cliente(customer_name,customer_surname,customer_DNI,branch_id,dob)
VALUES ('Lois','Stout','47730534', '80' ,'1984-07-07'),
		('Hall','Mcconnell','52055464','45','1968-04-30'),
		('Hilel','Mclean','43625213','77','1993-03-28'),
		('Jin','Cooley','21207908','96','1959-08-24'),
		('Gabriel','Harmon','57063950','27','1976-04-01')

SELECT customer_name,customer_surname,customer_DNI,branch_id,dob
FROM cliente
WHERE customer_name like 'Lois' or
	customer_name like 'Hall' or 
	customer_name like 'Hilel' or 
	customer_name like 'Jin'or 
	customer_name like 'Gabriel'
    
-- Actualizar 5 clientes recientemente agregados en la base de datos dado que hubo un error en el JSON que traía la información, la sucursal de todos es la 10

UPDATE cliente
SET branch_id = 10
WHERE customer_name like 'Lois' 

UPDATE cliente
SET branch_id = 10
WHERE customer_name like 'Hall' 

UPDATE cliente
SET branch_id = 10
WHERE customer_name like 'Hilel'

UPDATE cliente
SET branch_id = 10
WHERE customer_name like 'Jin'

UPDATE cliente
SET branch_id = 10
WHERE customer_name like 'Gabriel'

--chequeamos el UPDATE de sucursales
SELECT customer_name, branch_id
FROM cliente
WHERE customer_name like 'Lois' or
	customer_name like 'Hall' or 
	customer_name like 'Hilel' or 
	customer_name like 'Jin'or 
	customer_name like 'Gabriel'

-- Eliminar el registro correspondiente a “David” realizando la selección por el nombre

        --borramos a david de la carpeta cliente

        DELETE FROM cliente
        WHERE customer_name like 'david'


        --verificamos que fue borrado 'david'
        SELECT *
        FROM cliente
        WHERE customer_name like 'david'

-- Consultar sobre cuál es el tipo de préstamo de mayor importe

SELECT loan_total 
FROM prestamo
ORDER by loan_total DESC
LIMIT 1


