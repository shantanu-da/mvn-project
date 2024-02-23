#!/bin/bash

fetchSQLFilesinSubDir() {
    local releaseDir=$1
    local filesList=()
    for file in $releaseDir/*; do
        if [ -d "$file" ]; then 
            fetchSQLFiles $file
        elif [[ -f "$file" && "$file" == *.sql ]]; then
            filesList+=("$file")
        fi
    done
    for sqlFile in "${filesList[@]}"; do
        echo "$sqlFile"
    done
}

fetchSQLFiles() {
    local releaseDir=$1
    local filesList=()
    for file in $releaseDir/*; do
        if [[ -f "$file" && "$file" == *.sql ]]; then
            filesList+=("$file")
        fi
    done
    for sqlFile in "${filesList[@]}"; do
        echo "$sqlFile"
    done
}

directory="subdir_sctipts_poc/sql_files" 
choice=$1
if [[ ${choice} == "fetchSQLFiles" ]] ; then
    fetchSQLFiles $directory 

elif [[ ${choice} == "fetchSQLFilesinSubDir" ]] ; then
    fetchSQLFilesinSubDir $directory
else
    echo "Wrong Choice!!!"
fi
