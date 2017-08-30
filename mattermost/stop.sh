#! /bin/bash

pushd `dirname $0` > /dev/null

	docker-compose stop && docker-compose rm -f

popd > /dev/null
