patch mariadb docker image on arm
---------------------------------

# patch Dockerfile

> update /etc/mysql/my.cnf

- replace /var/run/mysqld with /var/lib/mysql
- add log_bin=ON in [mysqld] and [mysqld_safe]
- add log-error=/var/log/mysql/error.log

# build docker image
```
$ export http_proxy=http://192.168.2.107:1080
$ export https_proxy=http://192.168.2.107:1080
$ export no_proxy=/var/run/docker.sock

$ docker build --build-arg http_proxy=$http_proxy --build-arg https_proxy=$https_proxy  -t hyperhq/mariadb-arm64v8:10.3-2 .
```

# save to docker image archive file
```
$ docker save -o hyperhq_mariadb-arm64v8_10.3-2.tar hyperhq/mariadb-arm64v8:10.3-2

$ ll hyperhq_mariadb-arm64v8_10.3-2.tar
-rw------- 1 root root 354900992 8月  13 09:22 hyperhq_mariadb-arm64v8_10.3-2.tar
```

# load image archive via hyperctl
```
$ hyperctl rmi hyperhq/mariadb-arm64v8:10.3-2
Image(hyperhq/mariadb-arm64v8:10.3-2) is successful to be deleted!

$ hyperctl load -i hyperhq_mariadb-arm64v8_10.3-2.tar

$ hyperctl images | grep 'hyperhq/mariadb-arm64v8'
hyperhq/mariadb-arm64v8           10.3-2        fe0d46e0d08e     2018-08-13 09:20:10   348.5 MB
```

# test run container
```
//run with k8s + frakti + hyperd + cephrbd flexVolume driver
$ rbd create -p hyper --size 1G frakti-rbd-mariadb
$ kubectl create -f pod-mariadb-2-rbd.yaml
```