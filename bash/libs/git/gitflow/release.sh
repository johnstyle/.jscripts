#!/bin/bash

function release ()
{
    git fetch

    tag=$(git describe --tags $(git rev-list --tags --max-count=1))
    version=${tag%%.*}
    release=${tag#*.}
    release=${release%.*}
    hotfix=${tag##*.}

    release=$((${release} + 1))
    hotfix=0

    tag="${version}.${release}.${hotfix}"

    git flow release start ${tag}
}
    
