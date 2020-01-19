[logo]: https://ci.nerv.com.au/userContent/antilax-3.png "AntilaX-3"
[![alt text][logo]](https://github.com/AntilaX-3/)

# AntilaX-3/alerthub
[![](https://images.microbadger.com/badges/version/antilax3/alerthub.svg)](https://microbadger.com/images/antilax3/alerthub) [![](https://images.microbadger.com/badges/image/antilax3/alerthub.svg)](https://microbadger.com/images/antilax3/alerthub) [![Docker Pulls](https://img.shields.io/docker/pulls/antilax3/alerthub.svg)](https://hub.docker.com/r/antilax3/alerthub/) [![Docker Stars](https://img.shields.io/docker/stars/antilax3/alerthub.svg)](https://hub.docker.com/r/antilax3/alerthub/)

[AlertHub](https://github.com/Ardakilic/alerthub) is a simple tool written with NodeJS to get alerted from GitHub releases, tags and commits.
This simple cli tool watches the releases set in config, and notifies you with E-mail, PushBullet or Pushover and provides you an aggregated RSS feed which you can use in IFTTT or your personal feed reader.
## Usage
```
docker create --name=alerthub \
-v <path to config>:/config \
antilax3/alerthub
```
## Parameters
The parameters are split into two halves, separated by a colon, the left hand side representing the host and the right the container side. For example with a volume -v external:internal - what this shows is the volume mapping from internal to external of the container. So -v /mnt/app/config:/config would map /config from inside the container to be accessible from /mnt/app/config on the host's filesystem.

- `-v /config` - local path for alerthub config file
- `-e PUID` - for UserID, see below for explanation
- `-e PGID` - for GroupID, see below for explanation
- `-e TZ` - for setting timezone information, eg Australia/Melbourne

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it alerthub /bin/bash`.

## User / Group Identifiers
Sometimes when using data volumes (-v flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work".

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:
`$ id <dockeruser>`
    `uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)`
    
## Volumes

The container uses a single volume mounted at '/config'. This volume stores the configuration file 'config.js'.

    config
    |-- config.js

## Configuration

The example config.js is copied to the /config volume when first run. Modify this as you see fit to determine repos you would like to monitor.

## Version
- **19/01/20:** Initial Release