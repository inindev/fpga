
all: seven_seg.bin

prog: seven_seg.bin
	iceprog $^

reset:
	iceprog .

merged.pcf: cu.pcf io.pcf
	cat $^ > $@

seven_seg.json: cu_top.v
	yosys -p 'synth_ice40 -top cu_top -json $@' $^

seven_seg.asc: seven_seg.json merged.pcf
	nextpnr-ice40 --hx8k --package cb132 --json seven_seg.json  --pcf merged.pcf  --asc $@

seven_seg.bin: seven_seg.asc
	icetime -d hx8k -c 100 $^
	icepack $^ $@

clean:
	rm -f merged.pcf seven_seg.json seven_seg.asc seven_seg.bin

.PHONY: all prog reset clean
