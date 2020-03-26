all: build run

build:
	docker build -t ibmosquito/neopixel_server:1.0.0 .

dev: build stop
	-docker rm -f neopixel_server 2> /dev/null || :
	docker run -it --privileged --name neopixel_server -p 7777:7777 --volume `pwd`:/outside ibmosquito/neopixel_server:1.0.0 /bin/bash

run: stop
	-docker rm -f speedtest 2>/dev/null || :
	docker run -d --privileged --name neopixel_server -p 7777:7777 ibmosquito/neopixel_server:1.0.0

test:
	curl -X POST -sS localhost:7777/neopixel/v1/init/18/1
	curl -X POST -sS localhost:7777/neopixel/v1/0/255/0/0
	sleep 1
	curl -X POST -sS localhost:7777/neopixel/v1/0/0/255/0
	sleep 1
	curl -X POST -sS localhost:7777/neopixel/v1/0/0/0/255
	sleep 1
	curl -X POST -sS localhost:7777/neopixel/v1/0/0/0/0

zooba:
	curl -X POST -sS localhost:7777/neopixel/v1/init/18/1
	while [ 1 ]; \
	do \
	  curl -X POST -sS localhost:7777/neopixel/v1/0/255/0/0; \
	  sleep 1; \
	  curl -X POST -sS localhost:7777/neopixel/v1/0/0/255/0; \
	  sleep 1; \
	  curl -X POST -sS localhost:7777/neopixel/v1/0/0/0/255; \
	  sleep 1; \
	done
	curl -X POST -sS localhost:7777/neopixel/v1/0/0/0/0

exec:
	docker exec -it neopixel_server /bin/sh

push:
	docker push ibmosquito/neopixel_server:1.0.0

stop:
	-docker rm -f neopixel_server 2>/dev/null || :

clean: stop
	-docker rmi ibmosquito/neopixel_server:1.0.0 2>/dev/null || :

.PHONY: all build dev run test exec stop clean
