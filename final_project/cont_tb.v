`timescale 1ns/1ps

module fifo_cont_tb;

reg clk;
reg rst_n;

reg busy;
reg empty;

wire rd_en;
wire tx_data_valid;


// DUT
fifo_controller DUT (

    .clk(clk),
    .rst_n(rst_n),

    .busy(busy),
    .empty(empty),

    .rd_en(rd_en),
    .tx_data_valid(tx_data_valid)

);


// Clock = 200 MHz
// Period = 5 ns

initial begin
    clk = 1'b0;

    forever #2.5 clk = ~clk;
end


initial begin

    // Initial values

    rst_n = 1'b0;
    busy  = 1'b0;
    empty = 1'b1;


    $display("================================");
    $display("   FIFO CONTROLLER TEST START");
    $display("================================");


    // =====================================
    // Reset
    // =====================================

    @(negedge clk);

    rst_n = 1'b1;

    @(posedge clk);
    #1;

    if (rd_en == 1'b0 && tx_data_valid == 1'b0)
        $display("PASS | RESET | IDLE");
    else
        $display("FAIL | RESET");


    // =====================================
    // TEST 1
    // FIFO Empty
    // =====================================

    $display("");
    $display("===== TEST 1 : FIFO EMPTY =====");

    empty = 1'b1;
    busy  = 1'b0;

    @(posedge clk);
    #1;

    if (rd_en == 1'b0 && tx_data_valid == 1'b0)
        $display("PASS | EMPTY -> IDLE");
    else
        $display("FAIL | EMPTY -> IDLE");


    // =====================================
    // TEST 2
    // FIFO has data
    // UART not busy
    // =====================================

    $display("");
    $display("===== TEST 2 : FIFO HAS DATA =====");

    empty = 1'b0;
    busy  = 1'b0;

    @(posedge clk);
    #1;

    // Should enter READ
    if (rd_en == 1'b1 && tx_data_valid == 1'b0)
        $display("PASS | READ | rd_en = 1");
    else
        $display("FAIL | READ");


    // =====================================
    // TEST 3
    // SEND
    // =====================================

    $display("");
    $display("===== TEST 3 : SEND =====");

    @(posedge clk);
    #1;

    if (rd_en == 1'b0 && tx_data_valid == 1'b1)
        $display("PASS | SEND | tx_data_valid = 1");
    else
        $display("FAIL | SEND");


    // =====================================
    // TEST 4
    // Return to IDLE
    // =====================================

    $display("");
    $display("===== TEST 4 : RETURN IDLE =====");

    @(posedge clk);
    #1;

    if (rd_en == 1'b0 && tx_data_valid == 1'b0)
        $display("PASS | SEND -> IDLE");
    else
        $display("FAIL | SEND -> IDLE");


    // =====================================
    // TEST 5
    // UART Busy
    // =====================================

    $display("");
    $display("===== TEST 5 : UART BUSY =====");

    empty = 1'b0;
    busy  = 1'b1;

    @(posedge clk);
    #1;

    if (rd_en == 1'b0 && tx_data_valid == 1'b0)
        $display("PASS | BUSY -> IDLE");
    else
        $display("FAIL | BUSY");


    // =====================================
    // Finish
    // =====================================

    $display("");
    $display("================================");
    $display("   FIFO CONTROLLER TEST END");
    $display("================================");

    $finish;

end

endmodule