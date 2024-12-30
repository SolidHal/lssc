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

```

```

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

```