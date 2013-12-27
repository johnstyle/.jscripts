#!/bin/bash

function sourcePath ()
{
    for file in $(find $1 -name "*.sh"); do
        . "$file"
    done
}

