
all: io_board.bin

prog: io_board.bin
	iceprog $^

reset:
	iceprog .

io_board.json: cu_top.v pwm_module.v
	yosys -p 'synth_ice40 -top cu_top -json $@' $^

io_board.asc: io_board.json io_board.pcf
	nextpnr-ice40 --hx8k --package cb132 --json io_board.json  --pcf io_board.pcf  --asc $@

io_board.bin: io_board.asc
	icetime -d hx8k -c 100 $^
	icepack $^ $@

clean:
	rm -f io_board.json io_board.asc io_board.bin

.PHONY: all prog reset clean
