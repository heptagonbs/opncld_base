#!/bin/bash

OPNCLD_EXISTS=$(getent passwd opncld)
if [ -z $OPNCLD_EXISTS ]; then
        useradd -mU -d /home/opncld opncld
        usermod -aG docker opncld
fi