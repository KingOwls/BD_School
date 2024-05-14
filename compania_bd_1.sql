CREATE TABLE `tipo_curso` (
  `id_tipo_curso` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo_curso` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_tipo_curso`))
ENGINE = InnoDB;

CREATE TABLE `departamento` (
  `id_departamento` INT NOT NULL,
  `nombre_departamento` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`id_departamento`))
ENGINE = InnoDB;

CREATE TABLE `profesor` (
  `id_profesor` INT NOT NULL,
  `nit_profesor` VARCHAR(10) NULL DEFAULT NULL,
  `primer_nombre_profesor` VARCHAR(50) NULL DEFAULT NULL,
  `segundo_nombre_profesor` VARCHAR(50) NULL DEFAULT NULL,
  `primer_apellido_profesor` VARCHAR(50) NULL DEFAULT NULL,
  `segundo_apellido_profesor` VARCHAR(50) NULL DEFAULT NULL,
  `id_genero` VARCHAR(5) NOT NULL,
  `id_departamento` INT NOT NULL,
  `fecha_nacimiento` DATE NULL DEFAULT NULL,
  `activo` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`id_profesor`),
  INDEX `fk_profesor_departamento1_idx` (`id_departamento` ASC) VISIBLE,
  CONSTRAINT `fk_profesor_departamento1`
    FOREIGN KEY (`id_departamento`)
    REFERENCES `departamento` (`id_departamento`)
) ENGINE = InnoDB;

CREATE TABLE `direccion_profesor` (
  `id_direccion_profesor` INT(10) NOT NULL AUTO_INCREMENT,
  `linea_direccion_1` VARCHAR(45) NULL DEFAULT NULL,
  `linea_direccion_2` VARCHAR(45) NULL DEFAULT NULL,
  `tipo_direccion` VARCHAR(45) NULL DEFAULT NULL,
  `id_profesor` INT NOT NULL,
  `nombre_ciudad` VARCHAR(45) NULL,
  PRIMARY KEY (`id_direccion_profesor`)
) ENGINE = InnoDB;

CREATE TABLE `grado` (
  `id_grado` INT NOT NULL,
  `nombre_grado` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`id_grado`))
ENGINE = InnoDB;

CREATE TABLE `curso` (
  `id_curso` INT NOT NULL,
  `nombre_curso` VARCHAR(100) NULL DEFAULT NULL,
  `creditos` FLOAT NULL DEFAULT NULL,
  `periodo_cuatro_meses` TINYINT NULL DEFAULT NULL,
  `id_profesor` INT NULL,
  `id_grado` INT NOT NULL,
  `curso` TINYINT NULL DEFAULT NULL,
  `id_tipo_curso` INT NOT NULL,
  PRIMARY KEY (`id_curso`),
  INDEX `fk_curso_profesor1_idx` (`id_profesor` ASC) VISIBLE,
  INDEX `fk_curso_grado1_idx` (`id_grado` ASC) VISIBLE,
  INDEX `fk_curso_tipo_curso1_idx` (`id_tipo_curso` ASC) VISIBLE,
  CONSTRAINT `fk_curso_grado1`
    FOREIGN KEY (`id_grado`)
    REFERENCES `grado` (`id_grado`),
  CONSTRAINT `fk_curso_profesor1`
    FOREIGN KEY (`id_profesor`)
    REFERENCES `profesor` (`id_profesor`),
  CONSTRAINT `fk_curso_tipo_curso1`
    FOREIGN KEY (`id_tipo_curso`)
    REFERENCES `tipo_curso` (`id_tipo_curso`))
ENGINE = InnoDB;

CREATE TABLE `anio_escolar` (
  `id_anio_escolar` INT NOT NULL,
  `anio_inicio` YEAR NULL DEFAULT NULL,
  `anio_fin` YEAR NULL DEFAULT NULL,
  PRIMARY KEY (`id_anio_escolar`))
ENGINE = InnoDB;

CREATE TABLE `estudiante` (
  `id_estudiante` INT NOT NULL,
  `nit_estudiante` VARCHAR(10) NULL DEFAULT NULL,
  `primer_nombre_estudiante` VARCHAR(50) NULL DEFAULT NULL,
  `segundo_nombre_estudiante` VARCHAR(50) NULL DEFAULT NULL,
  `primer_apellido_estudiante` VARCHAR(50) NULL DEFAULT NULL,
  `segundo_apellido_estudiante` VARCHAR(50) NULL DEFAULT NULL,
  `id_genero` VARCHAR(5) NOT NULL,
  `fecha_nacimiento` DATE NULL DEFAULT NULL,
  `activo` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`id_estudiante`)
) ENGINE = InnoDB;

CREATE TABLE  `curso_estudiante` (
  `id_estudiante` INT NOT NULL,
  `id_curso` INT NOT NULL,
  `id_anio_escolar` INT NOT NULL,
  `activo` TINYINT NULL DEFAULT '1',
  `creado_en` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_curso_estudiante_estudiante1_idx` (`id_estudiante` ASC) VISIBLE,
  INDEX `fk_curso_estudiante_curso1_idx` (`id_curso` ASC) VISIBLE,
  INDEX `fk_curso_estudiante_anio_escolar1_idx` (`id_anio_escolar` ASC) VISIBLE,
  CONSTRAINT `PK_curso_estudiante` PRIMARY KEY (id_estudiante, id_curso, id_anio_escolar),
  CONSTRAINT `fk_curso_estudiante_curso1`
    FOREIGN KEY (`id_curso`)
    REFERENCES `curso` (`id_curso`),
  CONSTRAINT `fk_curso_estudiante_anio_escolar1`
    FOREIGN KEY (`id_anio_escolar`)
    REFERENCES `anio_escolar` (`id_anio_escolar`),
  CONSTRAINT `fk_curso_estudiante_estudiante1`
    FOREIGN KEY (`id_estudiante`)
    REFERENCES `estudiante` (`id_estudiante`))
ENGINE = InnoDB;

CREATE TABLE  `numero_telefono_estudiante` (
  `id_numero_telefono_estudiante` INT(10) NOT NULL AUTO_INCREMENT,
  `numero_telefono` VARCHAR(45) NULL DEFAULT NULL,
  `tipo_numero_telefono` VARCHAR(45) NULL DEFAULT NULL,
  `nombre_numero_telefono` VARCHAR(45) NULL DEFAULT NULL,
  `id_estudiante` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_numero_telefono_estudiante`),
  INDEX `fk_numero_telefono_estudiante_estudiante1_idx` (`id_estudiante` ASC) VISIBLE,
  CONSTRAINT `fk_numero_telefono_estudiante_estudiante1`
    FOREIGN KEY (`id_estudiante`)
    REFERENCES `estudiante` (`id_estudiante`))
ENGINE = InnoDB;

CREATE TABLE  `numero_telefono_profesor` (
  `id_numero_telefono_profesor` INT(10) NOT NULL AUTO_INCREMENT,
  `numero_telefono` VARCHAR(45) NULL DEFAULT NULL,
  `tipo_numero_telefono` VARCHAR(45) NULL DEFAULT NULL,
  `nombre_numero_telefono` VARCHAR(45) NULL DEFAULT NULL,
  `id_profesor` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_numero_telefono_profesor`),
  INDEX `fk_numero_telefono_profesor_profesor1_idx` (`id_profesor` ASC) VISIBLE,
  CONSTRAINT `fk_numero_telefono_profesor_profesor1`
    FOREIGN KEY (`id_profesor`)
    REFERENCES `profesor` (`id_profesor`))
ENGINE = InnoDB;

CREATE TABLE  `direccion_estudiante` (
  `id_direccion_estudiante` INT(10) NOT NULL AUTO_INCREMENT,
  `linea_direccion_1` VARCHAR(45) NULL DEFAULT NULL,
  `linea_direccion_2` VARCHAR(45) NULL DEFAULT NULL,
  `tipo_direccion` VARCHAR(45) NULL DEFAULT NULL,
  `id_estudiante` INT NULL DEFAULT NULL,
  `nombre_ciudad` VARCHAR(45) NULL,
  PRIMARY KEY (`id_direccion_estudiante`)
) ENGINE = InnoDB;

INSERT INTO tipo_curso (nombre_tipo_curso) VALUES 
('Matemáticas'),
('Ciencias'),
('Historia'),
('Literatura'),
('Arte');

INSERT INTO departamento (id_departamento, nombre_departamento) VALUES 
(1, 'Departamento de Matemáticas'),
(2, 'Departamento de Ciencias'),
(3, 'Departamento de Historia'),
(4, 'Departamento de Literatura'),
(5, 'Departamento de Arte');

INSERT INTO profesor (id_profesor, nit_profesor, primer_nombre_profesor, segundo_nombre_profesor, primer_apellido_profesor, segundo_apellido_profesor, id_genero, id_departamento, fecha_nacimiento, activo) VALUES 
(1, '1234567890', 'Juan', 'Carlos', 'González', 'Pérez', 'M', 1, '1980-05-15', 1),
(2, '0987654321', 'María', 'Elena', 'Martínez', 'López', 'F', 2, '1975-10-20', 1),
(3, '5678901234', 'Pedro', NULL, 'Ramírez', 'García', 'M', 3, '1988-02-03', 1);

INSERT INTO profesor (id_profesor, nit_profesor, primer_nombre_profesor, segundo_nombre_profesor, primer_apellido_profesor, segundo_apellido_profesor, id_genero, id_departamento, fecha_nacimiento, activo) VALUES 
(4, '123456789K', 'Ana', 'María', 'López', 'Gómez', 'F', 4, '1978-09-12', 1),
(5, '987654321K', 'Luis', NULL, 'Hernández', 'Martínez', 'M', 1, '1982-04-25', 1);


INSERT INTO direccion_profesor (linea_direccion_1, linea_direccion_2, tipo_direccion, id_profesor, nombre_ciudad) VALUES 
('Calle Principal 123', 'Edificio A, Apartamento 101', 'Residencial', 1, 'Ciudad A'),
('Avenida Central 456', NULL, 'Oficina', 2, 'Ciudad B'),
('Carrera 7 Este 789', 'Conjunto Residencial Los Pinos, Casa 3', 'Residencial', 3, 'Ciudad C');

INSERT INTO grado (id_grado, nombre_grado) VALUES 
(1, 'Primer Grado'),
(2, 'Segundo Grado'),
(3, 'Tercer Grado'),
(4, 'Cuarto Grado'),
(5, 'Quinto Grado'),
(6, 'Sexto Grado'),
(8, 'Ingeniería Informática'),
(7, 'Septimo Grado');

INSERT INTO curso (id_curso, nombre_curso, creditos, periodo_cuatro_meses, id_profesor, id_grado, curso, id_tipo_curso) VALUES 
(1, 'Matemáticas Básicas', 3.0, 1, 1, 1, 1, 1),
(2, 'Ciencias Naturales', 2.5, 1, 2, 2, 1, 2),
(3, 'Historia Antigua', 2.0, 1, 2, 3, 1, 3),
(4, 'Literatura Mundial', 2.0, 1, 1, 4, 1, 4),
(5, 'Arte Contemporáneo', 1.5, 1, 2, 5, 1, 5);

INSERT INTO curso (id_curso, nombre_curso, creditos, periodo_cuatro_meses, id_profesor, id_grado, curso, id_tipo_curso) VALUES 
(6, 'Física Avanzada', 3.0, 1, NULL, 4, 1, 1),
(7, 'Inglés Avanzado', 2.5, 1, NULL, 5, 3, 4),
(8, 'Hisotira Khant', 2.5, 1, NULL, 7, 3, 3);


INSERT INTO anio_escolar (id_anio_escolar, anio_inicio, anio_fin) VALUES 
(1, 2018, 2019),
(2, 2019, 2020),
(3, 2020, 2021),
(4, 2021, 2022),
(5, 2022, 2023),
(6, 2023, 2024),
(7, 2024, 2025),
(8, 2025, 2026),
(9, 2026, 2027),
(10, 2027, 2028);

INSERT INTO estudiante (id_estudiante, nit_estudiante, primer_nombre_estudiante, segundo_nombre_estudiante, primer_apellido_estudiante, segundo_apellido_estudiante, id_genero, fecha_nacimiento, activo) VALUES 
(1, '1234567890', 'Juan', 'José', 'Gómez', 'Pérez', 'M', '2005-03-15', 1),
(2, '0987654321', 'María', 'Luisa', 'Martínez', 'González', 'F', '2006-07-20', 1),
(3, '5678901234', 'Pedro', NULL, 'López', 'García', 'M', '2004-11-10', 1),
(4, '6789012345', 'Ana', 'Sofía', 'Rodríguez', 'Hernández', 'F', '2007-02-28', 1),
(5, '3456789012', 'Carolina', NULL, 'Díaz', 'Ramírez', 'F', '2005-09-03', 1);

INSERT INTO curso_estudiante (id_estudiante, id_curso, id_anio_escolar, activo, creado_en, actualizado_en) VALUES 
(1, 1, 1, 1, '2023-09-01', '2023-09-01'),
(2, 1, 1, 1, '2023-09-01', '2023-09-01'),
(3, 2, 1, 1, '2023-09-01', '2023-09-01'),
(4, 2, 1, 1, '2023-09-01', '2023-09-01'),
(5, 3, 1, 1, '2023-09-01', '2023-09-01');

INSERT INTO numero_telefono_estudiante (numero_telefono, tipo_numero_telefono, nombre_numero_telefono, id_estudiante) VALUES
('123456789', 'Personal', 'Teléfono Principal', 1),
('987654321', 'Trabajo', 'Teléfono Secundario', 1),
('555666777', 'Personal', 'Teléfono Principal', 2),
('999888777', 'Casa', 'Teléfono Casa', 2),
('111222333', 'Trabajo', 'Teléfono Oficina', 3);

INSERT INTO numero_telefono_profesor (numero_telefono, tipo_numero_telefono, nombre_numero_telefono, id_profesor) VALUES
('123456789', 'Personal', 'Teléfono Principal', 1),
('987654321', 'Trabajo', 'Teléfono Secundario', 1),
('555666777', 'Personal', 'Teléfono Principal', 2),
('999888777', 'Casa', 'Teléfono Casa', 2),
('111222333', 'Trabajo', 'Teléfono Oficina', 3);

INSERT INTO direccion_estudiante (linea_direccion_1, linea_direccion_2, tipo_direccion, id_estudiante, nombre_ciudad) VALUES
('Calle 123', 'Barrio Nuevo', 'Residencial', 1, 'Ciudad A'),
('Avenida Principal', 'Urbanización Bella Vista', 'Residencial', 2, 'Ciudad B'),
('Carrera 45', 'Condominio Las Flores', 'Residencial', 3, 'Ciudad C'),
('Calle 67', 'Sector Las Acacias', 'Residencial', 4, 'Ciudad D'),
('Avenida Sur', 'Conjunto Residencial Las Palmas', 'Residencial', 5, 'Ciudad E');

INSERT INTO estudiante (id_estudiante, nit_estudiante, primer_nombre_estudiante, segundo_nombre_estudiante, primer_apellido_estudiante, segundo_apellido_estudiante, id_genero, fecha_nacimiento, activo) VALUES 
(6, '4567890123', 'Luis', 'Miguel', 'Gutiérrez', 'López', 'M', '1999-05-10', 1),
(7, '2345678901', 'Fernanda', 'Isabel', 'Vargas', 'Martínez', 'F', '1999-11-15', 1);

INSERT INTO estudiante (id_estudiante, nit_estudiante, primer_nombre_estudiante, segundo_nombre_estudiante, primer_apellido_estudiante, segundo_apellido_estudiante, id_genero, fecha_nacimiento, activo) VALUES 
(8, '0987654321', 'Ana', 'María', 'González', 'López', 'F', '2000-03-20', 1),
(9, '9876543210', 'Laura', 'Isabel', 'Sánchez', 'García', 'F', '2000-07-05', 1),
(10, '8765432109', 'Marta', 'Elena', 'Fernández', 'Pérez', 'F', '2000-11-10', 1),
(11, '26902806M', 'Fernando', 'Michaels', 'Draken', 'Ornn', 'M', '2000-11-10', 1);

INSERT INTO curso (id_curso, nombre_curso, creditos, periodo_cuatro_meses, id_profesor, id_grado, curso, id_tipo_curso) 
VALUES (9, 'Grado en Ingeniería Informática', 0, 1, NULL, 7, 1, 1);

INSERT INTO curso_estudiante (id_estudiante, id_curso, id_anio_escolar, activo, creado_en, actualizado_en) 
VALUES 
(8, 9, 1, 1, '2015-09-01', '2015-09-01'),
(9, 9, 1, 1, '2015-09-01', '2015-09-01'),
(10, 9, 1, 1, '2015-09-01', '2015-09-01');

INSERT INTO curso_estudiante (id_estudiante, id_curso, id_anio_escolar, activo, creado_en, actualizado_en) 
VALUES 
(11, 1, 1, 1, '2015-09-01', '2015-09-01'),
(11, 2, 1, 1, '2015-09-01', '2015-09-01'),
(11, 3, 1, 1, '2015-09-01', '2015-09-01');

INSERT INTO curso (id_curso, nombre_curso, creditos, periodo_cuatro_meses, id_profesor, id_grado, curso, id_tipo_curso) VALUES 
(10, 'Introducción a la Ingeniería de Sistemas', 3.0, 1, 2, 8, 1, 1),
(11, 'Algoritmos y Estructuras de Datos', 4.0, 1, 3, 8, 1, 1),
(12, 'Programación Orientada a Objetos', 4.0, 1, 4, 8, 1, 1);
