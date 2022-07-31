SELECT avg(loan_total) , sucursal.branch_name from prestamo
JOIN sucursal on sucursal.branch_id = cliente.branch_id
JOIN cliente on cliente.customer_id = prestamo.customer_id 
GROUP BY sucursal.branch_name