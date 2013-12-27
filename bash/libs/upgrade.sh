#!/bin/bash

function upgrade ()
{
    apt-get update
    apt-get dist-upgrade
    apt-get autoremove --purge
    apt-get autoclean
}
