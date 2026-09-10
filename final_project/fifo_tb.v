`timescale 1ns/1ps

module fifo_tb;

parameter DATA_WIDTH = 8;
parameter DEPTH = 10;


// inputs
reg clk;
reg rst_n;

reg [DATA_WIDTH-1:0] data_in;
reg wr_en;
reg rd_en;


// outputs
wire [DATA_WIDTH-1:0] data_out;
wire full;
wire empty;


// expected data
reg [DATA_WIDTH-1:0] expected_data [0:DEPTH-1];

integer i;


// DUT
fifo #(
    .DATA_WIDTH(DATA_WIDTH),
    .DEPTH(DEPTH)
) DUT (

    .clk(clk),
    .rst_n(rst_n),

    .data_in(data_in),
    .wr_en(wr_en),
    .rd_en(rd_en),

    .data_out(data_out),
    .full(full),
    .empty(empty)

);


// clock = 200 MHz
// period = 5 ns

initial begin
    clk = 1'b0;

    forever #2.5 clk = ~clk;
end


// test
initial begin

    // initial values
    rst_n   = 1'b0;
    data_in = 8'b0;
    wr_en   = 1'b0;
    rd_en   = 1'b0;


    $display("==============================");
    $display("       FIFO TEST START");
    $display("==============================");


    // reset
    #10;

    rst_n = 1'b1;


    // check empty after reset
    if (empty == 1'b1)
        $display("PASS | FIFO is empty after reset");
    else
        $display("FAIL | FIFO is not empty after reset");


    // ==============================
    // WRITE TEST
    // ==============================

    $display("");
    $display("===== WRITE TEST =====");


    for (i = 0; i < DEPTH; i = i + 1) begin

        @(negedge clk);

        data_in = i;
        expected_data[i] = i;
        wr_en = 1'b1;

        @(negedge clk);

        wr_en = 1'b0;

        $display("WRITE | data = %08b", data_in);

    end


    // FIFO should be full
    @(negedge clk);

    if (full == 1'b1)
        $display("PASS | FIFO FULL");
    else
        $display("FAIL | FIFO FULL");


    // ==============================
    // READ TEST
    // ==============================

    $display("");
    $display("===== READ TEST =====");


    for (i = 0; i < DEPTH; i = i + 1) begin

        @(negedge clk);

        rd_en = 1'b1;

        @(posedge clk);
        #1;

        if (data_out == expected_data[i]) begin

            $display(
                "PASS | READ | Expected = %08b | Actual = %08b",
                expected_data[i],
                data_out
            );

        end

        else begin

            $display(
                "FAIL | READ | Expected = %08b | Actual = %08b",
                expected_data[i],
                data_out
            );

        end

        rd_en = 1'b0;

    end


    // FIFO should be empty
    @(negedge clk);

    if (empty == 1'b1)
        $display("PASS | FIFO EMPTY");
    else
        $display("FAIL | FIFO EMPTY");


    // ==============================
    // FINISH
    // ==============================

    $display("");
    $display("==============================");
    $display("        FIFO TEST END");
    $display("==============================");

    $finish;

end

endmodule