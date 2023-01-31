# docker-vitalitygoes-goestools

Based on this [post](https://www.reddit.com/r/homeassistant/comments/zr1np8/using_satellite_weather_data_in_home_assistant/), this installs goestools and vitality-goes on one machine in order to make it easier to deploy and less manual work.

This is just a alpha level draft of things and I don't even have an antenna to verify

This repositories it clones are:

https://github.com/pietern/goestools
https://github.com/JVital2013/vitality-goes

It will copy a baseline config for `goesrecv` and `goesproc` from the vitality repo if one is not in the folder it's looking in (/goes-config)

## Running it in docker

To run it with baseline config, you can simply run it like this

```
docker run -d --name vitality-goes \
 --restart always \
 --privileged \
 -p 80:80
  qsig/docker-vitalitygoes-goestools:main
```

If you would like to mount a volume with config files and images

```
docker run -d --name vitality-goes \
 --restart always \
 --privileged \
 -v /hostvolume/goes-config:/goes-config \
 -v /hostvolume/goes-images:/images \
 -p 80:80 \
  qsig/docker-vitalitygoes-goestools:main
```

## Credits

More here later

- Admin Text fix by @spinomaly
- Proj 8 fix by @jim-minter
