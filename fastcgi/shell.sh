#! /bin/bash

pushd `dirname $0` > /dev/null

    docker exec -ti hackware-fastcgi /bin/sh

popd > /dev/null
