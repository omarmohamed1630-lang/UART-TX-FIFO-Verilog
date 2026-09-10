module ram_tb ;

parameter WIDTH = 20;

reg clk;
reg rst_n;
reg wr_en;
reg rd_en;
reg [7:0] addr;
reg [WIDTH-1:0] din;

wire serial_out;
wire valid;

ram_piso DUT (
    .clk(clk),
    .rst_n(rst_n),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .addr(addr),
    .din(din),
    .serial_out(serial_out),
    .valid(valid)
);

always #5 clk =~ clk ;

integer i;
initial begin
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
    

    for (i =0 ; i<WIDTH; i=i+1) begin
        @(negedge clk);
        check(din[WIDTH-1-i]);
    end

end

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


endmodule //ram_tb