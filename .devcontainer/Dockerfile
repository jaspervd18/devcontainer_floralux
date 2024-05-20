#FROM mcr.microsoft.com/devcontainers/dotnet:1-7.0-bullseye
#
## Install SQL Tools: SQLPackage and sqlcmd
#COPY mssql/installSQLtools.sh installSQLtools.sh
#RUN bash ./installSQLtools.sh \
#     && apt-get clean -y && rm -rf /var/lib/apt/lists/* /tmp/library-scripts


FROM mcr.microsoft.com/devcontainers/dotnet:1-6.0-bullseye

# Install SQL Tools: SQLPackage and sqlcmd
# COPY mssql/installSQLtools.sh installSQLtools.sh
# RUN bash ./installSQLtools.sh

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

# [Optional] Uncomment this line to install global node packages.
# RUN su vscode -c "source /usr/local/share/nvm/nvm.sh && npm install -g <your-package-here>" 2>&1



# Copy the shell script from the devcontainer folder to the container
COPY mssql/installSQLtools.sh installSQLtools.sh

# Make the shell script executable
RUN chmod +x ./installSQLtools.sh

# Execute the shell script
RUN bash ./installSQLtools.sh

RUN apt-get update && \
    apt-get install -y openssl

# TODO obsolete? Move to postCreateCommand.sh?
COPY /ssl /ssl