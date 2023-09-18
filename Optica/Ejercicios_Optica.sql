/*Llista el total de compres d’un client/a.*/
SELECT COUNT(*) AS Total_Compras FROM optica.clientes INNER JOIN optica.compras ON optica.compras.Clientes_idClientes=optica.clientes.idClientes WHERE nombre='Lucas';
/*Llista les diferents ulleres que ha venut un empleat durant un any.*/
SELECT codigo, marca, precio, nombre AS empleado FROM optica.gafas INNER JOIN optica.compras ON optica.compras.gafas_codigo=optica.gafas.codigo INNER JOIN optica.empleado ON optica.empleado.idEmpleado=optica.compras.empleado_idEmpleado WHERE Empleado_idEmpleado="5" AND YEAR(fecha_compra)=2023;
/*Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.*/
SELECT nombre FROM optica.proveedores LEFT JOIN optica.gafas ON optica.gafas.Proveedores_idProveedores=optica.proveedores.idProveedores RIGHT JOIN optica.compras ON optica.compras.gafas_codigo=optica.gafas.codigo GROUP BY nombre;