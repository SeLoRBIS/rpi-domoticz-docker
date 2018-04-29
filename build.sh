#! /bin/bash

# create volumes
sudo mkdir volumes
cd volumes
sudo mkdir backup
sudo mkdir images
sudo mkdir scripts
# create database volume
cd backup
sudo touch domoticz.db
# make volumes folder writable
cd ../..
sudo chmod -R 777 volumes/
