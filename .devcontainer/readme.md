# Running project in Visual Studio Code

## Prerequisites

- Install Docker
- Install the Devcontainer extension "ms-vscode-remote.remote-containers" (see recommended extensions in .vscode/extensions.json)

## Open project

Devcontainer configuration can be found in .devcontainer. Visual Studio Code will recognize this config file and suggest reopening the project in a container. If not, you can also click on the blue arrows, at the left bottom of your Visual Studio Code, where it will suggest some options, one of which to open it in a container.

## Authentication

When the project is loaded in the container, you need to authenticate for private NPM packages and private Nuget packages. Nuget is the package repository for .Net packages.

### NPM

- Open a new terminal
- Type 'better-vsts-npm-auth'
- Visit the url the above command generates
- Login with your account
- You'll be redirected to a page where a new command with a long ID is generated
- Copy that to your console and run it
- You are now authenticated in the container

### Nuget

- Hardcoded PAT for now in temporary file (not included in project)

## Config to review

- connectionstrings, localdb not supported on linux