-- Tabla 1: Empresas
CREATE TABLE Empresas (
    empresa_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    industria VARCHAR(255),
    fecha_fundacion DATE,
    direccion TEXT,
    sitio_web VARCHAR(255),
    telefono VARCHAR(20),
    email VARCHAR(255) UNIQUE NOT NULL
);

-- Tabla 2: Usuarios
CREATE TABLE Usuarios (
    usuario_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL,
    contrasena_hash VARCHAR(255),
    rol ENUM('administrador', 'empleado') DEFAULT 'empleado',
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (empresa_id) REFERENCES Empresas(empresa_id)
);

-- Tabla 3: Publicaciones
CREATE TABLE Publicaciones (
    publicacion_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT,
    usuario_id BIGINT,
    contenido TEXT NOT NULL,
    tipo ENUM('texto', 'imagen', 'video') DEFAULT 'texto',
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (empresa_id) REFERENCES Empresas(empresa_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 4: Comentarios
CREATE TABLE Comentarios (
    comentario_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    publicacion_id BIGINT,
    usuario_id BIGINT,
    contenido TEXT NOT NULL,
    fecha_comentario TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (publicacion_id) REFERENCES Publicaciones(publicacion_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 5: Transacciones
CREATE TABLE Transacciones (
    transaccion_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    empresa_origen_id BIGINT,
    empresa_destino_id BIGINT,
    monto DECIMAL(15, 2) NOT NULL,
    moneda CHAR(3) DEFAULT 'USD',
    fecha_transaccion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    descripcion TEXT,
    FOREIGN KEY (empresa_origen_id) REFERENCES Empresas(empresa_id),
    FOREIGN KEY (empresa_destino_id) REFERENCES Empresas(empresa_id)
);

-- Tabla 6: ArchivosAdjuntos
CREATE TABLE ArchivosAdjuntos (
    archivo_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    publicacion_id BIGINT,
    comentario_id BIGINT,
    url_archivo VARCHAR(255) NOT NULL,
    tipo_archivo ENUM('imagen', 'pdf', 'documento') DEFAULT 'imagen',
    fecha_subida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (publicacion_id) REFERENCES Publicaciones(publicacion_id),
    FOREIGN KEY (comentario_id) REFERENCES Comentarios(comentario_id)
);

-- Tabla 7: Notificaciones
CREATE TABLE Notificaciones (
    notificacion_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    usuario_id BIGINT,
    mensaje TEXT NOT NULL,
    leida BOOLEAN DEFAULT FALSE,
    fecha_notificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 8: RelacionesEmpresas
CREATE TABLE RelacionesEmpresas (
    relacion_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    empresa_1_id BIGINT,
    empresa_2_id BIGINT,
    tipo_relacion ENUM('asociacion', 'competencia', 'proveedor') DEFAULT 'asociacion',
    fecha_inicio DATE,
    FOREIGN KEY (empresa_1_id) REFERENCES Empresas(empresa_id),
    FOREIGN KEY (empresa_2_id) REFERENCES Empresas(empresa_id)
);

-- Tabla 9: Auditoria
CREATE TABLE Auditoria (
    auditoria_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    tabla_afectada VARCHAR(255) NOT NULL,
    accion ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    datos_previos TEXT,
    datos_nuevos TEXT,
    usuario_id BIGINT,
    fecha_cambio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 10: HistorialPublicaciones
CREATE TABLE HistorialPublicaciones (
    historial_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    publicacion_id BIGINT,
    contenido_anterior TEXT NOT NULL,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modificado_por BIGINT,
    FOREIGN KEY (publicacion_id) REFERENCES Publicaciones(publicacion_id),
    FOREIGN KEY (modificado_por) REFERENCES Usuarios(usuario_id)
);

-- Tabla 11: Multimedia
CREATE TABLE Multimedia (
    multimedia_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('imagen', 'video', 'documento') DEFAULT 'imagen',
    url_archivo VARCHAR(255) NOT NULL,
    tamano_archivo BIGINT, -- Tamaño en bytes
    resolucion VARCHAR(50), -- Resolución para imágenes/videos
    duracion INT, -- Duración en segundos para videos
    fecha_subida TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla 12: Geolocalizacion
CREATE TABLE Geolocalizacion (
    geolocalizacion_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT,
    usuario_id BIGINT,
    latitud DECIMAL(10, 8),
    longitud DECIMAL(11, 8),
    direccion TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (empresa_id) REFERENCES Empresas(empresa_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 13: LogsActividad
CREATE TABLE LogsActividad (
    log_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    usuario_id BIGINT,
    accion VARCHAR(255) NOT NULL,
    detalles TEXT,
    ip_origen VARCHAR(45), -- IPv4 o IPv6
    fecha_accion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 14: Pagos
CREATE TABLE Pagos (
    pago_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    transaccion_id BIGINT,
    metodo_pago ENUM('tarjeta', 'transferencia', 'paypal') DEFAULT 'tarjeta',
    estado ENUM('pendiente', 'completado', 'fallido') DEFAULT 'pendiente',
    fecha_pago TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (transaccion_id) REFERENCES Transacciones(transaccion_id)
);

-- Tabla 15: IntegracionesExternas
CREATE TABLE IntegracionesExternas (
    integracion_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT,
    servicio VARCHAR(255) NOT NULL,
    token_acceso VARCHAR(255),
    fecha_conexion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (empresa_id) REFERENCES Empresas(empresa_id)
);

-- Tabla 16: Encuestas
CREATE TABLE Encuestas (
    encuesta_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (empresa_id) REFERENCES Empresas(empresa_id)
);

-- Tabla 17: PreguntasEncuesta
CREATE TABLE PreguntasEncuesta (
    pregunta_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    encuesta_id BIGINT,
    texto_pregunta TEXT NOT NULL,
    tipo_respuesta ENUM('texto', 'multiple', 'numerico') DEFAULT 'texto',
    FOREIGN KEY (encuesta_id) REFERENCES Encuestas(encuesta_id)
);

-- Tabla 18: RespuestasEncuesta
CREATE TABLE RespuestasEncuesta (
    respuesta_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    pregunta_id BIGINT,
    usuario_id BIGINT,
    respuesta TEXT,
    fecha_respuesta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pregunta_id) REFERENCES PreguntasEncuesta(pregunta_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 19: Eventos
CREATE TABLE Eventos (
    evento_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    fecha_evento DATETIME,
    ubicacion TEXT,
    capacidad INT,
    FOREIGN KEY (empresa_id) REFERENCES Empresas(empresa_id)
);

-- Tabla 20: AsistentesEventos
CREATE TABLE AsistentesEventos (
    asistente_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    evento_id BIGINT,
    usuario_id BIGINT,
    fecha_inscripcion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (evento_id) REFERENCES Eventos(evento_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 21: Mensajes
CREATE TABLE Mensajes (
    mensaje_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    remitente_id BIGINT,
    destinatario_id BIGINT,
    contenido TEXT NOT NULL,
    fecha_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    leido BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (remitente_id) REFERENCES Usuarios(usuario_id),
    FOREIGN KEY (destinatario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 22: Grupos
CREATE TABLE Grupos (
    grupo_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    creador_id BIGINT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (creador_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 23: MiembrosGrupos
CREATE TABLE MiembrosGrupos (
    miembro_grupo_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    grupo_id BIGINT,
    usuario_id BIGINT,
    fecha_union TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (grupo_id) REFERENCES Grupos(grupo_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 24: HistorialMensajesGrupo
CREATE TABLE HistorialMensajesGrupo (
    historial_mensaje_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    grupo_id BIGINT,
    mensaje_id BIGINT,
    fecha_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (grupo_id) REFERENCES Grupos(grupo_id),
    FOREIGN KEY (mensaje_id) REFERENCES Mensajes(mensaje_id)
);

-- Tabla 25: Calificaciones
CREATE TABLE Calificaciones (
    calificacion_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT,
    usuario_id BIGINT,
    puntuacion INT CHECK (puntuacion BETWEEN 1 AND 5),
    comentario TEXT,
    fecha_calificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (empresa_id) REFERENCES Empresas(empresa_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 26: Foros
CREATE TABLE Foros (
    foro_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    creador_id BIGINT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (creador_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 27: TemasForo
CREATE TABLE TemasForo (
    tema_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    foro_id BIGINT,
    titulo VARCHAR(255) NOT NULL,
    contenido TEXT,
    creador_id BIGINT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (foro_id) REFERENCES Foros(foro_id),
    FOREIGN KEY (creador_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 28: RespuestasForo
CREATE TABLE RespuestasForo (
    respuesta_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    tema_id BIGINT,
    usuario_id BIGINT,
    contenido TEXT,
    fecha_respuesta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (tema_id) REFERENCES TemasForo(tema_id),
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 29: Reportes
CREATE TABLE Reportes (
    reporte_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    usuario_id BIGINT,
    tipo_reporte ENUM('spam', 'abuso', 'error') DEFAULT 'spam',
    descripcion TEXT,
    fecha_reporte TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 30: Suscripciones
CREATE TABLE Suscripciones (
    suscripcion_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    usuario_id BIGINT,
    plan ENUM('basico', 'premium', 'empresarial') DEFAULT 'basico',
    fecha_inicio DATE,
    fecha_fin DATE,
    activa BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 31: AnunciosPublicitarios
CREATE TABLE AnunciosPublicitarios (
    anuncio_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT,
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    costo DECIMAL(10, 2),
    FOREIGN KEY (empresa_id) REFERENCES Empresas(empresa_id)
);

-- Tabla 32: Recompensas
CREATE TABLE Recompensas (
    recompensa_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    usuario_id BIGINT,
    tipo ENUM('descuento', 'premio', 'puntos') DEFAULT 'puntos',
    cantidad INT,
    fecha_otorgamiento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 33: ChatEnTiempoReal
CREATE TABLE ChatEnTiempoReal (
    chat_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    usuario_id BIGINT,
    sala_chat VARCHAR(255),
    mensaje TEXT,
    fecha_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 34: NotasInternas
CREATE TABLE NotasInternas (
    nota_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    usuario_id BIGINT,
    titulo VARCHAR(255) NOT NULL,
    contenido TEXT,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES Usuarios(usuario_id)
);

-- Tabla 35: CampañasMarketing
CREATE TABLE CampañasMarketing (
    campaña_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT,
    nombre VARCHAR(255) NOT NULL,
    objetivo TEXT,
    presupuesto DECIMAL(15, 2),
    fecha_inicio DATE,
    fecha_fin DATE,
    FOREIGN KEY (empresa_id) REFERENCES Empresas(empresa_id)
);

-- Tabla 36: Inventarios
CREATE TABLE Inventarios (
    inventario_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    empresa_id BIGINT,
    producto VARCHAR(255) NOT NULL,
    cantidad INT,
    precio_unitario DECIMAL(10, 2),
    fecha_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (empresa_id) REFERENCES Empresas(empresa_id)
);