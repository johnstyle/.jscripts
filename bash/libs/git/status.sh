#!/bin/bash

gitStatus ()
{
  location="unknow"
  
  status=$(git status 2> /dev/null)
  notclean=$(gitStatusNotClean "${status}")
  added=$(gitStatusAdded "${status}")
  modified=$(gitStatusModified "${status}")
  deleted=$(gitStatusDeleted "${status}")
  branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/\1${notclean}${added}${modified}${deleted}/")
  
  if [[ "${branch}" != "(no branch)" ]]; then
      location=${branch}
  else
  
      tag=$(git describe --tags 2> /dev/null)
      
      if [[ "${tag}" != "" ]]; then
          location="Tag:${tag}"
      else
          location="Commit:$(git rev-parse --short HEAD 2> /dev/null)"
      fi
  fi
  
  echo "(${location})"

}

