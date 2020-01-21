#!/bin/sh -e

# Alchitry-Cu
# iCE40-HX8K-CB132
# hx    8k    cb132
# -hx8k --package cb132

NAME='seven_seg'

# clean
if [ "$1" == "clean" ]; then
    rm -f *.{bin,blif,txt}
    exit $?
fi

yosys -p "synth_ice40 -blif $NAME.blif" *.v

arachne-pnr -d 8k -P cb132 -p $NAME.pcf -o $NAME.txt $NAME.blif

icepack $NAME.txt $NAME.bin

iceprog $NAME.bin
