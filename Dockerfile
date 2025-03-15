# Base image
FROM jboss/wildfly:27.0.1.Final

# Copy the PostgreSQL driver and module configuration
COPY src/main/resources/modules/org/postgresql/main/module.xml /opt/jboss/wildfly/modules/system/layers/base/org/postgresql/main/
COPY src/main/resources/modules/org/postgresql/main/postgresql-42.6.0.jar /opt/jboss/wildfly/modules/system/layers/base/org/postgresql/main/

# Copy the WAR file to the deployment directory
COPY target/red-social-empresarial.war /opt/jboss/wildfly/standalone/deployments/

# Expose the default HTTP port
EXPOSE 8080

# Start WildFly
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]