# Domoticz Docker for RPI (v.8153)

## Domoticz
https://github.com/SeLoRBIS/rpi-domoticz-docker

### Clone
```sh
git clone https://github.com/SeLoRBIS/rpi-domoticz-docker.git
```

### Build and run
```sh
# create volumes
sudo chmod +x create_volumes.sh
./create_volumes.sh
```
```sh
# run image
docker-compose up
```

If you don't have any controller remove the device line in the docker-compose.yml file

```sh
devices:
   - "/dev/ttyACM0:/dev/ttyACM0"
```

### Fix USB ports
https://www.domoticz.com/wiki/PersistentUSBDevices

Modify the com rules files
```sh
sudo nano /etc/udev/rules.d/99-usb-serial.rules
```
or
```sh
sudo nano /etc/udev/rules.d/99-com.rules

```
Add
```sh
SUBSYSTEM=="tty", ATTRS{idVendor}=="0658", ATTRS{idProduct}=="0200", SYMLINK+="ttyUSBZSTICK"
SUBSYSTEM=="tty", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", ATTRS{serial}=="A105GKV2", SYMLINK+="ttyUSBGCE"
SUBSYSTEM=="tty", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", ATTRS{serial}=="A11JICSW", SYMLINK+="ttyUSBRFXCOM"
SUBSYSTEM=="tty", ATTRS{idVendor}=="0403", ATTRS{idProduct}=="6001", ATTRS{serial}=="FT1SERS9", SYMLINK+="ttyUSBENOCEAN"
```

#### Find the contoller number
For Aeotec Z-Stick 
```sh
$ sudo udevadm info --query=all --name=ttyACM0

P: /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.4/1-1.4:1.0/tty/ttyACM0
N: ttyACM0
S: serial/by-id/usb-0658_0200-if00
S: serial/by-path/platform-3f980000.usb-usb-0:1.4:1.0
E: DEVLINKS=/dev/serial/by-id/usb-0658_0200-if00 /dev/serial/by-path/platform-3f980000.usb-usb-0:1.4:1.0
E: DEVNAME=/dev/ttyACM0
E: DEVPATH=/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.4/1-1.4:1.0/tty/ttyACM0
E: ID_BUS=usb
E: ID_MODEL=0200
E: ID_MODEL_ENC=0200
E: ID_MODEL_ID=0200
E: ID_PATH=platform-3f980000.usb-usb-0:1.4:1.0
E: ID_PATH_TAG=platform-3f980000_usb-usb-0_1_4_1_0
E: ID_REVISION=0000
E: ID_SERIAL=0658_0200
E: ID_TYPE=generic
E: ID_USB_CLASS_FROM_DATABASE=Communications
E: ID_USB_DRIVER=cdc_acm
E: ID_USB_INTERFACES=:020201:0a0000:
E: ID_USB_INTERFACE_NUM=00
E: ID_VENDOR=0658
E: ID_VENDOR_ENC=0658
E: ID_VENDOR_FROM_DATABASE=Sigma Designs, Inc.
E: ID_VENDOR_ID=0658
E: MAJOR=166
E: MINOR=0
E: SUBSYSTEM=tty
E: TAGS=:systemd:
E: USEC_INITIALIZED=99780
```

For GCE Electronics Module TeleInfo USB
```sh
$ sudo udevadm info --query=all --name=ttyUSB0
P: /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.5/1-1.5:1.0/ttyUSB0/tty/ttyUSB0
N: ttyUSB0
S: serial/by-id/usb-FTDI_FT232R_USB_UART_A105GKV2-if00-port0
S: serial/by-path/platform-3f980000.usb-usb-0:1.5:1.0-port0
E: DEVLINKS=/dev/serial/by-id/usb-FTDI_FT232R_USB_UART_A105GKV2-if00-port0 /dev/serial/by-path/platform-3f980000.usb-usb-0:1.5:1.0-port0
E: DEVNAME=/dev/ttyUSB0
E: DEVPATH=/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.5/1-1.5:1.0/ttyUSB0/tty/ttyUSB0
E: ID_BUS=usb
E: ID_MODEL=FT232R_USB_UART
E: ID_MODEL_ENC=FT232R\x20USB\x20UART
E: ID_MODEL_FROM_DATABASE=FT232 USB-Serial (UART) IC
E: ID_MODEL_ID=6001
E: ID_PATH=platform-3f980000.usb-usb-0:1.5:1.0
E: ID_PATH_TAG=platform-3f980000_usb-usb-0_1_5_1_0
E: ID_REVISION=0600
E: ID_SERIAL=FTDI_FT232R_USB_UART_A105GKV2
E: ID_SERIAL_SHORT=A105GKV2
E: ID_TYPE=generic
E: ID_USB_DRIVER=ftdi_sio
E: ID_USB_INTERFACES=:ffffff:
E: ID_USB_INTERFACE_NUM=00
E: ID_VENDOR=FTDI
E: ID_VENDOR_ENC=FTDI
E: ID_VENDOR_FROM_DATABASE=Future Technology Devices International, Ltd
E: ID_VENDOR_ID=0403
E: MAJOR=188
E: MINOR=0
E: SUBSYSTEM=tty
E: TAGS=:systemd:
E: USEC_INITIALIZED=38987341
```
For EnOcean USB Stick
```sh
$ sudo udevadm info --query=all --name=ttyUSB0
P: /devices/platform/soc/3f980000.usb/usb1/1-1/1-1.5/1-1.5:1.0/ttyUSB0/tty/ttyUSB0
N: ttyUSB0
S: serial/by-id/usb-EnOcean_GmbH_EnOcean_USB_300_DB_FT1SERS9-if00-port0
S: serial/by-path/platform-3f980000.usb-usb-0:1.5:1.0-port0
E: DEVLINKS=/dev/serial/by-id/usb-EnOcean_GmbH_EnOcean_USB_300_DB_FT1SERS9-if00-port0 /dev/serial/by-path/platform-3f980000.usb-usb-0:1.5:1.0-port0
E: DEVNAME=/dev/ttyUSB0
E: DEVPATH=/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.5/1-1.5:1.0/ttyUSB0/tty/ttyUSB0
E: ID_BUS=usb
E: ID_MODEL=EnOcean_USB_300_DB
E: ID_MODEL_ENC=EnOcean\x20USB\x20300\x20DB
E: ID_MODEL_FROM_DATABASE=FT232 Serial (UART) IC
E: ID_MODEL_ID=6001
E: ID_PATH=platform-3f980000.usb-usb-0:1.5:1.0
E: ID_PATH_TAG=platform-3f980000_usb-usb-0_1_5_1_0
E: ID_REVISION=0600
E: ID_SERIAL=EnOcean_GmbH_EnOcean_USB_300_DB_FT1SERS9
E: ID_SERIAL_SHORT=FT1SERS9
E: ID_TYPE=generic
E: ID_USB_DRIVER=ftdi_sio
E: ID_USB_INTERFACES=:ffffff:
E: ID_USB_INTERFACE_NUM=00
E: ID_VENDOR=EnOcean_GmbH
E: ID_VENDOR_ENC=EnOcean\x20GmbH
E: ID_VENDOR_FROM_DATABASE=Future Technology Devices International, Ltd
E: ID_VENDOR_ID=0403
E: MAJOR=188
E: MINOR=0
E: SUBSYSTEM=tty
E: TAGS=:systemd:
E: USEC_INITIALIZED=3926090
```

### Run without docker-compose

#### With 1 USB port no fixing
```sh
sudo docker run 
--device=/dev/ttyACM0 
-v /etc/localtime:/etc/localtime 
-v /home/pi/Dev/domoticz-docker/volumes/backup/domoticz.db:/root/domoticz/domoticz.db:rw 
-v /home/pi/Dev/domoticz-docker/volumes/images:/root/domoticz/www/images/floorplans:rw 
-v /home/pi/Dev/domoticz-docker/volumes/scripts:/root/domoticz/scripts/perso:rw
-p 8084:8080 -p 23:23
--name domoticz --restart=always -d my_domoticz
```

#### With 2 USB ports fixing
```sh
 sudo docker run 
 --device=/dev/ttyUSBZSTICK 
 --device=/dev/ttyUSBGCE 
 -v /etc/localtime:/etc/localtime 
 -v /home/pi/Dev/domoticz-docker/volumes/backup/domoticz.db:/root/domoticz/domoticz.db:rw 
 -v /home/pi/Dev/domoticz-docker/volumes/images:/root/domoticz/www/images/floorplans:rw 
 -v /home/pi/Dev/domoticz-docker/volumes/scripts:/root/domoticz/scripts/perso:rw
 -p 8084:8080
 --name domoticz --restart=always -d my_domoticz
```
