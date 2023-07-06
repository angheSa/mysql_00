use northwind;

show tables;
describe employees;

-- funciones de agregacion
-- agrupar datos, resumirlos
-- algunas: sum(), count(), max(), min(), avg(), round()

select * from employees;
-- SABER LA CANTIDAD DE EMPLEADOS
select COUNT(EmployeeID) as CantidadEmpleados from employees;

-- EL PRECIO MAXIMO Y MINIMO DE UN PRODUCTO
select * from products;
select max(Price) as PrecioMaximo, min(Price) as PrecioMinimo from products;

-- sacar un promedio al precio d eun producto
select avg(Price) from products;
-- redondear el promedio
select round(avg(Price)) as Precio from products;
-- redondear todos los precios
select round(Price) as Precio from products;

-- DISTINC (NO ES FUNCION)
select distinct Price from products;


-- GROP BU Y HAVING
-- GROUP BY: Agrpa 1 o varios registros
-- HAVING: Filtra Grupos

-- quiero saber el prmedio del precio de productos por cada categoria


select * from products;

select CategoryID, avg(Price) as PromedioPrecio from products
group by CategoryID;

-- quiero saber el prmedio del precio de productos por cada categoria, donde quiero 
-- que solome muestre los promedios mayores a 30 <>
 select CategoryID, avg(Price) as PromedioPrecio from products
 group by CategoryID
 having PromedioPrecio  > 30
order by  PromedioPrecio desc
limit 2

 