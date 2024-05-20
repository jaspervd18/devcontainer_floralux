#!/bin/bash
dacpac="false"
bacpac="false"
sqlfiles="false"
SApassword=$1
dacpath=$2
bacpath=$3
sqlpath=$4

echo "SELECT * FROM SYS.DATABASES" | dd of=testsqlconnection.sql
for i in {1..60};
do
    /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P $SApassword -C -N -d master -i testsqlconnection.sql > /dev/null
    if [ $? -eq 0 ]
    then
        echo "SQL server ready"
        break
    else
        echo "Not ready yet..."
        sleep 1
    fi
done
rm testsqlconnection.sql

for f in $dacpath/*
do
    if [[ $f == $dacpath/*".dacpac" ]]
    then
        dacpac="true"
        echo "Found dacpac $f"
    else
        echo "No dacpac found $f"
    fi
done

for f in $bacpath/*
do
    if [[ $f == $bacpath/*".bacpac" ]]
    then
        bacpac="true"
        echo "Found bacpac $f"
    else
        echo "No bacpac found $f"
    fi
done

for f in $sqlpath/*
do
    if [[ $f == $sqlpath/*".sql" ]]
    then
        sqlfiles="true"
        echo "Found SQL file $f"
    else
        echo "No SQL file found $f"
    fi
done

if [ $sqlfiles == "true" ]
then
    for f in $sqlpath/*
    do
        if [[ $f == $sqlpath/*".sql" ]]
        then
            echo "Executing $f"
           /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P $SApassword -C -N -d master -i $f
        fi
    done
fi

if [ $dacpac == "true" ] 
then
    for f in $dacpath/*
    do
        if [[ $f == $dacpath/*".dacpac" ]]
        then
            dbname=$(basename $f ".dacpac")
            echo "Deploying dacpac $f"
            /opt/sqlpackage/sqlpackage /Action:Publish /SourceFile:$f /TargetServerName:localhost /TargetTrustServerCertificate:true /TargetDatabaseName:$dbname /TargetUser:sa /TargetPassword:$SApassword
        fi
    done
fi

if [ $bacpac == "true" ] 
then
    for f in $bacpath/*
    do
        if [[ $f == $bacpath/*".bacpac" ]]
        then
            # TODO delete db in case it already exists? Or abort and expect explicit deletion by developer
            # TODO check if database exists and instruct through log message possible options
            dbname=$(basename $f ".bacpac")
            echo "Deploying bacpac $f"
            /opt/sqlpackage/sqlpackage /Action:Import /SourceFile:$f /TargetServerName:localhost /TargetTrustServerCertificate:true /TargetDatabaseName:$dbname /TargetUser:sa /TargetPassword:$SApassword
        fi
    done
fi