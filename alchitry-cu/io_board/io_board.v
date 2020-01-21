module io_board (
    input clk,
    input rst_n,
    output reg [7:0] led,
    output reg [23:0] io_led,
    output reg [3:0] io_sel,
    output reg [7:0] io_seg,
    input usb_rx,
    output reg usb_tx
  );

wire rst = ~rst_n;

initial begin
//   led = 8'h55;
//   io_led = 24'h55_55_55;
   io_sel = 4'h0;
   io_seg = 8'h40;
end

genvar i;
generate
  for(i=0; i<8; i=i+1) begin: pwm_array
    pwm_module #(.PD_CNT(3)) pwm_inst (
      .clk(clk),
      .rst(rst),
      .duty_cnt(i),
      .pwm(led[i])
    );
  end

  for(i=0; i<24; i=i+1) begin: pwm_array2
    pwm_module #(.PD_CNT(5)) pwm_inst2 (
      .clk(clk),
      .rst(rst),
      .duty_cnt(i+4),
      .pwm(io_led[i])
    );
  end
endgenerate

endmodule
