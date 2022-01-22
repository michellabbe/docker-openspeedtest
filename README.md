[![Docker Stars](https://img.shields.io/docker/stars/mlabbe/openspeedtest.svg)](https://hub.docker.com/r/mlabbe/openspeedtest/) [![Docker Pulls](https://img.shields.io/docker/pulls/mlabbe/openspeedtest.svg)](https://hub.docker.com/r/mlabbe/openspeedtest/)

# docker: OpenSpeedTest -EXPIRED-
________________________________________
This is a Docker image to run nginx and an old iframe version of  [OpenSpeedTest](http://openspeedtest.com/) application for benchmarking network performance.

<B>It is no longer usable</B> and will give you a <B>Network Error</B> when launching test.

There is no point in maintaning this image now that there is an official one (without iframe).
Use the official [OpenSpeedtest](https://hub.docker.com/r/openspeedtest/latest) Docker image instead.
________________________________________


[![OpenSpeedTest](https://raw.githubusercontent.com/michellabbe/docker-openspeedtest/master/openspeedtest.png)](http://openspeedtest.com/)

- Runs as non-root user
- Small image size
- Can be used to measure LAN, VPN or internet speed
- HTML5 (no Flash or Java)
- No client to install, works directly from Web Browser

Total size of this image is:

[![](https://images.microbadger.com/badges/image/mlabbe/openspeedtest.svg)](https://microbadger.com/images/mlabbe/openspeedtest)

________________________________________
### Pulling from Docker hub
If you want to obtain the image from Docker registry, you can use the following command:
```sh
docker pull mlabbe/openspeedtest
```
________________________________________
### Running the image
In order to start the openspeedtest container, use the following:
```sh
docker run --restart=unless-stopped --name=openspeedtest -d -p 80:8080 mlabbe/openspeedtest
```

You can also use a different port if you want.  You can keep the default built-in ports inside the container and just map them to different ports on the host, e.g.:

`-p 8081:8080`

At that point, you can use your Docker server as a SpeedTest server to begin
benchmarking your network speeds, e.g.:

`http://your_docker_host_ip`
`http://your_docker_host_ip:8081`

________________________________________
### Upgrading
Upgrading the application inside the Docker image is easy.  Just pull the image again from Docker Hub, then stop/remove the container and create it again.  It will download the newer zip file while rebuilding:
```sh
docker pull mlabbe/openspeedtest
docker stop openspeedtest
docker rm openspeedtest
docker run --restart=unless-stopped --name=openspeedtest -d -p 80:8080 mlabbe/openspeedtest
```
