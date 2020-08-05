#!/bin/bash

set -e

echo "Mirroring production to local"
SOURCE_KEY=AKIASBAQF5EANW35E7O4

TARGET_KEY=development
TARGET_SECRET=development

# go to to repo root
cd $(git rev-parse --show-toplevel)

# get production secret
echo -n "Enter production ($SOURCE_KEY) secret for read source files: "
read SOURCE_SECRET

# run 
echo "NOTE: local minio must be initialized by minio-mc-init"
docker-compose up -d minio

# mirror
docker run --rm -ti --network tanzfabrik --entrypoint="/bin/sh" minio/mc -c "\
  mc config host add production https://s3.amazonaws.com $SOURCE_KEY $SOURCE_SECRET
  mc config host add local http://minio:9000 $TARGET_KEY $TARGET_SECRET  
  mc mirror --overwrite --remove production/tanzfabrik-relaunch2020/ local/tanzfabrik-local  
 "