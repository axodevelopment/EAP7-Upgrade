# Basics and introduction to - Migrating an EAP7 Application

## Overview of tutorial

This tutorial will give a high level overview of the way I personally would begin a Large Scale EAP migration process., we will also explore the general config options what the values are and what they imply in behaviors when setting them.

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

I first want to cover items that are not purely technical but preparatory work and baseling I belive that is needed.

### Portfolio intake and Baselining

We should have a good handle on the following materials:

- Repo URL & owners (codeowners)
- Artifact (WAR/EAR), packaging (Maven/Gradle), build cmd
- Runtime (standalone/domain, subsystems used, datasources, messaging, security)
- Dependencies (BOMs, org-wide libs, vendor libs)
- Traffic tier (external/internal), RTO/RPO, SLAs, compliance flags
- Deployment (OpenShift/VMs), env parity
- Current Java (11?) and EAP minor version
- Owner priority & business criticality

MTA should also be used to do a first scan per repo.

### Change Taxonomy

I really like to build and associate playbooks for each category of change that we will be doing:

Example:

- Namespace shifts: javax.* → jakarta.* (REST/JPA/JMS/Servlet/CDI/etc.)
- Security/Elytron: replace legacy security-domains, legacy login modules
- Config: standalone.xml drift → rebuild with EAP 8 + Galleon layers
- JPA/Hibernate: Hibernate 5.x → 6.x breaking changes (criteria, metadata, sequences)
- JAX-RS/Resteasy: provider registration, interceptors, media types
- JMS → Jakarta Messaging: API import renames, MDBs, connection factories
- Testing/tooling: surefire/surefire-junit5, Arquillian tweaks
- JDK: illegal reflective access, removed/encapsulated JDK APIs, JAXB/CORBA removal
- 3rd-party libs: upgrade matrix (log4j → log4j2, RestAssured, Jackson, etc.)

Ultimate I want to keep a record of the playbooks both as an audit but also as a sanity check.  Ideally before / after snipets, allowed verions, list of openrewrite recipes etc.

### Project and or Tech Debt Management

We should ask ourselves how will these migrations be classified and organized?  Through Jira?  Through Tech Debt?

We need to map our Taxonomy and MTA results into this format

Mapping MTA severities to Jira(any tool is fine):

- Mandatory → Jira Bug (Priority = High). CI must fail on these in “EAP8/Java21 mode”.
- Optional → Jira Task (Priority = Medium). Group by category.
- Informational → Jira Sub-task or backlog comment.

Do we need to Auto-create tickets?

- A small script ingests MTA JSON → creates/updates Jira issues (idempotent).
- Attach the MTA HTML report to the Epic.


### Wave planning & prioritization

Score each app, then sort:

- Business Criticality: 1–3 (low/med/high)
- Mandatory count: straight from MTA
- Weighted Optional: e.g., 0.5 × optionals
- Blast Radius: 1–3 (shared libs, upstream/downstream coupling)

An example priority score:

Priority score = Business Criticality × (Mandatory count + Weighted Optional) × Blast Radius

Lastly, with this we can finally plan waves of applications as needed, maybe make waves of 5-10 apps per wave.

### CI/CD as your guardrail

What to enforce on every PR?

If we have several waves, consider flipping gates progressively (observe -> warn -> fail)

Do you want an EAP8 target scan with OpenJDK21 with MTA?

Dual builds can be useful at the start to do a Java11 build and a Java21 build for example...

Smoke Tests / Unit Tests on EAP8 in addition to existing smoke tests.

### Reference automation

I would be creating a repo of custom and opensourced used openrewrite recipes.  I would also pin the version to what was used for historical purposes and audit purposes.

I would also consider making a golden repo template that has common recipes and github actions as example that you can allow developer teams to use as needed.

Perhaps building a branch that, contains the list of recipes, plus MTA tooling available so they can sequence and test as needed.

### Standardize the tech and images.

Golden images:

- EAP 7 (Java 11) for baseline
- EAP 8 (Java 17/21) with Galleon layers tailored for your org (e.g., jaxrs-server, jpa, elytron, optional messaging-activemq)

Dependency BOMs:

- Centralize allowed versions (Jakarta EE 10, Hibernate 6.x, RESTEasy 6.x).
- Provide a parent POM that teams inherit.

Security/Elytron reference configs

- Realm examples, SSL/TLS, OIDC adapter

Messaging:

- Shared AMQ (Artemis) broker with AMQP 1.0 listener.
- Connection factory examples for JMS/Jakarta Messaging.
- (Optional) Reactive Messaging templates (SmallRye + AMQP).


