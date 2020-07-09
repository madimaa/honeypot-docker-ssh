#!/bin/bash
mkdir ./out
sudo docker run -d --restart=unless-stopped --name ssh_watch -v $PWD/out:/out ssh_watch
