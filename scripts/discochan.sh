#!/bin/bash
# discochan.sh

REDHAT_MAVEN_BASE="https://maven.repository.redhat.com/ga"

echo "=== Discovering EAP 8 Channels ==="

curl -s "$REDHAT_MAVEN_BASE/org/jboss/eap/channels/maven-metadata.xml" | \
  grep -oP '(?<=<version>)[^<]+' | \
  grep "8\." | \
  sort -V

echo -e "\n=== Channel Artifacts ==="
CHANNEL_VERSION="8.0.0.GA"
curl -s "$REDHAT_MAVEN_BASE/org/jboss/eap/channels/eap-8.0/$CHANNEL_VERSION/eap-8.0-$CHANNEL_VERSION.pom"