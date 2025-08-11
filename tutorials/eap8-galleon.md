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

eap8+war.dockerfile

IM usage

```bash
0.912 Usage: jboss-eap-installation-manager install --profile=<predefined-name>
0.912 --dir=<target-directory> [OPTION]...
0.912   or:  jboss-eap-installation-manager install --profile=<predefined-name>
0.912 --manifest=<URL/GAV/path> --repositories=<URL>[,...] --dir=<target-directory>
0.912 [OPTION]...
0.912          (to install an installation profile)
0.912   or:  jboss-eap-installation-manager install --fpl=<GA> --channel=<path>
0.912 --dir=<target-directory> [OPTION]...
0.912          (to install a feature pack)
0.912   or:  jboss-eap-installation-manager install --definition=<path>
0.912 --dir=<target-directory> [OPTION]...
0.912          (to install from a Galleon `provisioning.xml` file)
0.912
0.912 Options:
0.912       --channel, --channels=<channel-reference>[,<channel-reference>...]
0.912                              Configuration of channels used in the
0.912                                installation. Defines channel manifests and
0.912                                repositories used to provision a server.
0.912                              Specify as a file path, URL or Maven coordinate
0.912                                (groupId:artifactId).
0.912                              Alternative to --manifest and --repositories.
0.912       --dir=<directory>      Target directory where the application server will
0.912                                be provisioned.
0.912       --manifest=<manifest-reference>
0.912                              Location of the manifest file for a channel.
0.912                              Specify the location as a file path, URL or Maven
0.912                                coordinate (groupId:artifactId).
0.912                              Alternative to --channel.
0.912       --repositories=<repo-url>[,<repo-url>...]
0.912                              Remote Maven repositories that contain the
0.912                                artifacts required to install the application
0.912                                server. Specify multiple repositories separated
0.912                                by commas. These repositories override any other
0.912                                configured repositories in all the channels for
0.912                                this operation.
0.912                              Specify the location of the repositories as URLs
0.912                                or ID::URL pairs.
0.912                              Alternative to --channel.
0.912       --offline              Perform the server installation from local cache
0.912                                or file-system Maven repositories only.
0.912       --accept-license-agreements
0.912                              Accept all the license agreements required by the
0.912                                server.
0.912                              To view the required license agreements use the
0.912                                print-licenses command.
0.912   -h, --help                 Displays the help information for this command.
0.912       -vv, --verbose         Prints additional information if the command fails.
0.912
0.912 Installation source:
0.912       --profile=<installation-profile>
0.912                              Installation profile. The profiles contain
0.912                                complete provisioning configurations required to
0.912                                install a server.
0.912                              Available profiles are: [eap-8.0]
0.912       --fpl=<feature-pack-reference>
0.912                              Maven coordinates of a Galleon feature pack. The
0.912                                specified feature pack is installed with default
0.912                                layers and packages.
0.912                              When you use this option, you should also specify
0.912                                the --channels or a combination of --manifest
0.912                                and --repositories options.
0.912       --definition=<path>    Path to the Galleon `provisioning.xml` file.
0.912
0.912 Maven cache:
0.912       --local-cache=<path>   Path to the local Maven repository cache. It
0.912                                overrides the default Maven repository at ~/.
0.912                                m2/repository.
0.912       --no-resolve-local-cache
0.912                              Perform the operation without resolving or
0.912                                installing artifacts in the local maven cache.
0.912                              WARNING: Deprecated, please see
0.912                                --use-default-local-cache for alternatives.
0.912       --use-default-local-cache
0.912                              Enable caching and resolving artifacts from the
0.912                                default local Maven cache.
```