FROM raspbian/stretch

# Install pip
RUN apt update && apt install -y python3-pip

# Install Neopixel support software
RUN pip3 install rpi_ws281x adafruit-circuitpython-neopixel

# Copy over the source
COPY pixel.py /
WORKDIR /

# Run the daemon
CMD python3 pixel.py
