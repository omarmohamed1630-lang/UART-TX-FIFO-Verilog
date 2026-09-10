module wrapper_tb ;

reg clk;
reg rst;
reg level;

wire [6:0] hex;


wrapper DUT (
    .clk(clk),
    .rst(rst),
    .level(level),
    .hex(hex)
);


initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    rst = 1;
    level = 0;
    @(negedge clk);
    rst = 0;
    @(negedge clk);
    
    check();
    @(negedge clk);

    $stop;
end

task check;

reg [6:0] expected_hex;

    begin
        repeat (30) begin
        level = $random;
        @(negedge clk);

       
        case (DUT.m1.count)
            4'b0000: expected_hex = 7'b0000001;
            4'b0001: expected_hex = 7'b1001111;
            4'b0010: expected_hex = 7'b0010010;
            4'b0011: expected_hex = 7'b0000110;
            4'b0100: expected_hex = 7'b1001100;
            4'b0101: expected_hex = 7'b0100100;
            4'b0110: expected_hex = 7'b0100000;
            4'b0111: expected_hex = 7'b0001111;
            4'b1000: expected_hex = 7'b0000000;
            4'b1001: expected_hex = 7'b0000100;
            4'b1010: expected_hex = 7'b0001001;
            4'b1011: expected_hex = 7'b1100000;
            4'b1100: expected_hex = 7'b0110001;
            4'b1101: expected_hex = 7'b1000010;
            4'b1110: expected_hex = 7'b0110000;
            4'b1111: expected_hex = 7'b0000000;
        endcase
       

        if (hex !== expected_hex) begin
            $display("Test failed: Expected hex = %b, but got hex = %b", expected_hex, hex);
        end else begin
            $display("Test passed: COUNT = %b, hex = %b", DUT.m1.count, hex);
        end
        end
        //$display("t= %0t | Level = %b | COUNT = %b| Hex = %b", $time, level, DUT.m1.count ,hex);
    end
endtask

endmodule //wrapper_tb