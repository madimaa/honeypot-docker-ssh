# Honeypot - Docker - SSH

Fake SSH service in Docker. The host's port 22 rerouted into the docker which runs a fake SSH service inside.  
It writes the connection attempts directly into the `passwords.json` in the `out` directory.  
The notifier watches the directory and sends a message to Mattermost through a webhook.  
Both of these services start with the system. (When set up properly, as described below.)

## Requirements
- Ubuntu 20.04 (or any Linux operating system which supports Docker)
- Docker
- Move the basic SSH service to another port
  - in `/etc/ssh/sshd_config` remove the # before `Port 22` and change the number
  - restart the service with the following command: `service ssh restart`

## Usage
- Build Docker image by executing `build.sh`
- Start it by executing `start.sh`
- Stop with `stop.sh`

## Mattermost notifier
- Required packages: jq and inotify-tools
  - `apt install jq inotify-tools`
- Change variables in `send_message.sh` file.
  - You can obtain your Mattermost Incoming Webhook from Integrations menu in Mattermost.
- Use it as a service
  - Correct the path in `ssh_ids_notify.service`
  - Copy `ssh_ids_notify.service` to `/etc/systemd/system/`
  - Execute the following commands:
    - systemctl daemon-reload
    - systemctl enable ssh_ids_notify
    - systemctl start ssh_ids_notify.service

### External dependencies
https://github.com/regit/pshitt

#### Indication of source
This project is based on this article: https://jonathanmh.com/how-to-set-up-an-ssh-honeypot-low-interaction-and-live-stream-it/

