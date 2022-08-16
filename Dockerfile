FROM ubuntu:bionic

# Install pip
RUN apt update && apt install -y python3.7 python3.7-dev python3-pip
RUN rm /usr/bin/python3 && ln -s /usr/bin/python3.7 /usr/bin/python3
RUN pip3 install --upgrade pip setuptools

# Install Neopixel support software, and Flask
RUN pip3 install --force-reinstall RPi.GPIO rpi_ws281x adafruit-blinka adafruit-circuitpython-pixelbuf adafruit-io adafruit-circuitpython-neopixel Flask

# Copy over the source
COPY neopixel_server.py /
COPY index.html /
COPY favicon.ico /
WORKDIR /

# Run the daemon
CMD python3.7 neopixel_server.py
