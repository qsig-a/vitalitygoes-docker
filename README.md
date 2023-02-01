# Vitality GOES - Docker Image

This installs goestools and Vitality GOES in one docker container in order to make it easier to deploy. This image is a work in process.

THis image pulls code from:
- https://github.com/pietern/goestools
- https://github.com/JVital2013/vitality-goes

## Running it in docker

To run it with baseline config, you can simply run it like this

```
docker run -d --name vitality-goes \
 --restart always \
 --privileged \
 -p 80:80
  qsig/vitalitygoes:main
```

If you would like to mount a volume with config files and images

```
docker run -d --name vitality-goes \
 --restart always \
 --privileged \
 -v /hostvolume/goes-config:/goes-config \
 -v /hostvolume/goes-images:/images \
 -p 80:80 \
  qsig/vitalitygoes:main
```

## Credits

More here later

- Admin Text fix by in goestools @spinomaly - [https://github.com/pietern/goestools/pull/105](https://github.com/pietern/goestools/pull/105)
- Proj 8 fix in goestools by by @jim-minter - [https://github.com/pietern/goestools/pull/148](https://github.com/pietern/goestools/pull/148)
