
all: sweep.bin

prog: sweep.bin
	iceprog sweep.bin

reset:
	iceprog .

sweep.blif: sweep.v
	yosys -p 'synth_ice40 -top sweep -blif sweep.blif' sweep.v

sweep.asc: sweep.blif sweep.pcf
	arachne-pnr -d 8k -P cb132 -p sweep.pcf -o sweep.asc sweep.blif

sweep.bin: sweep.asc
	icetime -d hx8k -c 100 sweep.asc
	icepack sweep.asc sweep.bin

clean:
	rm -f sweep.blif sweep.asc sweep.bin

.PHONY: all prog reset clean
