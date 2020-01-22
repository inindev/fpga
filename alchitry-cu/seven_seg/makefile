
all: seven_seg.bin

prog: seven_seg.bin
	iceprog seven_seg.bin

reset:
	iceprog .

seven_seg.blif: seven_seg.v
	yosys -p 'synth_ice40 -top seven_seg -blif seven_seg.blif' seven_seg.v

seven_seg.asc: seven_seg.blif seven_seg.pcf
	arachne-pnr -d 8k -P cb132 -p seven_seg.pcf -o seven_seg.asc seven_seg.blif

seven_seg.bin: seven_seg.asc
	icetime -d hx8k -c 100 seven_seg.asc
	icepack seven_seg.asc seven_seg.bin

clean:
	rm -f seven_seg.blif seven_seg.asc seven_seg.bin

.PHONY: all prog reset clean
