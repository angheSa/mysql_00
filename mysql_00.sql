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
where dni in(76424324,14515625);
-- like
select * from estudiante
where nombre like 'J%';

select*from estudiante
where nombre like '%A';

select * from estudiante
where nombre like '_a%';

select*from estudiante
where nombre like '_a___';

