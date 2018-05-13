#!/bin/bash
echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin
export APP=test
export REPO=$DOCKER_USER/$APP
export TAG=`if [ "$TRAVIS_BRANCH" == "master" ]; then echo "latest"; else echo $TRAVIS_BRANCH ; fi`
docker build -f Dockerfile -t $REPO:$TAG -t $REPO:travis-$TRAVIS_BUILD_NUMBER .
docker push $REPO:$TAG
docker push $REPO:travis-$TRAVIS_BUILD_NUMBER