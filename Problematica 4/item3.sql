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