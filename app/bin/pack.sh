#!/usr/bin/env bash

tar -czvf movies.tar.gz movies

if [[ -f "./movies.tar.gz" ]]; then

    rm -rf movies/
    exit 0

else

    exit 1

fi
