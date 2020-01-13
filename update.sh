#!/bin/bash

TORCH_BUILD=99

wget https://build.torchapi.net/job/Torch/job/Torch/job/master/$TORCH_BUILD/artifact/bin/torch-server.zip -O /tmp/torch-server.zip
unzip -o -d /opt/torch-server /tmp/torch-server.zip
rm /tmp/torch-server.zip
chown -R torch-server:torch-server /opt/torch-server