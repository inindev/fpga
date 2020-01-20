
module sweep (
    input clk,
    input rst_n,
    output reg [7:0] led,
    input usb_rx,
    output reg usb_tx
  );

  parameter DIRECTION = 0;
  parameter MSB = 5'h16;

  reg [MSB:0] counter = 0;
  reg [7:0] data = 8'hfc;
  assign led = data;

  always @(posedge clk) begin
    counter <= counter + 1;

    if(counter == 0) begin
      if(DIRECTION == 0) begin
        data <= (data << 1);
        data[0] <= data[7];
      end else begin
        data <= (data >> 1);
        data[7] <= data[0];
      end
    end
  end

endmodule
