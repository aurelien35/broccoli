#! /bin/bash

pushd `dirname $0` > /dev/null

    docker exec -ti nginx-server /bin/bash

popd > /dev/null
