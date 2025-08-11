FROM registry.redhat.io/jboss-eap-8/eap8-openjdk21-builder-openshift-rhel9:latest as builder

ENV GALLEON_PROVISION_FEATURE_PACKS=org.jboss.eap:wildfly-ee-galleon-pack,org.jboss.eap.cloud:eap-cloud-galleon-pack
ENV GALLEON_PROVISION_LAYERS=jaxrs-server,jpa,elytron,observability,messaging-activemq
ENV GALLEON_PROVISION_CHANNELS=org.jboss.eap.channels:eap-8.0
ENV GALLEON_MAVEN_ARGS="-X -e"

RUN /usr/local/s2i/assemble

FROM registry.redhat.io/jboss-eap-8/eap8-openjdk21-runtime-openshift-rhel9:latest as runtime

COPY --from=builder --chown=jboss:root $JBOSS_HOME $JBOSS_HOME

# Optionally deploy WAR
# COPY --chown=jboss:root myapp.war $JBOSS_HOME/standalone/deployments/

RUN chmod -R ug+rwX $JBOSS_HOME

EXPOSE 8080 9990 5672
