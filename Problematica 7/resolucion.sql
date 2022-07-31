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