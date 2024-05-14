`
# Presentacion de los resultados de Tablas

Los objetos de tipo Date reprecentan un momento fijo en le tiempo de un formato independiente, 

aConsultas sobre una tabla
```
``
```

1. Devuelve un listado con el primer apellido, segundo apellido y el nombre de
todos los alumnos. El listado deberá estar ordenado alfabéticamente de
menor a mayor por el primer apellido, segundo apellido y nombre.
```
SELECT primer_apellido_estudiante, segundo_apellido_estudiante, primer_nombre_estudiante
FROM estudiante
ORDER BY primer_apellido_estudiante, segundo_apellido_estudiante, primer_nombre_estudiante;

+----------------------------+-----------------------------+--------------------------+
| primer_apellido_estudiante | segundo_apellido_estudiante | primer_nombre_estudiante |
+----------------------------+-----------------------------+--------------------------+
| Díaz                       | Ramírez                     | Carolina                 |
| Gómez                      | Pérez                       | Juan                     |
| López                      | García                      | Pedro                    |
| Martínez                   | González                    | María                    |
| Rodríguez                  | Hernández                   | Ana                      |
+----------------------------+-----------------------------+--------------------------+
```
2. Averigua el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.
```
SELECT primer_nombre_estudiante, primer_apellido_estudiante, segundo_apellido_estudiante
FROM estudiante
WHERE id_estudiante NOT IN (SELECT id_estudiante FROM numero_telefono_estudiante);

+--------------------------+----------------------------+-----------------------------+
| primer_nombre_estudiante | primer_apellido_estudiante | segundo_apellido_estudiante |
+--------------------------+----------------------------+-----------------------------+
| Ana                      | Rodríguez                  | Hernández                   |
| Carolina                 | Díaz                       | Ramírez                     |
+--------------------------+----------------------------+-----------------------------+
```
3. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
```
SELECT primer_nombre_estudiante, segundo_nombre_estudiante, primer_apellido_estudiante, segundo_apellido_estudiante
FROM estudiante
WHERE YEAR(fecha_nacimiento) = 1999;

+--------------------------+---------------------------+----------------------------+-----------------------------+
| primer_nombre_estudiante | segundo_nombre_estudiante | primer_apellido_estudiante | segundo_apellido_estudiante |
+--------------------------+---------------------------+----------------------------+-----------------------------+
| Luis                     | Miguel                    | Gutiérrez                  | López                       |
| Fernanda                 | Isabel                    | Vargas                     | Martínez                    |
+--------------------------+---------------------------+----------------------------+-----------------------------+
```
4. Devuelve el listado de profesores que no han dado de alta su número de teléfono en la base de datos y además su nif termina en K.
```
SELECT *
FROM profesor
WHERE id_profesor NOT IN (
    SELECT id_profesor
    FROM numero_telefono_profesor
) AND RIGHT(nit_profesor, 1) = 'K';
```
```
SELECT *
FROM profesor
WHERE RIGHT(nit_profesor, 1) = 'K';

+-------------+--------------+------------------------+-------------------------+--------------------------+---------------------------+-----------+-----------------+------------------+--------+
| id_profesor | nit_profesor | primer_nombre_profesor | segundo_nombre_profesor | primer_apellido_profesor | segundo_apellido_profesor | id_genero | id_departamento | fecha_nacimiento | activo |
+-------------+--------------+------------------------+-------------------------+--------------------------+---------------------------+-----------+-----------------+------------------+--------+
|           4 | 123456789K   | Ana                    | María                   | López                    | Gómez                     | F         |               4 | 1978-09-12       |      1 |
|           5 | 987654321K   | Luis                   | NULL                    | Hernández                | Martínez                  | M         |               1 | 1982-04-25       |      1 |
+-------------+--------------+------------------------+-------------------------+--------------------------+---------------------------+-----------+-----------------+------------------+--------+
```
5. Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.
```
SELECT c.nombre_curso
FROM curso c
WHERE c.id_grado = 7
AND c.curso = 3
AND c.periodo_cuatro_meses = 1;
+----------------+
| nombre_curso   |
+----------------+
| Hisotira Khant |
+----------------+
```

1. Devuelve un listado con los datos de todas las alumnas que se han
matriculado alguna vez en el Grado en Ingeniería Informática (Plan 2015).
```
SELECT e.id_estudiante, e.nit_estudiante, e.primer_nombre_estudiante, e.segundo_nombre_estudiante, e.primer_apellido_estudiante, e.segundo_apellido_estudiante
FROM estudiante e
JOIN curso_estudiante ce ON e.id_estudiante = ce.id_estudiante
JOIN curso c ON ce.id_curso = c.id_curso
WHERE c.nombre_curso = 'Grado en Ingeniería Informática' AND c.curso = 1;

+---------------+----------------+--------------------------+---------------------------+----------------------------+-----------------------------+
| id_estudiante | nit_estudiante | primer_nombre_estudiante | segundo_nombre_estudiante | primer_apellido_estudiante | segundo_apellido_estudiante |
+---------------+----------------+--------------------------+---------------------------+----------------------------+-----------------------------+
|             8 | 0987654321     | Ana                      | María                     | González                   | López                       |
|             9 | 9876543210     | Laura                    | Isabel                    | Sánchez                    | García                      |
|            10 | 8765432109     | Marta                    | Elena                     | Fernández                  | Pérez                       |
+---------------+----------------+--------------------------+---------------------------+----------------------------+-----------------------------+
```
2. Devuelve un listado con todas las asignaturas ofertadas en el Grado en
Ingeniería Informática (Plan 2015).
```
SELECT id_curso, nombre_curso
FROM curso
WHERE id_grado = (SELECT id_grado FROM grado WHERE nombre_grado = 'Ingeniería Informática');

+----------+--------------------------------------------+
| id_curso | nombre_curso                               |
+----------+--------------------------------------------+
|       10 | Introducción a la Ingeniería de Sistemas   |
|       11 | Algoritmos y Estructuras de Datos          |
|       12 | Programación Orientada a Objetos           |
+----------+--------------------------------------------+
```

3. Devuelve un listado de los profesores junto con el nombre del
departamento al que están vinculados. El listado debe devolver cuatro
columnas, primer apellido, segundo apellido, nombre y nombre del
departamento. El resultado estará ordenado alfabéticamente de menor a
mayor por los apellidos y el nombre.
```
SELECT 
    p.primer_apellido_profesor,
    p.segundo_apellido_profesor,
    p.primer_nombre_profesor,
    d.nombre_departamento AS nombre_departamento
FROM 
    profesor p
INNER JOIN 
    departamento d ON p.id_departamento = d.id_departamento
ORDER BY 
    p.primer_apellido_profesor, 
    p.segundo_apellido_profesor,
    p.primer_nombre_profesor;

+--------------------------+---------------------------+------------------------+------------------------------+
| primer_apellido_profesor | segundo_apellido_profesor | primer_nombre_profesor | nombre_departamento          |
+--------------------------+---------------------------+------------------------+------------------------------+
| González                 | Pérez                     | Juan                   | Departamento de Matemáticas  |
| Hernández                | Martínez                  | Luis                   | Departamento de Matemáticas  |
| López                    | Gómez                     | Ana                    | Departamento de Literatura   |
| Martínez                 | López                     | María                  | Departamento de Ciencias     |
| Ramírez                  | García                    | Pedro                  | Departamento de Historia     |
+--------------------------+---------------------------+------------------------+------------------------------+
```
Devuelve un listado con el nombre de las asignaturas, año de inicio y año de
fin del curso escolar del alumno con nif 26902806M.
```
SELECT 
    c.nombre_curso AS nombre_asignatura,
    ae.anio_inicio,
    ae.anio_fin
FROM 
    curso_estudiante ce
INNER JOIN 
    curso c ON ce.id_curso = c.id_curso
INNER JOIN 
    anio_escolar ae ON ce.id_anio_escolar = ae.id_anio_escolar
INNER JOIN 
    estudiante e ON ce.id_estudiante = e.id_estudiante
WHERE 
    e.nit_estudiante = '26902806M';

+-----------------------+-------------+----------+
| nombre_asignatura     | anio_inicio | anio_fin |
+-----------------------+-------------+----------+
| Matemáticas Básicas   |        2018 |     2019 |
| Ciencias Naturales    |        2018 |     2019 |
| Historia Antigua      |        2018 |     2019 |
+-----------------------+-------------+----------+
```
Devuelve un listado con el nombre de todos los departamentos que tienen
profesores que imparten alguna asignatura en el Grado en Ingeniería
Informática (Plan 2015).
```
SELECT DISTINCT d.nombre_departamento
FROM departamento d
INNER JOIN profesor p ON d.id_departamento = p.id_departamento
INNER JOIN curso c ON p.id_profesor = c.id_profesor
INNER JOIN grado g ON c.id_grado = g.id_grado
WHERE g.nombre_grado = 'Ingeniería Informática';
+----------------------------+
| nombre_departamento        |
+----------------------------+
| Departamento de Ciencias   |
| Departamento de Historia   |
| Departamento de Literatura |
+----------------------------+
```
6. Devuelve un listado con todos los alumnos que se han matriculado en
alguna asignatura durante el curso escolar 2018/2019.
```
SELECT e.primer_nombre_estudiante, e.segundo_nombre_estudiante, e.primer_apellido_estudiante, e.segundo_apellido_estudiante
FROM estudiante e
INNER JOIN curso_estudiante ce ON e.id_estudiante = ce.id_estudiante
INNER JOIN anio_escolar ae ON ce.id_anio_escolar = ae.id_anio_escolar
WHERE ae.anio_inicio = 2018 AND ae.anio_fin = 2019;

+--------------------------+---------------------------+----------------------------+-----------------------------+
| primer_nombre_estudiante | segundo_nombre_estudiante | primer_apellido_estudiante | segundo_apellido_estudiante |
+--------------------------+---------------------------+----------------------------+-----------------------------+
| Juan                     | José                      | Gómez                      | Pérez                       |
| María                    | Luisa                     | Martínez                   | González                    |
| Pedro                    | NULL                      | López                      | García                      |
| Ana                      | Sofía                     | Rodríguez                  | Hernández                   |
| Carolina                 | NULL                      | Díaz                       | Ramírez                     |
| Ana                      | María                     | González                   | López                       |
| Laura                    | Isabel                    | Sánchez                    | García                      |
| Marta                    | Elena                     | Fernández                  | Pérez                       |
| Fernando                 | Michaels                  | Draken                     | Ornn                        |
| Fernando                 | Michaels                  | Draken                     | Ornn                        |
| Fernando                 | Michaels                  | Draken                     | Ornn                        |
+--------------------------+---------------------------+----------------------------+-----------------------------+
```
Devuelve un listado con los nombres de todos los profesores y los
departamentos que tienen vinculados. El listado también debe mostrar
aquellos profesores que no tienen ningún departamento asociado. El listado
debe devolver cuatro columnas, nombre del departamento, primer apellido,
segundo apellido y nombre del profesor. El resultado estará ordenado
alfabéticamente de menor a mayor por el nombre del departamento,
apellidos y el nombre.
```
SELECT d.nombre_departamento, 
       p.primer_apellido_profesor, 
       p.segundo_apellido_profesor, 
       p.primer_nombre_profesor
FROM profesor p
LEFT JOIN departamento d ON p.id_departamento = d.id_departamento
ORDER BY d.nombre_departamento ASC,
         p.primer_apellido_profesor ASC,
         p.segundo_apellido_profesor ASC,
         p.primer_nombre_profesor ASC;
+------------------------------+--------------------------+---------------------------+------------------------+
| nombre_departamento          | primer_apellido_profesor | segundo_apellido_profesor | primer_nombre_profesor |
+------------------------------+--------------------------+---------------------------+------------------------+
| Departamento de Ciencias     | Martínez                 | López                     | María                  |
| Departamento de Historia     | Ramírez                  | García                    | Pedro                  |
| Departamento de Literatura   | López                    | Gómez                     | Ana                    |
| Departamento de Matemáticas  | González                 | Pérez                     | Juan                   |
| Departamento de Matemáticas  | Hernández                | Martínez                  | Luis                   |
+------------------------------+--------------------------+---------------------------+------------------------+
```
2. Devuelve un listado con los profesores que no están asociados a un
departamento.
```
SELECT p.primer_apellido_profesor, 
       p.segundo_apellido_profesor, 
       p.primer_nombre_profesor
FROM profesor p
LEFT JOIN departamento d ON p.id_departamento = d.id_departamento
WHERE d.id_departamento IS NULL;

```
3. Devuelve un listado con los departamentos que no tienen profesores
asociados.
```
SELECT d.nombre_departamento
FROM departamento d
LEFT JOIN profesor p ON d.id_departamento = p.id_departamento
WHERE p.id_profesor IS NULL;
+----------------------+
| nombre_departamento  |
+----------------------+
| Departamento de Arte |
+----------------------+
```
4. Devuelve un listado con los profesores que no imparten ninguna asignatura.
```
SELECT p.primer_apellido_profesor, p.segundo_apellido_profesor, p.primer_nombre_profesor
FROM profesor p
LEFT JOIN curso c ON p.id_profesor = c.id_profesor
WHERE c.id_curso IS NULL;

+--------------------------+---------------------------+------------------------+
| primer_apellido_profesor | segundo_apellido_profesor | primer_nombre_profesor |
+--------------------------+---------------------------+------------------------+
| Hernández                | Martínez                  | Luis                   |
+--------------------------+---------------------------+------------------------+
```
Devuelve un listado con las asignaturas que no tienen un profesor asignado.
```
SELECT nombre_curso
FROM curso
WHERE id_profesor IS NULL;

+-----------------------------------+
| nombre_curso                      |
+-----------------------------------+
| Física Avanzada                   |
| Inglés Avanzado                   |
| Hisotira Khant                    |
| Grado en Ingeniería Informática   |
+-----------------------------------+
```
Devuelve el número total de alumnas que hay.
```
SELECT COUNT(*) AS total_alumnas
FROM estudiante
WHERE id_genero = 'F';

+---------------+
| total_alumnas |
+---------------+
|             7 |
+---------------+
```

Calcula cuántos alumnos nacieron en 1999.
```
SELECT COUNT(*) AS total_alumnos_1999
FROM estudiante
WHERE YEAR(fecha_nacimiento) = 1999;

+--------------------+
| total_alumnos_1999 |
+--------------------+
|                  2 |
+--------------------+
```
3. Calcula cuántos profesores hay en cada departamento. El resultado sólo
debe mostrar dos columnas, una con el nombre del departamento y otra
con el número de profesores que hay en ese departamento. El resultado
sólo debe incluir los departamentos que tienen profesores asociados y
deberá estar ordenado de mayor a menor por el número de profesores.
```
SELECT d.nombre_departamento, COUNT(p.id_profesor) AS numero_profesores
FROM departamento d
LEFT JOIN profesor p ON d.id_departamento = p.id_departamento
GROUP BY d.nombre_departamento
HAVING COUNT(p.id_profesor) > 0
ORDER BY numero_profesores DESC;
+------------------------------+-------------------+
| nombre_departamento          | numero_profesores |
+------------------------------+-------------------+
| Departamento de Matemáticas  |                 2 |
| Departamento de Ciencias     |                 1 |
| Departamento de Historia     |                 1 |
| Departamento de Literatura   |                 1 |
+------------------------------+-------------------+
```
5. Devuelve un listado con todos los departamentos y el número de profesores
que hay en cada uno de ellos. Tenga en cuenta que pueden existir
departamentos que no tienen profesores asociados. Estos departamentos
también tienen que aparecer en el listado.
```
SELECT d.nombre_departamento, COUNT(p.id_profesor) AS numero_profesores
FROM departamento d
LEFT JOIN profesor p ON d.id_departamento = p.id_departamento
GROUP BY d.nombre_departamento;

+------------------------------+-------------------+
| nombre_departamento          | numero_profesores |
+------------------------------+-------------------+
| Departamento de Matemáticas  |                 2 |
| Departamento de Ciencias     |                 1 |
| Departamento de Historia     |                 1 |
| Departamento de Literatura   |                 1 |
| Departamento de Arte         |                 0 |
+------------------------------+-------------------+
```
7. Devuelve un listado con el nombre de todos los grados existentes en la base
de datos y el número de asignaturas que tiene cada uno. Tenga en cuenta
que pueden existir grados que no tienen asignaturas asociadas. Estos grados
también tienen que aparecer en el listado. El resultado deberá estar
ordenado de mayor a menor por el número de asignaturas.
```
SELECT g.nombre_grado, COUNT(c.id_curso) AS numero_asignaturas
FROM grado g
LEFT JOIN curso c ON g.id_grado = c.id_grado
GROUP BY g.nombre_grado
ORDER BY numero_asignaturas DESC;

+--------------------------+--------------------+
| nombre_grado             | numero_asignaturas |
+--------------------------+--------------------+
| Ingeniería Informática   |                  3 |
| Cuarto Grado             |                  2 |
| Quinto Grado             |                  2 |
| Septimo Grado            |                  2 |
| Primer Grado             |                  1 |
| Segundo Grado            |                  1 |
| Tercer Grado             |                  1 |
| Sexto Grado              |                  0 |
+--------------------------+--------------------+
```
6. Devuelve un listado con el nombre de todos los grados existentes en la base
de datos y el número de asignaturas que tiene cada uno, de los grados que
tengan más de 40 asignaturas asociadas.
```
SELECT g.nombre_grado, COUNT(c.id_curso) AS numero_asignaturas
FROM grado g
LEFT JOIN curso c ON g.id_grado = c.id_grado
GROUP BY g.nombre_grado
HAVING numero_asignaturas > 40;

Program did not output anything!
```
8. Devuelve un listado que muestre el nombre de los grados y la suma del
número total de créditos que hay para cada tipo de asignatura. El resultado
debe tener tres columnas: nombre del grado, tipo de asignatura y la suma
de los créditos de todas las asignaturas que hay de ese tipo. Ordene el
resultado de mayor a menor por el número total de crédidos.
```
SELECT g.nombre_grado, tc.nombre_tipo_curso, SUM(c.creditos) AS suma_creditos
FROM curso c
INNER JOIN tipo_curso tc ON c.id_tipo_curso = tc.id_tipo_curso
INNER JOIN grado g ON c.id_grado = g.id_grado
GROUP BY g.nombre_grado, tc.nombre_tipo_curso
ORDER BY suma_creditos DESC;

+--------------------------+-------------------+---------------+
| nombre_grado             | nombre_tipo_curso | suma_creditos |
+--------------------------+-------------------+---------------+
| Ingeniería Informática   | Matemáticas       |            11 |
| Primer Grado             | Matemáticas       |             3 |
| Cuarto Grado             | Matemáticas       |             3 |
| Segundo Grado            | Ciencias          |           2.5 |
| Septimo Grado            | Historia          |           2.5 |
| Quinto Grado             | Literatura        |           2.5 |
| Tercer Grado             | Historia          |             2 |
| Cuarto Grado             | Literatura        |             2 |
| Quinto Grado             | Arte              |           1.5 |
| Septimo Grado            | Matemáticas       |             0 |
+--------------------------+-------------------+---------------+
```
10. Devuelve un listado que muestre cuántos alumnos se han matriculado de
alguna asignatura en cada uno de los cursos escolares. El resultado deberá
mostrar dos columnas, una columna con el año de inicio del curso escolar y
otra con el número de alumnos matriculados.
```
SELECT YEAR(ce.creado_en) AS anio_escolar, COUNT(ce.id_estudiante) AS num_alumnos_matriculados
FROM curso_estudiante ce
GROUP BY YEAR(ce.creado_en)
ORDER BY anio_escolar;

+--------------+--------------------------+
| anio_escolar | num_alumnos_matriculados |
+--------------+--------------------------+
|         2015 |                        6 |
|         2023 |                        5 |
+--------------+--------------------------+
```
12. Devuelve un listado con el número de asignaturas que imparte cada
profesor. El listado debe tener en cuenta aquellos profesores que no
imparten ninguna asignatura. El resultado mostrará cinco columnas: id,
nombre, primer apellido, segundo apellido y número de asignaturas. El
resultado estará ordenado de mayor a menor por el número de asignaturas.
```
SELECT p.id_profesor, p.primer_nombre_profesor, p.primer_apellido_profesor, p.segundo_apellido_profesor,
       COUNT(c.id_curso) AS num_asignaturas
FROM profesor p
LEFT JOIN curso c ON p.id_profesor = c.id_profesor
GROUP BY p.id_profesor
ORDER BY num_asignaturas DESC;

+-------------+------------------------+--------------------------+---------------------------+-----------------+
| id_profesor | primer_nombre_profesor | primer_apellido_profesor | segundo_apellido_profesor | num_asignaturas |
+-------------+------------------------+--------------------------+---------------------------+-----------------+
|           2 | María                  | Martínez                 | López                     |               4 |
|           1 | Juan                   | González                 | Pérez                     |               2 |
|           3 | Pedro                  | Ramírez                  | García                    |               1 |
|           4 | Ana                    | López                    | Gómez                     |               1 |
|           5 | Luis                   | Hernández                | Martínez                  |               0 |
+-------------+------------------------+--------------------------+---------------------------+-----------------+
```

Subconsultas


1. Devuelve todos los datos del alumno más joven.
```
SELECT *
FROM estudiante
ORDER BY fecha_nacimiento DESC
LIMIT 1;

+---------------+----------------+--------------------------+---------------------------+----------------------------+-----------------------------+-----------+------------------+--------+
| id_estudiante | nit_estudiante | primer_nombre_estudiante | segundo_nombre_estudiante | primer_apellido_estudiante | segundo_apellido_estudiante | id_genero | fecha_nacimiento | activo |
+---------------+----------------+--------------------------+---------------------------+----------------------------+-----------------------------+-----------+------------------+--------+
|             4 | 6789012345     | Ana                      | Sofía                     | Rodríguez                  | Hernández                   | F         | 2007-02-28       |      1 |
+---------------+----------------+--------------------------+---------------------------+----------------------------+-----------------------------+-----------+------------------+--------+
```
2. Devuelve un listado con los profesores que no están asociados a un
departamento.
```
SELECT p.primer_apellido_profesor, p.segundo_apellido_profesor, p.primer_nombre_profesor
FROM profesor p
LEFT JOIN departamento d ON p.id_departamento = d.id_departamento
WHERE d.id_departamento IS NULL;

Program did not output anything!
```
4. Devuelve un listado con los departamentos que no tienen profesores
asociados.
```
SELECT d.nombre_departamento
FROM departamento d
LEFT JOIN profesor p ON d.id_departamento = p.id_departamento
WHERE p.id_departamento IS NULL;

+----------------------+
| nombre_departamento  |
+----------------------+
| Departamento de Arte |
+----------------------+
```
6. Devuelve un listado con los profesores que tienen un departamento
asociado y que no imparten ninguna asignatura.
```
SELECT p.primer_apellido_profesor, p.segundo_apellido_profesor, p.primer_nombre_profesor, d.nombre_departamento
FROM profesor p
INNER JOIN departamento d ON p.id_departamento = d.id_departamento
LEFT JOIN curso c ON p.id_profesor = c.id_profesor
WHERE c.id_curso IS NULL;

+--------------------------+---------------------------+------------------------+------------------------------+
| primer_apellido_profesor | segundo_apellido_profesor | primer_nombre_profesor | nombre_departamento          |
+--------------------------+---------------------------+------------------------+------------------------------+
| Hernández                | Martínez                  | Luis                   | Departamento de Matemáticas  |
+--------------------------+---------------------------+------------------------+------------------------------+
```
8. Devuelve un listado con las asignaturas que no tienen un profesor asignado.
```
SELECT c.id_curso, c.nombre_curso
FROM curso c
LEFT JOIN profesor p ON c.id_profesor = p.id_profesor
WHERE c.id_profesor IS NULL;

+----------+-----------------------------------+
| id_curso | nombre_curso                      |
+----------+-----------------------------------+
|        6 | Física Avanzada                   |
|        7 | Inglés Avanzado                   |
|        8 | Hisotira Khant                    |
|        9 | Grado en Ingeniería Informática   |
+----------+-----------------------------------+
```
