
all: sweep.bin

prog: sweep.bin
	iceprog $^

reset:
	iceprog .

sweep.json: cu_top.v
	yosys -p 'synth_ice40 -top cu_top -json $@' $^

sweep.asc: sweep.json cu.pcf
	nextpnr-ice40 --hx8k --package cb132 --json sweep.json  --pcf cu.pcf  --asc $@

sweep.bin: sweep.asc
	icetime -d hx8k -c 100 $^
	icepack $^ $@

clean:
	rm -f sweep.json sweep.asc sweep.bin

.PHONY: all prog reset clean
