# docker-neopixel

A docker container providing a REST service to control NeoPixels (e.g., WS2812)  on a Raspberry Pi.

Before you can do anything else with this service, you must use the "init" POST API to tell it which Broadcom GPIO number the NeoPixel signal line is connected to, and the number of NeoPixels in your NeoPixel string. For the Broadcom GPIO number you must use the Broadcom GPIO numbering (i.e., the numbering of the pins on the Broadcom SOC) and *not* the "board" pin numbering (i.e., the sequential pin numbers as they appear on the board connector). The board pin numbers are shown in parentheses, i.e., "()", in the table below, while the Broadcom pin numbers are shown on either side of them with "GPIO" prefixes:

```
   3V3  (1) (2)  5V    
 GPIO2  (3) (4)  5V    
 GPIO3  (5) (6)  GND   
 GPIO4  (7) (8)  GPIO14
   GND  (9) (10) GPIO15
GPIO17 (11) (12) GPIO18
GPIO27 (13) (14) GND   
GPIO22 (15) (16) GPIO23
   3V3 (17) (18) GPIO24
GPIO10 (19) (20) GND   
 GPIO9 (21) (22) GPIO25
GPIO11 (23) (24) GPIO8 
   GND (25) (26) GPIO7 
 GPIO0 (27) (28) GPIO1 
 GPIO5 (29) (30) GND   
 GPIO6 (31) (32) GPIO12
GPIO13 (33) (34) GND   
GPIO19 (35) (36) GPIO16
GPIO26 (37) (38) GPIO20
   GND (39) (40) GPIO21
```

For example, to use GPIO #18, you will need to connect your NeoPixel signal wire to physical board pin number 12.

After you have initialized the NeoPixel library with that "init" call, you can begin using the "POST" pin number API shown below. Note that each of the red, green, and blue pixel values must be provided as digital numbers in the range 0...255.

## Usage:

```
make build
make run
```

After doing that, you should be able to use the REST APIs described below. A quick test can be done with this command:

```
make test
```

## API details in brief...

### MODE:

You must set the mode before doing anything else with this service.

`POST "/neopixel/v1/init/<bcmgpio>/<count>"`:
 - where `<bcmgpio>` is where you connected the NeoPixel signal wire, and
 - `<count>` is the number fo NeoPixels in your NeoPixel string

### POST:

Set the color of a NeoPixel

`POST "/neopixel/v1/<pixel>/<r>/<g>/<b>"`:
 - where `<pixel>` is the NeoPixel number (0 is the first), and
 - and `<r>`, `<g>`, and `<b>` are the red, green and blue components of the color you wish to set on this NeoPixel (each must be in the range 0...255).


