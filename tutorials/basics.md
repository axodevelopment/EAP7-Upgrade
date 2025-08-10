# Basics and introduction to - Basics

## Overview of tutorial

This tutorial will give a high level overview of the {{Tutotorial}}, we will also explore the general config options what the values are and what they imply in behaviors when setting them.

## Table of Contents

Tutorial listing

1. [Prereqs](#prerequisites)
2. [Tutorial Breakouts](#tutorials)
3. [Reference Docs](#reference-docs)

---

## Prerequisites

Please review `pre-req.md` if you wish to follow the steps with a setup cluster.

---

## Tutorial

#(Note I am running on MAC)

Setup EAP7 environment

Download EAP7

From Red Hat documentation locationed: - https://docs.redhat.com/en/documentation/red_hat_jboss_enterprise_application_platform/7.0/html/installation_guide/installing_jboss_eap

```bash
Open a browser and log in to the Red Hat Customer Portal at https://access.redhat.com.
Click Downloads.
Click Red Hat JBoss Enterprise Application Platform in the Product Downloads list.
Select the correct JBoss EAP version from the Version drop-down menu.
Find Red Hat JBoss Enterprise Application Platform 7.x.x in the list and click the Download link.
```

I unziped this to my local /install folder which i have in .gitignore use whatever location makes sense for the following commands related to installing jboss.


---

Note the Labs folder specifically /labs/eap7-lab/hello-eap7-api

mvn clean package

https://catalog.redhat.com/en/software/container-stacks/detail/5f904c3679b4f8d046342f74

https://catalog.redhat.com/software/containers/jboss-eap-7/eap74-openjdk11-runtime-openshift-rhel8/6054cfd24b028f6e10ce2e32?container-tabs=gti&gti-tabs=registry-tokens

Note the location in the dockerfile that the war is located copy as needed.

Dockerfile.eap7 is located at root
It will contain the /install which i have unziped 
- jboss-eap-7.4.0.zip
- /labs/eap7-lab../target/hello-eap7-api-1.0.war

---

Downloading the MTA-CLI and installing it....

https://developers.redhat.com/products/mta/download

mta-cli analyze --list-targets will run behind the scenes

usr/local/bin/docker run --rm --name lmxKujYejyEDXjQT --entrypoint /usr/local/bin/mta-cli --env RUN_MODE=container --env RULE_PATH= registry.redhat.io/mta/mta-cli-rhel9:7.3.1 analyze --run-local=false --list-targets

cd to root of prj

mta-cli analyze \
  --run-local=false \
  --mode source-only \
  --input  "$(pwd)/labs/eap7-lab/hello-eap7-api" \
  --output "$(pwd)/mta-report" \
  --target eap8 \
  --target openjdk21 \
  --overwrite

--run-local=false is important here unless you have kantra rulesets already installed that you want to use instead you can check this at a /.kantra

This command should complete with a note of 

INFO[0070] Static report created. Access it at this URL:  URL="file:///Users/michaelwilson/tutorials/EAP7-Upgrade/EAP7-Upgrade/mta-report/static-report/index.html"

--- Openrewrite

have mvn run it
mvn -U org.openrewrite.

For example can remove unused imports...

```bash
import javax.ws.rs.ApplicationPath;
```

Exists in one of the java files in the eap7 project.

maven:rewrite-maven-plugin:run \
  -Drewrite.activeRecipes=org.openrewrite.java.RemoveUnusedImports