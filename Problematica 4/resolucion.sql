--1 Listar la cantidad de clientes por nombre de sucursal ordenando de mayor a menor

SELECT count(employee_name) as cantidad_empleados, sucursal.branch_name from empleado
JOIN sucursal on sucursal.branch_id = empleado.branch_id
GROUP BY sucursal.branch_name  
ORDER BY cantidad_empleados ASC

--2 Obtener la cantidad de empleados por cliente por sucursal en un número real

SELECT count(customer_name)as cantidad_clientes, sucursal.branch_name from cliente
JOIN sucursal on sucursal.branch_id = cliente.branch_id
GROUP BY sucursal.branch_name

--3 Obtener la cantidad de tarjetas de crédito por tipo por sucursal

SELECT count(TipoTarjeta.tipo_de_tarjeta),suc.branch_name
FROM tipo_tarjeta TipoTarjeta 
INNER JOIN tarjetas Tarjeta
ON TipoTarjeta.tipo_tarjeta_id =  Tarjeta.tipo_tarjeta_id
INNER JOIN cuenta c
ON c.account_id=Tarjeta.account_id
INNER JOIN cliente cli
ON cli.customer_id=c.customer_id
INNER JOIN sucursal suc
ON suc.branch_id=cli.branch_id
WHERE TipoTarjeta.tipo_tarjeta_id=1
GROUP BY suc.branch_name ;

--4 Obtener el promedio de créditos otorgado por sucursal

SELECT avg(loan_total) , sucursal.branch_name from prestamo
JOIN sucursal on sucursal.branch_id = cliente.branch_id
JOIN cliente on cliente.customer_id = prestamo.customer_id 
GROUP BY sucursal.branch_name

--5 La información de las cuentas resulta critica para la compañía,
--por eso es necesario crear una tabla denominada “auditoria_cuenta” para guardar los 
--datos movimientos, con los siguientes campos: old_id, new_id, old_balance, 
--new_balance, old_iban, new_iban, old_type, new_type, user_action, 
--created_at
--  - Crear un trigger que después de actualizar en la tabla cuentas los campos balance,
-- 	  IBAN o tipo de cuenta registre en la tabla auditoria
--  - Restar $100 a las cuentas 10,11,12,13,14

CREATE TABLE  auditoria_cuenta(
	id_auditoria_cuenta INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
	old_id INTEGER NOT NULL,
	new_id INTEGER NOT NULL,
	old_balance INTEGER NOT NULL,
	new_balance INTEGER NOT NULL,
	old_iban TEXT NOT NULL,
	new_iban TEXT NOT NULL,
	old_type TEXT NOT NULL,
	new_type TEXT NOT NULL,
	user_action TEXT NOT NULL,
	created_at TEXT NOT NULL
) ;

CREATE TRIGGER registre_en_tabla_auditoria 
AFTER UPDATE ON cuenta
WHEN old.balance <> new.balance or old.iban <> new.iban or old.tipo_cuenta_id <> new.tipo_cuenta_id
BEGIN
	insert into 
	auditoria_cuenta(
	old_id,
	new_id,
	old_balance,
	new_balance,
	old_iban,
	new_iban,
	old_type,
	new_type,
	user_action,
	created_at
	) values(
		old.customer_id,
		new.customer_id,
		old.balance,
		new.balance,
		old.iban,
		new.iban,
		old.tipo_cuenta_id,
		new.tipo_cuenta_id,
		'UPDATE',
		datetime('now')
	);
END;

UPDATE cuenta
SET balance = balance - 10000
WHERE customer_id BETWEEN 10 and 14

SELECT * from auditoria_cuenta

--6 Mediante índices mejorar la performance la búsqueda de clientes por DNI
CREATE 
	UNIQUE INDEX  idx_busqueda_dni on cliente(customer_DNI)
	
EXPLAIN QUERY PLAN
SELECT *
FROM cliente
WHERE customer_DNI = '74701370'

--7 Crear la tabla “movimientos” con los campos de identificación del movimiento, número de cuenta, monto, tipo de operación y hora
--o Mediante el uso de transacciones, hacer una transferencia de 1000$ desde la cuenta 200 a la cuenta 400
--o Registrar el movimiento en la tabla movimientos
--o En caso de no poder realizar la operación de forma completa, realizar un ROLLBACK

BEGIN TRANSACTION;

UPDATE cuenta
set balance = balance - 1000
where customer_id = 200;

UPDATE cuenta
set balance = balance + 1000
WHERE customer_id = 400;

insert into movimientos(
		iban,
		monto,
		tipo_operacion,
		hora
	) values(
		(SELECT iban from cuenta where customer_id = 200),
		1000,
		'Transferencia',
		datetime('now')
	);

COMMIT;

CREATE TABLE movimientos (
	id_movimiento INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT ,
	iban TEXT NOT NULL,
	monto INTEGER NOT NULL,
	tipo_operacion TEXT NOT NULL,
	hora TEXT NOT NULL
);