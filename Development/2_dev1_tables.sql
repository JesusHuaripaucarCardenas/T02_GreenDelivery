-- ===============================================
-- TABLA: deliveries
-- ===============================================
CREATE TABLE deliveries (
    id                INTEGER        PRIMARY KEY,
    departure_time    TIMESTAMP,
    delivery_time     TIMESTAMP,
    delivery_cost     NUMBER(8,2),
    distance_travel   NUMBER(6,2),
    status            CHAR(1),
    orders_id         INTEGER
);

-- ===============================================
-- TABLA: routes
-- ===============================================
CREATE TABLE routes (
    id                 INTEGER        PRIMARY KEY,
    name               VARCHAR2(150),
    description        VARCHAR2(250),
    main_district      VARCHAR2(100),
    distance_km        NUMBER(6,2),
    estimated_time_min INTEGER,
    difficulty         VARCHAR2(15),
    date_register      TIMESTAMP,
    status             CHAR(1)
);

-- ===============================================
-- TABLA: routes_points
-- ===============================================
CREATE TABLE routes_points (
    id                   INTEGER        PRIMARY KEY,
    routes_id            INTEGER        NOT NULL,
    "order"              INTEGER,
    name                 VARCHAR2(50),
    description          VARCHAR2(250),
    latitude             NUMBER(10,8),
    length               NUMBER(11,8),
    point_type           VARCHAR2(20),
    estimated_time_minutes INTEGER,
    distance_meters      INTEGER,
    observation          VARCHAR2(250),
    date_register        TIMESTAMP,
    status               CHAR(1),
    CONSTRAINT fk_routes_points_routes
        FOREIGN KEY (routes_id) REFERENCES routes(id)
);

-- ===============================================
-- TABLA: delivery_routes
-- ===============================================
CREATE TABLE delivery_routes (
    id                  INTEGER        PRIMARY KEY,
    deliveries_id       INTEGER        NOT NULL,
    routes_id           INTEGER        NOT NULL,
    usage_type          CHAR(1),
    deviations          INTEGER,
    actual_time_min     INTEGER,
    actual_distance_k   NUMBER(6,2),
    route_rating        INTEGER,
    usage_date          TIMESTAMP,
    remarks             VARCHAR2(200),
    CONSTRAINT fk_delivery_routes_deliveries
        FOREIGN KEY (deliveries_id) REFERENCES deliveries(id),
    CONSTRAINT fk_delivery_routes_routes
        FOREIGN KEY (routes_id) REFERENCES routes(id)
);
