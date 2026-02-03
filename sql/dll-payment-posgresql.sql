-- PEDIDOS
CREATE TABLE pedidos (

    pedido_id       BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    cliente_id      BIGINT NOT NULL,
    fecha_pedido    TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado_pedido   VARCHAR(20) NOT NULL DEFAULT 'pendiente',   -- pendiente, pagado, enviado, entregado, cancelado, reembolsado
    estado_pago     VARCHAR(20) NOT NULL DEFAULT 'pendiente',   -- pendiente, aprobado, rechazado, devuelto
    estado_envio    VARCHAR(20) NOT NULL DEFAULT 'pendiente',   -- pendiente, en_transito, entregado, devuelto
    subtotal        NUMERIC(12, 2) NOT NULL CHECK (subtotal >= 0),
    descuento_total NUMERIC(12, 2) NOT NULL DEFAULT 0 CHECK (descuento_total >= 0),
    impuestos       NUMERIC(12, 2) NOT NULL DEFAULT 0 CHECK (impuestos >= 0),
    costo_envio     NUMERIC(12, 2) NOT NULL DEFAULT 0 CHECK (costo_envio >= 0),
    total           NUMERIC(12, 2) NOT NULL CHECK (total >= 0),
    moneda          CHAR(3) NOT NULL DEFAULT 'USD',
    metodo_pago     VARCHAR(50),
    direccion_envio TEXT NOT NULL,
    codigo_rastreo  VARCHAR(100),
    created_at      TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP

);

-- indice para busquedas tipicas
CREATE INDEX idx_pedidos_cliente_fecha ON pedidos (cliente_id, fecha_pedido DESC);

-- tracking unico solo si existe
CREATE UNIQUE INDEX uq_pedidos_codigo_rastreo_notnull ON pedidos (codigo_rastreo) WHERE codigo_rastreo IS NOT NULL;

-- DETALLE_PEDIDO
CREATE TABLE detalle_pedido (

    detalle_id      BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pedido_id       BIGINT NOT NULL,
    libro_id        BIGINT NOT NULL,
    cantidad        INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario NUMERIC(12, 2) NOT NULL CHECK (precio_unitario >= 0),
    subtotal_linea  NUMERIC(12, 2) NOT NULL CHECK (subtotal_linea >= 0),
    -- opcional (historico del producto vendido)
    titulo_snapshot VARCHAR(255),
    isbn_snapshot   VARCHAR(20),

    CONSTRAINT fk_detalle_pedido FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id) ON DELETE CASCADE
);

CREATE INDEX idx_detalle_pedido_id ON detalle_pedido (pedido_id);

CREATE INDEX idx_detalle_libro_id ON detalle_pedido (libro_id);

-- Opcional: evita que el mismo libro se repita en el mismo pedido
-- ALTER TABLE detalle_pedido ADD CONSTRAINT uq_pedido_libro UNIQUE (pedido_id, libro_id);
