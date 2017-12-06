#! /bin/bash

pushd `dirname $0` > /dev/null

    docker exec -ti uwsgi-server /bin/sh

popd > /dev/null
