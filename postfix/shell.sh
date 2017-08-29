#! /bin/bash

pushd `dirname $0` > /dev/null

    docker exec -ti postfix-server /bin/bash

popd > /dev/null
