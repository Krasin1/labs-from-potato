#!/bin/bash

user=xxx
if grep $user /etc/passwd
then
    echo "the user $user exists"
fi
