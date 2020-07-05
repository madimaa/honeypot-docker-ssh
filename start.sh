#!/bin/bash
mkdir ./out
sudo docker run -d --rm --restart=unless-stopped --name ssh_watch -v $PWD/out:/out ssh_watch
