FROM raspbian/stretch

# Install pip
RUN apt update && apt install -y python3-pip

# Install Neopixel support software, and Flask
RUN pip3 install rpi_ws281x adafruit-circuitpython-neopixel Flask

# Copy over the source
COPY neopixel_server.py /
WORKDIR /

# Run the daemon
CMD python3 neopixel_server.py
