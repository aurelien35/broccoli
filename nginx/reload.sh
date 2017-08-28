#! /bin/bash

pushd `dirname $0` > /dev/null

    docker exec -it nginx-server nginx -s reload

popd > /dev/null
