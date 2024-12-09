-- Crear la base de datos
CREATE DATABASE SistemaReservas;
GO

USE SistemaReservas;
GO

-- Tabla Empresas
CREATE TABLE Empresas (
    NIT INT NOT NULL PRIMARY KEY,
    Nombre CHAR(100) NOT NULL,
    Logo VARBINARY(MAX) NOT NULL,
    UbicacionLogo CHAR(200) NOT NULL
);

-- Tabla Usuario
CREATE TABLE Usuario (
    Documento INT NOT NULL PRIMARY KEY,
    Nombres CHAR(100) NOT NULL,
    Apellido CHAR(100) NOT NULL,
    Telefono INT NOT NULL,
    Direccion CHAR(100) NOT NULL,
    Contrasena CHAR(50) NOT NULL,
    Penalizacion INT NOT NULL,
    Estado BIT NOT NULL,
    Tipo INT NOT NULL,
    Empresa INT NOT NULL,
	Administrador bit NOT NULL,
    CONSTRAINT FK_Usuario_Empresas FOREIGN KEY (Empresa) REFERENCES Empresas(NIT)
);

-- Tabla Bitacora
CREATE TABLE Bitacora (
    Rowid INT NOT NULL PRIMARY KEY IDENTITY,
    Usuario INT NOT NULL,
    Accion CHAR(50) NOT NULL,
    Descripcion CHAR(MAX) NOT NULL,
    Tabla CHAR(50) NOT NULL,
    CONSTRAINT FK_Bitacora_Usuario FOREIGN KEY (Usuario) REFERENCES Usuario(Documento)
);

-- Tabla Sedes
CREATE TABLE Sedes (
    Rowid INT NOT NULL PRIMARY KEY IDENTITY,
    Direccion CHAR(100) NOT NULL,
    Empresa INT NOT NULL,
    MesasTotales INT NOT NULL,
    MesasDisponibles INT NOT NULL,
    ReservasMaximas INT NOT NULL,
    Telefono INT NULL,
    CONSTRAINT FK_Sedes_Empresas FOREIGN KEY (Empresa) REFERENCES Empresas(NIT)
);

-- Tabla Menus
CREATE TABLE Menus (
    Rowid INT NOT NULL PRIMARY KEY IDENTITY,
    Sede INT NOT NULL,
    Estado BIT NOT NULL,
    Nombre CHAR(100) NOT NULL,
    Descripcion CHAR(MAX) NULL,
    Precio INT NOT NULL,
    Tipo INT NOT NULL,
    CONSTRAINT FK_Menus_Sedes FOREIGN KEY (Sede) REFERENCES Sedes(Rowid)
);

-- Tabla Domicilios
CREATE TABLE Domicilios (
    Rowid INT NOT NULL PRIMARY KEY IDENTITY,
    Usuario INT NOT NULL,
    Sede INT NOT NULL,
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    DireccionEntrega CHAR(200) NOT NULL,
    TipoPago INT NOT NULL,
    NumeroDomicilio INT NOT NULL,
    CONSTRAINT FK_Domicilios_Usuario FOREIGN KEY (Usuario) REFERENCES Usuario(Documento),
    CONSTRAINT FK_Domicilios_Sedes FOREIGN KEY (Sede) REFERENCES Sedes(Rowid)
);

-- Tabla Reservas
CREATE TABLE Reservas (
    Rowid INT NOT NULL PRIMARY KEY IDENTITY,
    Usuario INT NOT NULL,
    Sede INT NOT NULL,
    Mesas INT NOT NULL,
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    Personas INT NOT NULL,
    Estado INT NOT NULL,
    CONSTRAINT FK_Reservas_Usuario FOREIGN KEY (Usuario) REFERENCES Usuario(Documento),
    CONSTRAINT FK_Reservas_Sedes FOREIGN KEY (Sede) REFERENCES Sedes(Rowid)
);
