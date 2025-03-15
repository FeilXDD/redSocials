# EnterpriseConnect

Este proyecto es una red social empresarial desarrollada con **Jakarta EE 10**, **WildFly** como servidor de aplicaciones, y **PostgreSQL** como base de datos. El proyecto está diseñado para ejecutarse en contenedores Docker utilizando `docker-compose`.

## Requisitos previos

Antes de ejecutar el proyecto, asegúrate de tener instalado lo siguiente:

1. **Java 21**: [Descargar Java 21](https://openjdk.org/projects/jdk/21/)
2. **Maven**: [Descargar Maven](https://maven.apache.org/download.cgi)
3. **Docker**: [Instalar Docker](https://docs.docker.com/get-docker/)
4. **Docker Compose**: Viene incluido en Docker Desktop o puedes instalarlo por separado.

## Estructura del proyecto

```
red-social-empresarial/
├── src/                  # Código fuente
├── Dockerfile            # Configuración para construir la imagen de WildFly
├── docker-compose.yml    # Configuración para ejecutar los servicios (WildFly + PostgreSQL)
├── pom.xml               # Archivo Maven para gestionar dependencias
└── README.md             # Este archivo
```

## Pasos para ejecutar el proyecto

### 1. Clonar el repositorio

Si aún no has clonado el repositorio, puedes hacerlo con el siguiente comando:

```bash
git clone https://github.com/tu-usuario/EnterpriseConnect.git
cd EnterpriseConnect
```

### 2. Construir el proyecto con Maven

Ejecuta el siguiente comando para compilar el proyecto y generar el archivo `.war` necesario para desplegar en WildFly:

```bash
mvn clean package
```

Esto generará el archivo `target/EnterpriseConnect.war`, que será utilizado por WildFly.

### 3. Ejecutar el proyecto con Docker Compose

El proyecto utiliza Docker Compose para ejecutar tanto el servidor WildFly como la base de datos PostgreSQL. Sigue estos pasos:

#### a. Construir y ejecutar los contenedores

Ejecuta el siguiente comando para construir las imágenes y levantar los contenedores:

```bash
docker-compose up --build
```

Este comando hará lo siguiente:
- Construirá la imagen de WildFly utilizando el `Dockerfile`.
- Descargará e iniciará la imagen de PostgreSQL.
- Desplegará automáticamente el archivo `.war` en WildFly.

#### b. Verificar que los servicios están en ejecución

Una vez que los contenedores estén en ejecución, verifica que ambos servicios (WildFly y PostgreSQL) estén activos:

```bash
docker ps
```

Deberías ver dos contenedores en ejecución:
- `enterpriseconnect-app`: Servidor WildFly.
- `enterpriseconnect-db`: Base de datos PostgreSQL.

#### c. Acceder a la aplicación

Abre tu navegador y ve a la siguiente URL:

```
http://localhost:8080/EnterpriseConnect/
```

Si todo está configurado correctamente, deberías ver tu aplicación en funcionamiento.

### 4. Detener los contenedores

Para detener los contenedores, ejecuta el siguiente comando:

```bash
docker-compose down
```

Esto detendrá y eliminará los contenedores, pero conservará los datos de la base de datos en el volumen `postgres_data`.

### 5. Limpiar el proyecto

Si necesitas limpiar el proyecto (por ejemplo, para eliminar archivos temporales), ejecuta:

```bash
mvn clean
```

También puedes eliminar los volúmenes de Docker si deseas reiniciar completamente la base de datos:

```bash
docker volume rm enterpriseconnect_postgres_data
```

## Configuración adicional

### Base de datos

La base de datos PostgreSQL se configura automáticamente con los siguientes parámetros:

- **Nombre de la base de datos**: `red_social`
- **Usuario**: `admin`
- **Contraseña**: `secret`

Si necesitas cambiar estos valores, modifica el archivo `docker-compose.yml` y el archivo `persistence.xml`.

### Persistencia

Las tablas de la base de datos se crean automáticamente gracias a la propiedad `hibernate.hbm2ddl.auto=update` en el archivo `persistence.xml`. Esto significa que Hibernate actualizará el esquema de la base de datos según las entidades JPA definidas en el proyecto.

## Pruebas unitarias

El proyecto incluye pruebas unitarias en la carpeta `src/test/java`. Para ejecutar las pruebas, usa el siguiente comando:

```bash
mvn test
```

## Contribuciones

Si deseas contribuir al proyecto, sigue estos pasos:

1. Haz un fork del repositorio.
2. Crea una rama (`git checkout -b feature/nueva-funcionalidad`).
3. Realiza tus cambios y haz commit (`git commit -m "Añadir nueva funcionalidad"`).
4. Sube tus cambios (`git push origin feature/nueva-funcionalidad`).
5. Abre un pull request.

## Licencia

Este proyecto está bajo la licencia MIT. Consulta el archivo [LICENSE](LICENSE) para más detalles.

