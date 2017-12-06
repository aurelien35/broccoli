#! /bin/bash

pushd `dirname $0` > /dev/null

    docker-compose up --build -d

popd > /dev/null
