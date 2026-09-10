module full_module_tb ;

parameter WIDTH = 20;

reg clk;
reg rst_n;
reg wr_en;
reg rd_en;
reg [7:0] addr;
reg [WIDTH-1:0] din;

wire [7:0] d_out;
wire a_is_zero;

full_module DUT (
    .clk(clk),
    .rst_n(rst_n),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .addr(addr),
    .din(din),
    .d_out(d_out),
    .a_is_zero(a_is_zero)
);

always #5 clk =~ clk ;

integer i;
initial begin
    $monitor("t = %0t din = %b dout = %b a_is_zero = %b", $time , din , d_out , a_is_zero);
   clk=0;
   rst_n=0;
   wr_en=0;
   rd_en=0;
   addr='b0;
   din='b0;
   @(negedge clk) 

    rst_n=1;
    din=$random;
    wr_en=1;
    @(negedge clk);

    wr_en=0;
    @(negedge clk);

    rd_en=1'b1;
    @(negedge clk);
    rd_en=0;
    repeat(20)@(negedge clk);
/*
    for (i =0 ; i<WIDTH; i=i+1) begin
        @(negedge clk);
        check(din[WIDTH-1-i]);
    end
*/
end
/*
task check (input exp_out);
    begin
        if (serial_out != exp_out) begin
            $display("fail t = %0t got = %b exp = %b", $time , serial_out , exp_out);
        end
        else begin
          $display("pass t = %0t ", $time );
        end
    end
endtask
*/


endmodule //full_module_tb