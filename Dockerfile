FROM ubuntu

# Install pip
RUN apt update && apt install -y python3 python3-dev python3-pip
RUN pip3 install --break-system-packages --upgrade pi setuptools

# Install Neopixel support software, and Flask
RUN pip3 install --break-system-packages --force-reinstall RPi.GPIO rpi_ws281x adafruit-blinka adafruit-circuitpython-pixelbuf adafruit-io adafruit-circuitpython-neopixel Flask

# Copy over the source
COPY neopixel_server.py /
COPY index.html /
COPY favicon.ico /
WORKDIR /

# Run the daemon
CMD [ "python3", "neopixel_server.py" ]
