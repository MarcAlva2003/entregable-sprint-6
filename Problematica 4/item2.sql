SELECT count(customer_name)as cantidad_clientes, sucursal.branch_name from cliente
JOIN sucursal on sucursal.branch_id = cliente.branch_id
GROUP BY sucursal.branch_name