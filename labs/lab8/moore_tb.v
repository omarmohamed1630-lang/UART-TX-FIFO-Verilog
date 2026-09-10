module moore_tb ;

reg clk;
reg rst;
reg level;

wire tec;

detector_moore uut (
    .clk(clk),
    .rst(rst),
    .level(level),
    .tec(tec)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin 
    rst = 1;
    level = 0;
    #10;
    rst = 0;
    #12; 
    level = 1;
    #10;
    
end
endmodule //moore_tb