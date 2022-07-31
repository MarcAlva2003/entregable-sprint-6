CREATE TABLE tipo_cliente(
	tipo_cliente_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	tipo_cliente_nombre TEXT NOT NULL 
)
INSERT INTO tipo_cliente(tipo_cliente_nombre)
VALUES ('Classic')

INSERT INTO tipo_cliente(tipo_cliente_nombre)
VALUES ('Gold')

INSERT INTO tipo_cliente(tipo_cliente_nombre)
VALUES ('Black')

Create table tipo_cuenta(
	tipo_cuenta_Id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	cuenta_corriente INTEGER NOT NULL CHECK(cuenta_corriente>=0 AND cuenta_corriente <=1),
	caja_ahorro_pesos INTEGER NOT NULL CHECK(caja_ahorro_pesos>=0 AND caja_ahorro_pesos <=1),
	caja_ahorro_dolares INTEGER NOT NULL CHECK(caja_ahorro_dolares>=0 AND caja_ahorro_dolares <=1),
	tipo_cliente_id INTEGER NOT NULL,
	FOREIGN KEY(tipo_cliente_id) REFERENCES tipo_cliente(tipo_cliente_id)
)
--ampliamos el alcance de cuenta para que reconozca el tipo de cuenta 
ALTER TABLE cuenta ADD COLUMN tipo_cuenta_id INTEGER REFERENCES tipo_cuenta(tipo_cuenta_Id)
-- le insertamos True(1) o False(0) para indicar si el cliente tiene o no la caracteristica.
INSERT INTO tipo_cuenta(cuenta_corriente,caja_ahorro_pesos,caja_ahorro_dolares,tipo_cliente_id)
VALUES(False,True ,False , 1)

INSERT INTO tipo_cuenta(cuenta_corriente,caja_ahorro_pesos,caja_ahorro_dolares,tipo_cliente_id)
VALUES( True,True ,True , 2)

INSERT INTO tipo_cuenta(cuenta_corriente,caja_ahorro_pesos,caja_ahorro_dolares,tipo_cliente_id)
VALUES( True,True ,True , 3)

UPDATE cuenta
SET tipo_cuenta_id = (abs(random())%(4-1)+1)
WHERE account_id > 0

create table marca_tarjeta(
	marca_tarjeta_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	marca text not null 
)

INSERT INTO marca_tarjeta(marca)
VALUES ('Visa')

INSERT INTO marca_tarjeta(marca)
VALUES ('MasterCard')

INSERT INTO marca_tarjeta(marca)
VALUES ('AMEX')

create table tipo_tarjeta(
	tipo_tarjeta_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	tipo_de_tarjeta text not null 
)

INSERT INTO tipo_tarjeta(tipo_de_tarjeta)
VALUES ('Credito')

INSERT INTO tipo_tarjeta(tipo_de_tarjeta)
VALUES ('Debito')

create table tarjetas(
	tarjeta_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	numero_tarjeta INT NOT NULL UNIQUE CHECK(numero_tarjeta BETWEEN 0 AND 99999999999999999999 ),
	cvv INT NOT NULL CHECK(cvv BETWEEN 0 AND 999),
	fecha_emision TEXT NOT NULL,
	fecha_vencimiento TEXT NOT NULL,
	tipo_tarjeta_id INTEGER NOT NULL,
	marca_tarjeta_id INTEGER NOT NULL,
	account_id INTEGER NOT NULL,
	FOREIGN KEY (tipo_tarjeta_id) REFERENCES tipo_tarjeta(tipo_tarjeta_id),
	FOREIGN KEY (marca_tarjeta_id) REFERENCES marca_tarjeta(marca_tarjeta_id),
	FOREIGN KEY(account_id) REFERENCES cuenta(account_id)
)
create TABLE direcciones(
	direccion_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	direccion_calle_numero TEXT NOT NULL,
	direccion_ciudad TEXT NOT NULL,
	direccion_provincia TEXT NOT NULL,
	direccion_pais TEXT NOT NULL
)


ALTER TABLE cliente ADD COLUMN direccion_id INTEGER REFERENCES direcciones(direccion_id);
ALTER TABLE empleado ADD COLUMN direccion_id INTEGER REFERENCES direcciones(direccion_id);
ALTER TABLE sucursal ADD COLUMN direccion_id INTEGER REFERENCES direcciones(direccion_id);

--agregamos un index para ponerle el atributo UNIQUE al campo direccion_id de la tabla sucursal
create UNIQUE INDEX idx_direccion_id_unique on sucursal(direccion_id)
--actualizamos los campos de las direcciones de las tablas

UPDATE cliente
SET direccion_id = (abs(random())%(200-1)+1)
WHERE customer_id > 0

UPDATE empleado
SET direccion_id = (abs(random())%(400-200)+200)
WHERE employee_id > 0

UPDATE sucursal 
SET direccion_id = dir.direccion_id + 399
FROM (SELECT * FROM direcciones) AS dir
WHERE branch_id > 0 AND branch_id = dir.direccion_id



