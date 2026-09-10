`timescale 1ns/1ps

module piso_tb;

parameter WIDTH = 8;

reg clk;
reg rst_n;
reg [WIDTH-1:0] parallel_in;
reg en;

wire serial_out;
wire valid;


// DUT
piso #(WIDTH) DUT (

    .clk(clk),
    .rst_n(rst_n),
    .parallel_in(parallel_in),
    .en(en),

    .serial_out(serial_out),
    .valid(valid)

);


// Clock
always #5 clk = ~clk;


// Test Task
task test;

    input [WIDTH-1:0] data;

    integer i;

    begin

        // Load data
        @(negedge clk);
        parallel_in = data;
        en = 1;

        // Wait for load
        @(negedge clk);
        en = 0;


        // Check 8 bits
        for (i = 0; i < WIDTH; i = i + 1) begin

            @(negedge clk);

            if (serial_out == data[i])
                $display("PASS | Bit %0d | Expected = %b | Actual = %b",
                         i, data[i], serial_out);

            else
                $display("FAIL | Bit %0d | Expected = %b | Actual = %b",
                         i, data[i], serial_out);

        end


        // Check valid after all bits
        @(negedge clk);

        if (valid == 0)
            $display("PASS | VALID = 0 after transmission");

        else
            $display("FAIL | VALID should be 0");

    end

endtask


// Stimulus
initial begin

    clk = 0;
    rst_n = 0;
    en = 0;
    parallel_in = 0;


    // Reset
    #10;
    rst_n = 1;


    // Test different data

    test(8'b10110110);

    test(8'b11110000);

    test(8'b01010101);

    test(8'b00000000);

    test(8'b11111111);


    #20;

    $finish;

end

endmodule