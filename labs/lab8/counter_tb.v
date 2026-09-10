module counter_tb ;

reg clk;
reg rst;
reg enable;

wire [3:0] count;

edge_counter DUT (
    .clk(clk),
    .reset(rst),
    .enable(enable),
    .count(count)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin 
    rst = 1;
    enable = 0;
    @(negedge clk);
    rst = 0;
    @(negedge clk);
    enable = 1;
    @(negedge clk);
    enable = 0;
    @(negedge clk);
    enable = 1;
    @(negedge clk);
    enable = 0;
    @(negedge clk);
    @(negedge clk);
    enable = 1;
    @(negedge clk);
    enable = 0;
    @(negedge clk);
    enable = 1;
    @(negedge clk);
    enable = 0;
    @(negedge clk);
end

endmodule //counter_tb