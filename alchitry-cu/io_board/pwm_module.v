module pwm_module #(parameter PD_CNT = 8) (
    input clk,
	input rst,
    input [PD_CNT-1:0] duty_cnt,
    output reg pwm
  );

reg pwm_d, pwm_q;
reg [PD_CNT-1:0] ctr_d, ctr_q;

assign pwm = pwm_q;

always @* begin
  ctr_d = ctr_q + 1;
  if(duty_cnt > ctr_q) begin
    pwm_d = 1'b1;
  end else begin
    pwm_d = 1'b0;
  end
end

always @(posedge clk) begin
  if(~rst) begin
    ctr_q <= ctr_d;
  end else begin
    ctr_q <= 1'b0;
  end

  pwm_q <= pwm_d;
end

endmodule
