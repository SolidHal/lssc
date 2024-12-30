# lssc

librespot + snapcast server for arm64

## requirements
- spotify premium, required to use the api

## setup

### build the docker image

```
docker build -t solidhal/lssc .
```

## snapserver.conf example

see snapserver.conf.example

essentially we just add
```
librespot:///usr/bin/librespot?name=<name>[&username=<my username>&password=<my password>][&devicename=Snapcast][&bitrate=320][&wd_timeout=7800][&volume=100][&onevent=""][&normalize=false][&autoplay=false][&cache=""][&disable_audio_cache=false][&killall=false][&params=extra-params]
```
under `[stream]` in the default snapserver.conf

## run example

```
docker run \
-v /home/user/snapserver.conf:/snapserver.conf \
-e PUID="1000" \
-e PGID="1000" \
solidhal/lssc
```

## docker compose example

```
version: '3.5'
services:
  lssc:
    image: solidhal/lssc
    container_name: lssc
    volumes:
      - <path-to-snapserver.conf>:/snapserver.conf
    restart: "no"
    environment:
      - PUID=1002
      - PGID=1002
```