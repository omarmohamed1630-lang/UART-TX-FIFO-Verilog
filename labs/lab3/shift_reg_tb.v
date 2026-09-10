module shift_reg_tb ;

reg   d_in;
reg    clk;
reg a_rstn;
    
wire [7:0] d_out;

sipo_reg DUT (
    .d_in(d_in),
    .clk(clk),
    .a_rstn(a_rstn),
    .d_out(d_out)

);

always #5 clk=~clk;

initial begin
    clk = 0;
    d_in = $random;
    a_rstn = 0;
    #10;

    a_rstn = 1;
    repeat (10) begin
      @(negedge clk);
      d_in = $random;
    end

end

endmodule 