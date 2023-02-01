# Vitality GOES - Docker Image

This installs goestools and Vitality GOES in one docker container in order to make it easier to deploy. This image pulls code from:
- https://github.com/pietern/goestools
- https://github.com/JVital2013/vitality-goes

Patches are applied to goestoo

## Running it in docker

To run it with baseline config for GOES-16, you can simply run it like this:

```
docker run -d --name vitality-goes \
 --restart always \
 --privileged \
 -p 80:80
  qsig/vitalitygoes:main
```

To run it for GOES-18, set the SATELLITE environment vairable like so (case sensitive):

```
docker run -d --name vitality-goes \
 --restart always \
 --privileged \
 -e SATELLITE=goes18
 -p 80:80 \
  qsig/vitalitygoes:main
```


If you would like to mount a volume with config files and images:

```
docker run -d --name vitality-goes \
 --restart always \
 --privileged \
 -v /path/to/goestools-config:/goestools-config \
 -v /path/to/vitalitygoes-config:/var/www/html/config \
 -v /path/to/goes-images:/images \
 -p 80:80 \
  qsig/vitalitygoes:main
```

## Credits

The following additional code is included in this docker image:

- Admin Text fix by in goestools @spinomaly - [https://github.com/pietern/goestools/pull/105](https://github.com/pietern/goestools/pull/105)
- Proj 8 fix in goestools by by @jim-minter - [https://github.com/pietern/goestools/pull/148](https://github.com/pietern/goestools/pull/148)
