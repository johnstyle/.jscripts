#!/bin/bash

git fetch

tag=$(git describe)
version=${tag%%.*}
release=${tag#*.}
release=${release%.*}
hotfix=${tag##*.}

hotfix=$((${hotfix} + 1))

tag="${version}.${release}.${hotfix}"

git flow hotfix start ${tag}
