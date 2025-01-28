USE EscuelaDB;

CREATE TABLE HorarioAct (
    HorarioAct_ID INT PRIMARY KEY,
    HA_Dia VARCHAR(50),
    HA_Inicio TIME,
    HA_Fin TIME
);

CREATE TABLE Actividad (
    Act_ID INT PRIMARY KEY,
    Act_Nombre VARCHAR(50),
	Act_Descripcion VARCHAR(50),
	Act_lugar VARCHAR (50),
	Act_cupo INT,
    HorarioAct_ID INT,
    FOREIGN KEY (HorarioAct_ID) REFERENCES HorarioAct(HorarioAct_ID)
);

CREATE TABLE HorarioEst (
    HorarioEst_ID INT PRIMARY KEY,
    HE_Inicio TIME,
    HE_Fin TIME
);

CREATE TABLE Estudiante (
    Est_ID INT PRIMARY KEY,
    Est_Nombre VARCHAR(100),
    Est_Turno VARCHAR(50),
    Est_Semestre INT,
    Est_Sexo CHAR(1),
    Est_FechaNacimiento DATE,
    HorarioEst_ID INT,
    Est_Direccion VARCHAR(100),
    Est_Telefono VARCHAR(15),
    Est_correo VARCHAR(50)
	FOREIGN KEY (HorarioEst_ID) REFERENCES HorarioEst(HorarioEst_ID)
);


CREATE TABLE ActTrans (
    ActTrans_ID INT PRIMARY KEY IDENTITY,
    Est_ID INT,
	Act_Selec VARCHAR(50),
	FOREIGN KEY (Est_ID) REFERENCES Estudiante(Est_ID)
);


CREATE TABLE Usuarios (
    Usuario_Id INT PRIMARY KEY IDENTITY,
    Username INT NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
	IsAdmin BIT NOT NULL DEFAULT 0,
	Est_ID INT,
    FOREIGN KEY (Est_ID) REFERENCES Estudiante(Est_ID)
);


INSERT INTO HorarioAct (HorarioAct_ID, HA_Dia, HA_Inicio, HA_Fin)
VALUES 
(1, 'Lunes', '10:00', '12:00'),
(2, 'Martes', '09:00', '11:00'),
(3, 'Miércoles', '09:00', '12:00'),
(4, 'Jueves', '16:00', '19:00'),
(5, 'Viernes', '17:00', '19:00'),
(6, 'Sábado', '08:00', '13:00'),
(7, 'Sábado', '14:00', '18:00');

SELECT * FROM HorarioAct;

INSERT INTO HorarioEst (HorarioEst_ID, HE_Inicio, HE_Fin)
VALUES 
(1, '07:00', '13:00'),
(2, '16:00', '22:00');

SELECT * FROM HorarioEst;


INSERT INTO Actividad (Act_ID, Act_Nombre, Act_Descripcion, Act_lugar, Act_cupo, HorarioAct_ID)
VALUES 
(1, 'Fútbol', 'Actividad deportiva', 'Campo deportivo municipal', 30, 4),
(2, 'Basketball', 'Actividad deportiva', 'Cancha deportiva municipal', 30, 5),
(3, 'Folklore', 'Actividad cultural', 'Cancha escolar', 30, 6),
(4, 'Pintura', 'Actividad cultural', 'Campo deportivo municipal', 30, 1),
(5, 'Atletismo', 'Actividad deportiva', 'Campo deportivo municipal', 30, 4),
(6, 'Ajedrez', 'Actividad deportiva', 'Sala audiovisual', 30, 2),
(7, 'Danza contemporanea', 'Actividad cultural', 'Salón principal', 30, 3),
(8, 'Volleyball', 'Actividad deportiva', 'Cancha escolar', 30, 2),
(9, 'Beisbol', 'Actividad deportiva', 'Cancha municipal', 30, 6),
(10, 'Natacion', 'Actividad deportiva', 'Alberca escolar', 30, 7);

SELECT * FROM Actividad;

INSERT INTO Estudiante (Est_ID, Est_Nombre, Est_Turno, Est_Semestre, Est_Sexo, Est_FechaNacimiento, HorarioEst_ID, Est_Direccion, Est_Telefono, Est_correo)
VALUES 
(2020301251, 'Yaretzi Metodio Reyes', 'Matutino', 5, 'M', '2007-01-15', 1, 'Calle Boulevard principal', '933-123-4567', 'metodioyar@gmail.com'),
(2020301252, 'María Belén Suárez Flores', 'Matutino', 1, 'F', '2009-09-25', 1, 'Calle 5 de Mayo', '933-234-5678', 'belenflores2909@gmail.com'),
(2020301253, 'Yolanda Villalobos Graniel', 'Vespertino', 6, 'M', '2006-07-10', 2, 'Calle Melchor Ocampo', '933-345-6789', 'yol2vg@gmail.com'),
(2020301254, 'Nayeli Michel Hernandez', 'Vespertino', 4, 'M', '2007-11-30', 2, 'Calle Gutierrez Zamora', '933-456-7890', 'nayelimichel1801@gmail.com'),
(2020301255, 'Marissa Fontes de la Cruz', 'Matutino', 5, 'F', '2007-05-20', 1, 'Calle Galeana', '933-567-8901', 'marissafontes.24@gmail.com'),
(2020301256, 'Miguelin Suarez Alejandro', 'Vespertino', 2, 'F', '2009-03-14', 2, 'Calle Regino Hernandez', '933-678-9012', 'misuaral@gmail.com'),
(2020301257, 'Giovanni Suarez Flores', 'Matutino', 3, 'F', '2008-08-22', 1, 'Calle Mendez', '933-789-0123', 'prefeco15@gmail.com'),
(2020301258, 'Jose Fernando Murillo Rodriguez', 'Vespertino', 4, 'F', '2008-10-19', 2, 'Calle Prolongacion', '933-890-1234', 'jfmurillo.jfmr@gmail.com'),
(2020301259, 'Carlos Macías Pulido', 'Matutino', 1, 'M', '2009-12-01', 1, 'Calle Arboledas', '933-901-2345', 'carlosmaciasp20@gmail.com'),
(2020301260, 'Angel Macías Pulido', 'Vespertino', 2, 'M', '2009-06-11', 2,'Calle 20 de Noviembre', '933-012-3456', 'angelgabrielmaciaspulido@gmail.com');

SELECT * FROM Estudiante;
SELECT * FROM Usuarios;
SELECT * FROM ActTrans;
SELECT * FROM HorarioAct;

SELECT 
    E.Est_correo AS Correo,
    E.Est_Turno AS Turno,
    A.Act_cupo AS Cupo,
    A.Act_Nombre AS Actividad,
    HA.HA_Dia AS Dia_Actividad,
    HA.HA_Inicio AS Hora_Inicio,
    HA.HA_Fin AS Hora_Fin
FROM 
    Estudiante E
JOIN 
    Usuarios U ON E.Est_ID = U.Est_ID
JOIN 
    Actividad A ON A.Act_Nombre = 'Fútbol' -- Cambia por la actividad deseada
JOIN 
    HorarioAct HA ON A.HorarioAct_ID = HA.HorarioAct_ID
WHERE 
    E.Est_ID = 2020301252;


SELECT 
    E.Est_correo AS Correo,
    E.Est_Turno AS Turno,
    A.Act_Nombre AS Actividad,
    A.Act_cupo AS Cupo,
    HA.HA_Dia AS Dia_Actividad,
    HA.HA_Inicio AS Hora_Inicio,
    HA.HA_Fin AS Hora_Fin
FROM 
    Estudiante E
JOIN 
    Usuarios U ON E.Est_ID = U.Est_ID
JOIN 
    ActTrans AT ON E.Est_ID = AT.Est_ID
JOIN 
    Actividad A ON A.Act_Nombre = AT.Act_Selec
JOIN 
    HorarioAct HA ON A.HorarioAct_ID = HA.HorarioAct_ID
WHERE 
    E.Est_ID = 2020301252;





















-- Crear login
CREATE LOGIN [12345678] WITH PASSWORD = 'adminpassword';
GO

-- Crear usuario para el login
CREATE USER [12345678] FOR LOGIN [12345678];
GO

-- Insertar usuario administrador con hash en hexadecimal
INSERT INTO Usuarios (Username, PasswordHash, IsAdmin)
VALUES ('12345678', CONVERT(NVARCHAR(255), HASHBYTES('SHA2_256', 'adminpassword'), 2), 1);



-- Otorgar permisos de SELECT, INSERT, UPDATE, DELETE en la tabla Usuarios al usuario administrador
GRANT SELECT, INSERT, UPDATE, DELETE ON Usuarios TO [12345678];

-- Verificar que el admi se registró correctamente
SELECT Username, PasswordHash, IsAdmin FROM Usuarios WHERE Username = 12345678;

-- Verificar que los servicios se otorgaron correctamente
SELECT 
    dp.name AS DatabaseRoleName, 
    dp2.name AS MemberName, 
    perm.permission_name, 
    perm.state_desc
FROM 
    sys.database_permissions AS perm
JOIN 
    sys.database_principals AS dp ON perm.grantee_principal_id = dp.principal_id
JOIN 
    sys.database_principals AS dp2 ON dp.principal_id = dp2.principal_id
WHERE 
    dp2.name = '12345678' AND perm.class_desc = 'OBJECT_OR_COLUMN' AND perm.major_id = OBJECT_ID('Usuarios');