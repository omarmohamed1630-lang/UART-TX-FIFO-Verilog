module light_couser_tb;

parameter WIDTH = 10;

reg hold;
reg clk;
reg a_rstn;

wire [WIDTH-1:0] out;

reg [WIDTH-1:0] expected;


// DUT
SHIFT_REG #(.WIDTH(WIDTH)) DUT (
    .hold(hold),
    .clk(clk),
    .a_rstn(a_rstn),
    .out(out)
);


// Clock
always #5 clk = ~clk;


// Self Checking Task
task check_output;
    input [WIDTH-1:0] expected_value;

    begin
        if (out !== expected_value)
            $display("FAIL: Expected = %b, Actual = %b",
                     expected_value, out);
        else
            $display("PASS: Expected = %b, Actual = %b",
                     expected_value, out);
    end
endtask


initial begin

    clk = 0;
    hold = 0;
    a_rstn = 0;

    // Reset
    #1;
    check_output(10'b1000000000);

    // Release reset
    a_rstn = 1;

    // Shift 1
    @(posedge clk);
    #1;
    check_output(10'b0100000000);

    // Shift 2
    @(posedge clk);
    #1;
    check_output(10'b0010000000);

    // Shift 3
    @(posedge clk);
    #1;
    check_output(10'b0001000000);

    // HOLD
    hold = 1;

    @(posedge clk);
    #1;
    check_output(10'b0001000000);

    @(posedge clk);
    #1;
    check_output(10'b0001000000);

    @(posedge clk);
    #1;
    check_output(10'b0001000000);

    // Release HOLD
    hold = 0;

    @(posedge clk);
    #1;
    check_output(10'b0000100000);

    @(posedge clk);
    #1;
    check_output(10'b0000010000);


    $display("TEST FINISHED");
    $stop;

end

endmodule