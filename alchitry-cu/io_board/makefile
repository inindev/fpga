
all: io_board.bin

prog: io_board.bin
	iceprog io_board.bin

reset:
	iceprog .

io_board.blif: io_board.v pwm_module.v
	yosys -p 'synth_ice40 -top io_board -blif io_board.blif' io_board.v pwm_module.v

io_board.asc: io_board.blif io_board.pcf
	arachne-pnr -d 8k -P cb132 -p io_board.pcf -o io_board.asc io_board.blif

io_board.bin: io_board.asc
	icetime -d hx8k -c 100 io_board.asc
	icepack io_board.asc io_board.bin

clean:
	rm -f io_board.blif io_board.asc io_board.bin

.PHONY: all prog reset clean
