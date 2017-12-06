#! /bin/bash

pushd `dirname $0` > /dev/null

    docker-compose stop && docker-compose rm -f && docker-compose up --build -d

popd > /dev/null
