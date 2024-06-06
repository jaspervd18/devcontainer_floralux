# Dev Container for Floralux

This will greatly improve onboarding for:

- frontend: get almost immediately started on a project .net core project and start slicing
- support: backend dev has almost immediately an up-and-running environment with data to start AMS related work

The devcontainer approach simplifies the processing of:

- getting a .net core project up and running
- setting up a SQL server
- restore data
- handle SSL certificates

## **Pre-requisites:**

- Install docker
- Install optimizely projects root CA
  - Needed only once for all opti projects
  - Windows: add to Trusted Root Certification Authorities
  - MacOS: add and trust certificate into keychain
  - Can be found inside the folder /tools/ssl or as attachment of this page
- Install vscode devcontainer extension
  - xtension "ms-vscode-remote.remote-containers" (see recommended extensions in .vscode/extensions.json)

## **Runbook:**

- Check the readme for projects specific
- Request db backup through a colleague and copy to the /db folder
  - Rename the bacpac to the database name of the project. Database name can be found in the connectionstrings
- Open solution in vscode
- Create .env file in the .devontainer folder
  - Easiest way is to copy the example file for your OS and remove the extension. do not commit this file
- Re-open in container (will be suggested by vscode)
  - This will trigger following operations (simplified)
    - Create 2 containers, one with SQL server and one for the dev environment
    - VS Code will be installed in dev env + additional project extensions
    - Db backup - if any - will be restored in SQL server
    - New SSL cert is generated for kestrel

## Generating self-signed certificates

A web browser will not trust a self-signed certificate, as it has not been issued by a trusted Certificate Authority (CA). This is because self-signed certificates do not have any chain of trust, and anyone can create a self-signed certificate with any name and use it to impersonate a legitimate website. To avoid this problem, web developers can create a self-signed certificate and add it to the list of trusted certificates in their web browser. This will allow the browser to trust the self-signed certificate and establish a secure HTTPS connection to the locally hosted website.

Here's wat both scripts do:

**generateRootCA.sh**

These steps are used to generate a self-signed X.509 certificate for a root Certificate Authority (CA) using OpenSSL. The root CA is used to sign other certificates, including server and client certificates, that are used for secure communication over HTTPS:

- Define variables for the script's directory and output path.
- Generate a new 2048-bit private key for the root CA.
- Create a self-signed X.509 certificate for the root CA using the private key.
- Set the validity period to 365 days and use SHA256 for the signature algorithm.
- 
**generateWebCertificate.sh**

This script generates a self-signed X.509 certificate for a local development environment using OpenSSL. Here's what each command does:

- Define variables for the script's directory and output path.
- Generate a new 2048-bit private key.
- Create a certificate signing request (CSR) using the private key.
- Sign the CSR using a root CA certificate and create an X.509 certificate.
- Create a PKCS#12 file containing the private key and signed certificate.

_Notes on Windows_

When installing the rootCA for the first time, make sure to place it under "Trusted Root Certification Authorities". When installed, make sure to restart your machine, as otherwise the effects of the rootCA will not take place.

_Notes on Mac_

When installed, open your keychain and look for the rootCA. Open the rootCA and set trust options to "always trust" instead of "system defaults".

## Using Podman as an alternative to Docker Desktop

1. Delete Docker Desktop from machine.
2. Install [Podman Desktop](https://podman-desktop.io/).
3. Follow the default configuration steps.
4. When not done during configuration, create a podman machine:
    * Navigate to ’Settings’ → ’Resources’.
    * Create a new machine.
    * Leave all the default values en only check ”User mode networking”.
5. When not done during configuration, install docker-compose within Podman:
    * Navigate to ’Extensions’.
    * Install the ”Compose Extension” globaly.
6. Within VS Code:
    * Ctrl+Shift+P → ”Dev Containers: Settings”.
    * Change the Docker path from ”docker” to ”podman”.
