--Seleccionar las cuentas con saldo negativo
SELECT * from cuenta
WHERE balance < 0

--Seleccionar el nombre, apellido y edad de los clientes que tengan en el apellido la letra Z
SELECT customer_name, customer_surname, strftime('%Y', DATE('now')) - strftime('%Y', dob) AS edad from cliente
WHERE customer_surname LIKE "%z%"

--Seleccionar el nombre, apellido, edad y nombre de sucursal de las personas 
--cuyo nombre sea “Brendan” y el resultado ordenarlo por nombre de sucursal

SELECT customer_name, customer_surname, strftime('%Y', DATE('now')) - strftime('%Y', dob) AS edad, sucursal.branch_name from cliente
JOIN sucursal on sucursal.branch_id = cliente.branch_id
WHERE customer_name LIKE 'Brenda'
ORDER BY sucursal.branch_name

--Seleccionar de la tabla de préstamos, los préstamos con un importe mayor
--a $80.000 y los préstamos prendarios utilizando la unión de 
--tablas/consultas (recordar que en las bases de datos la moneda se guarda 
--como integer, en este caso con 2 centavos)

SELECT * from prestamo
WHERE (loan_total / 100) > 80000 AND loan_type LIKE 'PRENDARIO'

--Seleccionar los prestamos cuyo importe sea mayor que el importe medio de 
--todos los prestamos

SELECT * from prestamo
WHERE loan_total > (SELECT avg(loan_total) FROM prestamo)

--Contar la cantidad de clientes menores a 50 años

SELECT count(customer_name) as cantidad_menores from cliente
WHERE strftime('%Y', DATE('now')) - strftime('%Y', dob)< 50

--Seleccionar las primeras 5 cuentas con saldo mayor a 8.000$

SELECT * FROM cuenta
WHERE balance/100 > 8000
ORDER BY balance ASC
LIMIT 5

--Seleccionar los préstamos que tengan fecha en abril, junio y agosto, ordenándolos por importe
SELECT *, strftime('%m', loan_date) as mes FROM prestamo
WHERE mes = '04' OR mes = '06' OR mes = '08'
ORDER BY loan_total DESC

--Obtener el importe total de los prestamos agrupados por tipo de préstamos. 
--Por cada tipo de préstamo de la tabla préstamo, calcular la suma de sus importes.
--Renombrar la columna como loan_total_accu
SELECT loan_type, count(loan_total) as loan_type_cant, sum(loan_total) as loan_total_accu from prestamo
GROUP BY loan_type