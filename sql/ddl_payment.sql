CREATE TABLE pedidos (
    pedido_id SERIAL PRIMARY KEY,
    cliente_id INTEGER NOT NULL,
    fecha_pedido TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    subtotal NUMERIC(10, 2) NOT NULL CHECK (subtotal >= 0),
    total NUMERIC(10, 2) NOT NULL CHECK (total >= 0),
    metodo_pago VARCHAR(50),
    direccion_envio TEXT NOT NULL,
    codigo_rastreo VARCHAR(100) UNIQUE,
    estado_pedido VARCHAR(50),
    estado_pago VARCHAR(50),
    estado_envio VARCHAR(50),
    impuestos NUMERIC(10, 2),
    costo_envio NUMERIC(10, 2),
    descuento_total NUMERIC(10, 2)

);

CREATE TABLE detalle_pedido (
    detalle_id SERIAL PRIMARY KEY,                  -- ID único de la línea del detalle
    pedido_id INTEGER NOT NULL,                     -- Referencia a la tabla pedidos
    libro_id INTEGER NOT NULL,                      -- Referencia a tu tabla de productos
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario NUMERIC(10, 2) NOT NULL,
    subtotal_linea NUMERIC(10, 2) NOT NULL,
    descuento_linea NUMERIC(10, 2),
    impuesto_linea NUMERIC(10, 2),
);


