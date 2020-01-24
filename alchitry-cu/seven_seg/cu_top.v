
module cu_top (
    input clk,
    input rst_n,
    output reg [7:0] led,
    output reg [3:0] io_sel,
    output reg [7:0] io_seg,
    output reg [23:0] io_led,
    input usb_rx,
    output reg usb_tx
  );

  parameter DIRECTION = 1;
  parameter MSB = 5'h14;
  reg [MSB:0] counter = 0;
  reg [6:0] counter2 = 0;

  reg [1:0] state = 0;

  reg [7:0] data = 8'hfc;
  reg [23:0] data2 = 24'hff_ff_fc;
  assign led = data;
  assign io_led = data2;

  //
  //                         a
  //                        ---
  //                     f |   | b
  //                        -g-
  //                     e |   | c
  //                        --- .
  //                         d
  //
  //                      .gfedcba
  parameter SEG_0   = ~8'b00111111;  // 0
  parameter SEG_1   = ~8'b00000110;  // 1
  parameter SEG_2   = ~8'b01011011;  // 2
  parameter SEG_3   = ~8'b01001111;  // 3
  parameter SEG_4   = ~8'b01100110;  // 4
  parameter SEG_5   = ~8'b01101101;  // 5
  parameter SEG_6   = ~8'b01111101;  // 6
  parameter SEG_7   = ~8'b00000111;  // 7
  parameter SEG_8   = ~8'b01111111;  // 8
  parameter SEG_9   = ~8'b01101111;  // 9
  parameter SEG_A   = ~8'b01110111;  // A
  parameter SEG_B   = ~8'b01111100;  // b
  parameter SEG_C   = ~8'b00111001;  // C
  parameter SEG_D   = ~8'b01011110;  // d
  parameter SEG_E   = ~8'b01111001;  // E
  parameter SEG_F   = ~8'b01110001;  // F
  parameter SEG_DOT = ~8'b10000000;  // .

  always @* begin
  end

  always @(posedge clk) begin
    counter <= counter + 1;

    if(counter[MSB-2:0] == 0) begin
      // seven segment display
      if(counter2 < 7'h40) begin
        if(state == 2'b00) begin
          io_sel = ~4'b1000;
          io_seg = SEG_D;
        end else if(state == 2'b01) begin
          io_sel = ~4'b0100;
          io_seg = SEG_E;
        end else if(state == 2'b10) begin
          io_sel = ~4'b0010;
          io_seg = SEG_A;
        end else if(state == 2'b11) begin
          io_sel = ~4'b0001;
          io_seg = SEG_D;
        end
      end else begin
        if(state == 2'b00) begin
          io_sel = ~4'b1000;
          io_seg = SEG_B;
        end else if(state == 2'b01) begin
          io_sel = ~4'b0100;
          io_seg = SEG_E;
        end else if(state == 2'b10) begin
          io_sel = ~4'b0010;
          io_seg = SEG_E;
        end else if(state == 2'b11) begin
          io_sel = ~4'b0001;
          io_seg = SEG_F;
        end
      end

      state <= state + 1;
    end

    if(counter == 0) begin
      counter2 <= counter2 + 1;
      if(DIRECTION == 0) begin
        data <= (data << 1);
        data2 <= (data2 << 1);
        data[0] <= data[7];
        data2[0] <= data2[23];
      end else begin
        data <= (data >> 1);
        data2 <= (data2 >> 1);
        data[7] <= data[0];
        data2[23] <= data2[0];
      end
    end
  end

endmodule
