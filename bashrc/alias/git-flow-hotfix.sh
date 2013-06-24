#!/bin/bash
# 
# alias hotfix='. /home/tyreparse/crawler/script/alias/hotfix.sh'

git fetch

tag=$(git describe --tags $(git rev-list --tags --max-count=1))
version=${tag%%.*}
release=${tag#*.}
release=${release%.*}
hotfix=${tag##*.}

hotfix=$((${hotfix} + 1))

tag="${version}.${release}.${hotfix}"

git flow hotfix start ${tag}
