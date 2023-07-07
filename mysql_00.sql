-- mysql

-- restricciones (primary key, foreign key, default, check, unique)

create database bd_ficticio;
use bd_ficticio;

create table estudiante (
id int primary key,
nombre varchar(255),
sexo char(1) not null DEFAULT 'M',
dni char(8)  UNIQUE,
edad int ,
CHECK(edad>16)
);
-- drop table estudiante;


INSERT INTO estudiante (id,sexo,dni,edad)
VALUES(1,'F','12345678',18);
select*from estudiante;
INSERT INTO estudiante (id,sexo,dni,edad)
VALUES(3,default,'76424324',18);

INSERT INTO estudiante
VALUES(4,'Juan','M','76415925',20),
(5,'Sonia','F','14515625',35),
(6,'Luz','F','14515154',19),
(7,'Maria','F','14515644',21),
(8,'Luis Leon','M','24415925',20),
(9,'Regina','F','14515925',40),
(10,'Valeria Sando','F','66415925',20),
(11,'Carlos Peña','M','56415925',40),
(12,'Xoila Mirnada','F','46415925',26),
(13,'Juan','M','16415925',28);

-- operadores logicos,like, between, in
-- logicos AND, OR, XOR, NOT
select * from estudiante 
where edad>20 AND edad<22;

select * from estudiante
where edad>39 or sexo = 'M';

select * from estudiante
where edad>39 XOR sexo = 'M';

select* from estudiante
where NOT edad>38;
-- BETWEEN
select *
from estudiante
where edad between 20 AND 30;
-- in
select* from estudiante
where dni in(76424324,14515623);
-- like
select * from estudiante
where nombre like 'J%';

select*from estudiante
where nombre like '%A';

select * from estudiante
where nombre like '_a%';

select*from estudiante
where nombre like '_a___';


-- funciones con fechas

create table fechas(
id_fe int primary key,
fecha1 date ,
nombre varchar(220)
-- fecha2 datetime,
-- fecha3 time
);
drop table fechas;
INSERT INTO fechas
VALUES(1,'2020-01-12','Juan'),
(2,'2022-01-15','Pedro'),
(3,'2021-03-15','Oscar');

select now(); -- fecha y hora actual
select curdate(); -- just date
select curtime(); -- just time
-- now()              or (((getdate())) aun no
select YEAR(now());
select MONTH(now());
select DAY(now());
select TIME(now());

select last_day(now()); -- ultimo dia del mes

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
limit 2;

 -- DDL (CREATE,ALTER,DROP)
 create table empleados (
	cod_empleado int not null,
    nombre_empleado varchar(255)  not null,
    apellido_empleado varchar(255) not null,
    dni_empleado char(8) not null unique,
    telefono_empleado char(9) not null,
    edad int not null,
    sexo char(1) default 'M'
 );
 drop table empleados;
 
 -- add primary key in empleados
 alter table empleados
 add primary key (cod_empleado);
 
 select*from empleados;
 -- add column salario
 alter table empleados
 add column salario decimal(4,2) not null;
 
 alter table empleados
 modify column salario decimal(7,2) not null;
 -- add check to salario
 alter table empleados 
 add constraint chk_salario
 check(salario > 1025.00);
 
 --
 
 alter table empleados
 add constraint  chk_salarior
check(salario > 3025.00);
 
 alter table empleados
 modify column cod_empleado int auto_increment;
 alter table empleados
 modify column cod_empleado int auto_increment;
 
 alter table empleados
 drop constraint chk_salario;
 
  insert into empleados values(DEFAULT,'Juan', 'Solis Perez', '76424314','578567567',23,DEFAULT, 2331.00);
   insert into empleados values(DEFAULT,'Xio', 'Arias Lila', '86424314','178567567',26,DEFAULT, 2631.00);
   
   

   set @edad = 20;
   
   -- procedimiento almaenado
   
   DELIMITER //
   
   CREATE PROCEDURE sp_lista_empleados()
   BEGIN
	select * from empleados;
   END //
   DELIMITER ;
   
   call sp_lista_empleados;
   drop procedure if exists sp_lista_empleados;
   
   DELIMITER //
   create procedure sp_con_parametros(v1 char(1))
   begin
	select * from empleados
    where nombre_empleado LIKE concat(v1,'%');
   end //
   
   DELIMITER ;
   
   call sp_con_parametros('X');
   

DELIMITER //
create procedure sp_condicion(codigo int)
begin 
IF exists (select*from empleados where codigo_empleado = codigo)
then
	select*from empleados where codigo_empleado = codigo;

ELSE

	select 'No existe el empleado con el codigo';
    end if;
end //
DELIMITER ;

DELIMITER //
create procedure sp_condicional(cod int)
begin
	if exists(select* from empleados where cod_empleado = cod)
    then 
    select* from empleados where cod_empleado = cod;
    else
     select 'NO EXISTE';
     end if;
end //
DELIMITER ;

CALL sp_condicional(3);

-- muestrame el nombre , apellido y edad del empleado. Valida si es mayor de edad o menor de edad
-- <>
DELIMITER //
create procedure sp_mayoredad(age int)
begin
	if (age >= 18 )
    then
		select * from empleados where edad >= 18;
      
    else
    
		select 'Es menor de edad'; 
    end if;
end //
DELIMITER ;
drop procedure sp_mayoredad;
call sp_mayoredad(18);

show tables;
select * from orders;
select * from orderdetails;
select * from products;
select * from categories;
select c.CategoryName , p.ProductName, os.OrderDetailID, o.OrderID  as Ordenes from products p
inner join categories c on  p.CategoryID = c.CategoryID
inner join orders o inner join orderdetails os on o.OrderID = os.OrderID
on os.ProductID = p.ProductID; 

select c.CategoryName,  p.ProductName , c.Description from products p
left join categories c on p.CategoryID = c.CategoryID;

select os.ProductID as idproducto, sum(Quantity) as cantidad from orderdetails os
group by os.ProductID; 

create view v_detalles
as
select c.CategoryName , p.ProductName, os.OrderDetailID, o.OrderID  as Ordenes from products p
inner join categories c on  p.CategoryID = c.CategoryID
inner join orders o inner join orderdetails os on o.OrderID = os.OrderID
on os.ProductID = p.ProductID; 

select * from v_detalles;

select sum(Quantity),ProductID from orderdetails
group by ProductID
having ProductID = 11;