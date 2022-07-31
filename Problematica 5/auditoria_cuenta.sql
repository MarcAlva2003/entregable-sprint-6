--La información de las cuentas resulta critica para la compañía,
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