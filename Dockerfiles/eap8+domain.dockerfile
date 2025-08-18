FROM registry.access.redhat.com/ubi9/ubi

RUN dnf -y install java-21-openjdk java-21-openjdk-devel unzip findutils && dnf clean all

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk
ENV PATH=$JAVA_HOME/bin:$PATH

COPY install/EAP8-installation-manager/jboss-eap-8.0.0-installation-manager.zip /tmp/im.zip

RUN mkdir -p /opt/eap-im \
 && unzip -q /tmp/im.zip -d /opt/eap-im \
 && rm -f /tmp/im.zip \
 && ln -s "$(ls -d /opt/eap-im/jboss-eap-installation-manager-*/ | head -n1)" /opt/eap-im/current

COPY install/EAP8-domain/provisioning.xml /tmp/provisioning.xml
COPY install/EAP8-domain/eap8.yaml /tmp/eap-8.yaml

ENV EAP_IM_HOME=/opt/eap-im/current
ENV JBOSS_HOME=/opt/eap

RUN ${EAP_IM_HOME}/bin/jboss-eap-installation-manager.sh install \
      --definition=/tmp/provisioning.xml \
      --manifest=org.jboss.eap.channels:eap-8.0:manifest:yaml \
      --repositories=https://maven.repository.redhat.com/ga \
      --dir ${JBOSS_HOME} \
      --accept-license-agreements

EXPOSE 8080 9990
CMD ["sleep", "infinity"]