
-- 1. Crear la tabla de Editoriales
CREATE TABLE editoriales (
    id_editorial INT AUTO_INCREMENT PRIMARY KEY,
    nombre_editorial VARCHAR(150) NOT NULL,
    url_editorial VARCHAR(255),
    estado TINYINT(1) DEFAULT 1 -- 1 para activo, 0 para inactivo
);

CREATE TABLE autores (
    id_autor INT AUTO_INCREMENT PRIMARY KEY,
    nombre_autor VARCHAR(255) NOT NULL,
    apellido_autor VARCHAR(255),
    biografia VARCHAR(255),
    estado TINYINT(1) DEFAULT 1
);

-- 2. Crear la tabla Libro con su relacion:
CREATE TABLE libro (
    id_libro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    fecha_publicacion DATE,
    isbn VARCHAR(20) UNIQUE,
    precio DECIMAL(10, 2),
    cantidad INT DEFAULT 0,
    descripcion TEXT,
    valoracion INT DEFAULT 0,
    visibilidad BOOLEAN DEFAULT TRUE,
    id_editorial INT, -- Campo para la relacion
    id_autor INT, -- Campo para la relacion
    -- Definicion de la Llave Foranea
    CONSTRAINT fk_libro_editorial FOREIGN KEY (id_editorial) REFERENCES editoriales(id_editorial)
    ON DELETE SET NULL -- Si se borra la editorial, el libro queda sin editorial asignada
    ON UPDATE CASCADE,  -- Si cambia el ID de la editorial, se actualiza en los libros
    CONSTRAINT fk_libro_autor FOREIGN KEY (id_autor) REFERENCES autores(id_autor) ON DELETE SET NULL ON UPDATE CASCADE  
);