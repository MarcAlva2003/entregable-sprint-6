-----------------------------------------------------------6------------------------------------------------------------------
CREATE 
	UNIQUE INDEX  idx_busqueda_dni on cliente(customer_DNI)
	
EXPLAIN QUERY PLAN
SELECT *
FROM cliente
WHERE customer_DNI = '74701370'