-- SQLite
-- FUNCIONES DE GRUPO O MULTILINEA:

--Salario maximo en la columna salario
SELECT max(salary) from employees;


--Salario minimo en la columna salario
SELECT min(salary) from employees;


--Calcular cantidad de datos en una columna
SELECT count(salary) from employees;

--Saca el promedio de los elementos: Suma todos los elementos y los divide por la cantidad de elementos
SELECT avg(salary) as 'promedio' from employees;


--Cuente todos los deptos distintos:

select count(DISTINCT department_id) as distintos_total, count(department_id)  as total_column_depid from employees;



--Consulta estructurada department_ID= 3

select max(salary) as Salario_Maximo,  min(salary) as Salario_Minimo, count(salary) as Total_registros_count, avg(salary) as promedio_salario from employees where department_id = 3;


---------------GROUP BY: FUNCIONES DE GRUPO 

select department_id, avg(salary) from employees group by department_id;
---------------

SELECT avg(salary) from employees GROUP BY department_id;


--------------GROUP BY HAVING:

select department_id, max(salary) from employees GROUP BY department_id HAVING max(salary)>10000;

--Numero de personas con el mismo trabajo:

SELECT job_id, COUNT(*)
FROM employees
GROUP BY job_id;

-- Cree un informe para mostrar el número de gerente y el salario del empleado
-- con el salario más bajo para ese gerente. Excluir a cualquiera cuyo gerente
-- no sea conocido. Excluya cualquier grupo donde el salario mínimo sea de $
-- 6,000 o menos. Ordene la salida en orden descendente de salario

SELECT manager_id , min(salary) as salario
from employees 
where manager_id is not null --No trae los manager_id vacios o nulos
GROUP by manager_id
having min(salary)> 6000 --trae salarios mayores a 6000
ORDER BY salary DESC; --Ordenar salario descendente



--UNIR DIFERENTES TABLAS EN UNA SOLA: 

--JOIN

--NATURAL JOIN: Busca que exista en ambas tablas un mismo valor de campo para hacer
--la relación --

--Union tabla departmentes and locations:

--VALIDAR UNION DE LAS DOS TABLAS!!
SELECT * from departments;
select * from locations;


-- natural JOIN locations; --Hace relacion entre llaves foraneas en este caso LOCATION_ID
-- hHace union de datos teniendo en cuenta la data de location_ID!!
SELECT * from departments
natural JOIN locations;





--Union tablas con campos especifico para traer:

SELECT department_id, department_name, street_address, city from departments
natural JOIN locations;


--Bautizar columnas para evitar confusión entre dos tablas:

SELECT * from departments;
SELECT * from locations;

SELECT department_id, department_name, street_address, city from departments 
natural JOIN locations;


SELECT location_id, street_address, city, state_province, country_id from locations
NATURAL JOIN countries;





SELECT * from locations
natural JOIN departments;


SELECT * from countries;
SELECT * from departments;
SELECT * from locations;

--ALIAS: PARA DIFERENCIAR DE DONDE VIENE CADA DATO SE PONE INICIAL DEL NOMBRE DE CADA TABLA.

SELECT d.department_id, d.department_name, l.street_address, l.city from departments d
NATURAL JOIN locations l;


--ALIAS- PARA DIFERENCIAR COLUMNAS RELACIONADAS:

-- CON USIN SE INDICA LA COLUMNA QUE VA A RELACIONAR: PARA CUANDO SE REPITEN NOMBRES EN COLUMNAS
SELECT d.department_id, d.department_name, l.street_address, l.city from departments d
JOIN locations l USING (location_id);



--Haciendo join con 3 tablas: DEPARTMENTS--- LOCATIONS --- COUNTRIES

SELECT d.department_id, d.department_name, l.street_address, l.city, c.country_name from departments d
NATURAL JOIN locations l
NATURAL JOIN countries c;



SELECT d.department_id, d.department_name, l.street_address, l.city, c.country_name from departments d
JOIN locations l USING (location_id)
JOIN countries c USING (country_id);


-----------------------------------------------------------------------------------

--JOIN ON: SE IDENTIFICAN DIRECTAMENTE LAS RELACIONES: DEFINICION EXPLICITA DE LOS CAMPOS
--RELACIONADOS.-- SE USA CUANDO AMBAS TABLAS TIENEN EL MISMO NOMBRE DE CAMPOS:

SELECT d.department_id, d.department_name, l.street_address, l.city, c.country_name from departments d
JOIN locations l ON (d.location_id = l.location_id)
JOIN countries c ON (l.country_id = c.country_id);




---INNER JOIN: LAS DOS SON IGUALES:
SELECT d.department_id, d.department_name, l.street_address, l.city, c.country_name from departments d
INNER JOIN locations l ON (d.location_id = l.location_id)
INNER JOIN countries c ON (l.country_id = c.country_id);

--SELF JOIN: RELACION DE UNA TABLA CON SI MISMA-- CREA UNA UNION CON LA MISMA TABLA:

SELECT e.last_name as employee, m.last_name as manager from  employees e
JOIN employees m on (e.manager_id = m.employee_id); 

----------------------------------------------------------------------------------


--NOEQUIJOIN--VALIDACION DE RANGO DE SALARIOS SEGUN LA TABLA DE JOB_GRADES:--
select e.last_name, e.salary, jg.grade from employees e
JOIN job_grades jg on (e.salary BETWEEN jg.lowest_sal and jg.highest_sal)

--OR:
select e.last_name, e.salary, jg.grade from employees e
JOIN job_grades jg on (e.salary >= jg.lowest_sal and e.salary <= jg.highest_sal)


--OUTERJOIN: TIENE LEFT-RIGHT Y FULL:
--LEFT: DA PRIORIDAD AL CONJUNTO DE LA IZQUIERDA DEL DE LA DERECHA:

--No trae registro null:
SELECT e.last_name as employee, m.last_name as manager from  employees e
JOIN employees m on (e.manager_id = m.employee_id); 

--Si trae registro Null:
SELECT e.last_name as employee, m.last_name as manager from  employees e
LEFT JOIN employees m on (e.manager_id = m.employee_id); 


--FULL OUTER: TRAE TODOS LOS DATOS DE LAS DOS TABLAS:
SELECT e.last_name as employee, m.last_name as manager from  employees e
FULL OUTER JOIN employees m on (e.manager_id = m.employee_id); 

--CROSS JOIN: Producto cruce entre dos conjnutos: Se usa cuando se tienen dos tablas
--que no estan relacionadas, y lo que se quiere es tener una relación que se pueden 
--tener en esa relación.

--SE QUIERE HACER UN JOIN ENTRE DOS TABLAS QUE NO TIENEN NINGUNA RELACION:REGIONES Y JOBS

SELECT r.region_id, r.region_name, j.job_title FROM regions r
cross JOIN jobs j;--Cada elemento de región lo combina con cada elemnto de job.



