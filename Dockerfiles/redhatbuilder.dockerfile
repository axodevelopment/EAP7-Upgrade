# source: https://developers.redhat.com/articles/2024/11/08/jboss-eap-images-galleon?source=sso#full_examples_and_explanations
# Use EAP 8 Builder image to create a JBoss EAP 8 server with its default configuration
FROM registry.redhat.io/jboss-eap-8/eap8-openjdk17-builder-openshift-rhel8:latest AS builder

ENV GALLEON_PROVISION_FEATURE_PACKS=org.jboss.eap:wildfly-ee-galleon-pack,org.jboss.eap.cloud:eap-cloud-galleon-pack
ENV GALLEON_PROVISION_LAYERS=cloud-default-config
ENV GALLEON_PROVISION_CHANNELS=org.jboss.eap.channels:eap-8.0
ENV GALLEON_MAVEN_ARGS="-X -e"

RUN /usr/local/s2i/assemble

## EAP 8 Runtime image
FROM registry.redhat.io/jboss-eap-8/eap8-openjdk17-runtime-openshift-rhel8:latest AS runtime

# Set appropriate ownership and permissions.
COPY --from=builder --chown=jboss:root $JBOSS_HOME $JBOSS_HOME

# Ensure appropriate permissions for the copied files.
#RUN $JBOSS_HOME/bin/jboss-cli.sh --commands="core-service=/management-interface=http-interface/:remove" <--- in case a command must be set
COPY --chown=jboss:root helloworld.war $JBOSS_HOME/standalone/deployments/
#ENV CONFIG_IS_FINAL=true <--- in case the configuration doesn't need any deployment change
RUN chmod -R ug+rwX $JBOSS_HOME