🐋 Docker image with MariaDB for testing purposues


### 🛠 Install from Docker file
```
docker build . debian:mariadb
```

### 📦 Create the container from the image
- With this image we are sharing our X11 to get graphics from the container.
- We will get back a Terminator windows directly from that container.

```
docker run -it --privileged --net=host --ipc=host \
--device=/dev/dri:/dev/dri \
-v /tmp/.X11-unix:/tmp/.X11-unix \
-e DISPLAY=$DISPLAY \
-v $HOME/.Xauthority:/home/$(id -un)/.Xauthority \
-e XAUTHORITY=/home/$(id -un)/.Xauthority \
debian:mariadb
```


### Getting started
We need to enable the root password and other configurations. That can be done in a easy way with:
```
mysql_secure_installation
```
