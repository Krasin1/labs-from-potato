#!/bin/sh

javac Matrix.java Server.java
java Server > /dev/null &

java Matrix 

pkill -9 -f java
