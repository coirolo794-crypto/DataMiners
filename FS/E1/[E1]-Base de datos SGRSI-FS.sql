CREATE DATABASE Dataminers;

CREATE TABLE ITI (
    id_iti           INT PRIMARY KEY AUTO_INCREMENT,
    nombre           VARCHAR(100) NOT NULL,
    ubicacion_fisica VARCHAR(150) NOT NULL
);

CREATE TABLE Ubicacion (
    id_ubicacion INT PRIMARY KEY AUTO_INCREMENT,
    id_iti       INT NOT NULL,
    tipo         VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_iti) REFERENCES ITI(id_iti)
);

CREATE TABLE Laboratorio (
    id_laboratorio INT PRIMARY KEY AUTO_INCREMENT,
    id_ubicacion   INT NOT NULL UNIQUE,
    FOREIGN KEY (id_ubicacion) REFERENCES Ubicacion(id_ubicacion)
);

CREATE TABLE Salon (
    id_salon     INT PRIMARY KEY AUTO_INCREMENT,
    id_ubicacion INT NOT NULL UNIQUE,
    FOREIGN KEY (id_ubicacion) REFERENCES Ubicacion(id_ubicacion)
);

CREATE TABLE Administracion (
    id_administracion INT PRIMARY KEY AUTO_INCREMENT,
    id_ubicacion      INT NOT NULL UNIQUE,
    FOREIGN KEY (id_ubicacion) REFERENCES Ubicacion(id_ubicacion)
);

CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nombre     VARCHAR(80) NOT NULL,
    apellido   VARCHAR(80) NOT NULL,
    telefono   VARCHAR(20),
    email      VARCHAR(120) NOT NULL UNIQUE
);

CREATE TABLE Equipo (
    id_equipo    INT PRIMARY KEY AUTO_INCREMENT,
    id_ubicacion INT NOT NULL,
    modulo       VARCHAR(50),
    estado       VARCHAR(30) NOT NULL,
    fecha_ingr   DATE NOT NULL,
    marca        VARCHAR(50),
    nro_serie    VARCHAR(50) NOT NULL UNIQUE,
    FOREIGN KEY (id_ubicacion) REFERENCES Ubicacion(id_ubicacion)
);

CREATE TABLE Mantenimiento (
    id_mantenimiento INT PRIMARY KEY AUTO_INCREMENT,
    id_equipo        INT NOT NULL,
    descripcion      VARCHAR(255),
    costo            DECIMAL(10,2),
    tipo             VARCHAR(50),
    fecha_ini        DATE NOT NULL,
    fecha_fin        DATE,
    FOREIGN KEY (id_equipo) REFERENCES Equipo(id_equipo)
);

CREATE TABLE Historial (
    id_historial       INT PRIMARY KEY AUTO_INCREMENT,
    id_equipo          INT NOT NULL,
    fecha_evento       DATETIME NOT NULL,
    tipo_evento        VARCHAR(50) NOT NULL,
    descripcion_evento VARCHAR(255),
    FOREIGN KEY (id_equipo) REFERENCES Equipo(id_equipo)
);

CREATE TABLE Categoria (
    id_categoria     INT PRIMARY KEY AUTO_INCREMENT,
    nombre_categoria VARCHAR(80) NOT NULL,
    descripcion      VARCHAR(255)
);

CREATE TABLE Incidencia (
    id_incidencia INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario    INT NOT NULL,
    id_categoria  INT NOT NULL,
    id_equipo     INT,
    titulo        VARCHAR(120) NOT NULL,
    estado        VARCHAR(30) NOT NULL,
    prioridad     VARCHAR(20) NOT NULL,
    descripcion   VARCHAR(500),
    apertura      DATETIME NOT NULL,
    cierre        DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_categoria) REFERENCES Categoria(id_categoria),
    FOREIGN KEY (id_equipo) REFERENCES Equipo(id_equipo)
);

CREATE TABLE Comentario (
    id_comentario INT PRIMARY KEY AUTO_INCREMENT,
    id_incidencia INT NOT NULL,
    id_usuario    INT NOT NULL,
    contenido     VARCHAR(500) NOT NULL,
    FOREIGN KEY (id_incidencia) REFERENCES Incidencia(id_incidencia),
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

CREATE TABLE Prestamo (
    id_prestamo   INT PRIMARY KEY AUTO_INCREMENT,
    id_usuario    INT NOT NULL,
    id_equipo     INT NOT NULL,
    motivo        VARCHAR(200),
    f_prestamo    DATE NOT NULL,
    f_devolucion  DATE,
    estado        VARCHAR(30) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario),
    FOREIGN KEY (id_equipo) REFERENCES Equipo(id_equipo)
);