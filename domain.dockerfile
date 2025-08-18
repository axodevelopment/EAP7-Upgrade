FROM registry.access.redhat.com/ubi9/ubi

RUN dnf -y install java-21-openjdk java-21-openjdk-devel unzip findutils && dnf clean all

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk
ENV PATH=$JAVA_HOME/bin:$PATH

COPY install/EAP8-Full/jboss-eap-8.0.0.zip /tmp/eap.zip

ENV JBOSS_HOME=/opt/eap

RUN mkdir -p /opt && unzip -q /tmp/eap.zip -d /opt \
 && mv /opt/jboss-eap-8.0 ${JBOSS_HOME} \
 && rm -f /tmp/eap.zip

RUN ${JBOSS_HOME}/bin/add-user.sh --user admin --password adminPwd --realm ManagementRealm --silent || true

CMD ["sleep","infinity"]