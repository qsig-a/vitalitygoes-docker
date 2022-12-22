# goes_ha

Based on this [post](https://www.reddit.com/r/homeassistant/comments/zr1np8/using_satellite_weather_data_in_home_assistant/), this installs goestools and vitality-goes on one machine in order to make it easier to deploy and less manual work.

This is just a alpha level draft of things and I don't even have an antenna to verify

This repositories it clones are:

https://github.com/pietern/goestools
https://github.com/JVital2013/vitality-goes

It will copy a baseline config for `goesrecv` and `goesproc` from the vitality repo if one is not in the folder it's looking in (/goes-config)

## Running it in docker

To run it with baseline config, you can simply run it like this

```
docker run -d --name goes_ga \
 --restart always \
 --privileged \
 -p 80:80
  qsig/goes_ga:latest
```

If you would like to mount a volume with config files

```
docker run -d --name goes_ga \
 --restart always \
 --privileged \
 -v /hostvolume/goes-config:/goes-config \
 -p 80:80 \
  qsig/goes_ga:latest
```