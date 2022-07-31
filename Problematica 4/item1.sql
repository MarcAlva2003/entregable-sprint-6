SELECT count(employee_name) as cantidad_empleados, sucursal.branch_name from empleado
JOIN sucursal on sucursal.branch_id = empleado.branch_id
GROUP BY sucursal.branch_name  
ORDER BY cantidad_empleados ASC