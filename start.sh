#!/bin/bash
mkdir ./out
sudo docker run -d --restart=unless-stopped -p 22:22 --name ssh_watch -v $PWD/out:/out ssh_watch
