#!/bin/bash

echo "Generate private and public ssh keys"

ssh-keygen -t rsa -f ./key -N ''
