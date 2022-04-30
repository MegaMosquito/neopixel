FROM ubuntu:bionic

# Install pip
RUN apt update && apt install -y python3.7 python3-pip
RUN pip3 install --upgrade setuptools

# Install Neopixel support software, and Flask
RUN pip3 install RPi.GPIO rpi_ws281x adafruit-circuitpython-neopixel Flask

# Copy over the source
COPY neopixel_server.py /
COPY index.html /
COPY favicon.ico /
WORKDIR /

# Run the daemon
CMD python3 neopixel_server.py
