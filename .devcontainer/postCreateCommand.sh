path=$(dirname "$0")

bash $path/ssl/generateWebCertificate.sh
bash $path/mssql/postCreateCommand.sh 'P@ssw0rd' $path/../db/dacpac $path/../db/bacpac './mssql'