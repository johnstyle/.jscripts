#!/bin/bash

git fetch

tag=$(git describe)
version=${tag%%.*}
release=${tag#*.}
release=${release%.*}
hotfix=${tag##*.}

release=$((${release} + 1))
hotfix=0

tag="${version}.${release}.${hotfix}"

git flow release start ${tag}
