# Basics and introduction to - {{Tutorial}}

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

