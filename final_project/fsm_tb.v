`timescale 1ns/1ps

module FSM_tb;

    // Inputs
    reg data_valid;
    reg ser_done;
    reg par_en;
    reg rst_n;
    reg clk;

    // Outputs
    wire ser_en;
    wire [1:0] mux_sel;
    wire busy;


    // States للتشيك
    parameter IDLE   = 3'b000;
    parameter START  = 3'b001;
    parameter DATA   = 3'b010;
    parameter PARITY = 3'b011;
    parameter STOP   = 3'b100;


    // DUT
    FSM DUT (

        .data_valid(data_valid),
        .ser_done(ser_done),
        .par_en(par_en),
        .rst_n(rst_n),
        .clk(clk),

        .ser_en(ser_en),
        .mux_sel(mux_sel),
        .busy(busy)

    );


    // Clock
    initial begin
        clk = 0;

        forever #5 clk = ~clk;
    end


    // ==========================
    // Task للتشيك
    // ==========================

    task check;

        input [2:0] expected_state;
        input expected_ser_en;
        input [1:0] expected_mux_sel;
        input expected_busy;

        begin

            #1;

            if ((DUT.cs == expected_state) &&
                (ser_en == expected_ser_en) &&
                (mux_sel == expected_mux_sel) &&
                (busy == expected_busy))

                $display("PASS");

            else begin

                $display("FAIL");

                $display(
                    "State=%b Expected=%b | ser_en=%b Expected=%b | mux=%b Expected=%b | busy=%b Expected=%b",

                    DUT.cs,
                    expected_state,

                    ser_en,
                    expected_ser_en,

                    mux_sel,
                    expected_mux_sel,

                    busy,
                    expected_busy
                );

            end

        end

    endtask


    // ==========================
    // Test
    // ==========================

    initial begin

        // Initial Values
        rst_n      = 0;
        data_valid = 0;
        ser_done   = 0;
        par_en     = 0;

        // Reset Test
        #10;

        check(IDLE, 0, 2'b00, 0);


        // Release Reset
        rst_n = 1;

        @(posedge clk);


        // ==========================
        // TEST 1
        // IDLE → START
        // ==========================

        data_valid = 1;

        @(posedge clk);

        check(START, 0, 2'b01, 1);


        // ==========================
        // TEST 2
        // START → DATA
        // ==========================

        data_valid = 0;

        @(posedge clk);

        check(DATA, 1, 2'b10, 1);


        // ==========================
        // TEST 3
        // DATA stays DATA
        // ser_done = 0
        // ==========================

        ser_done = 0;

        @(posedge clk);

        check(DATA, 1, 2'b10, 1);


        // ==========================
        // TEST 4
        // DATA → STOP
        // par_en = 0
        // ==========================

        par_en   = 0;
        ser_done = 1;

        @(posedge clk);

        check(STOP, 0, 2'b00, 1);


        // ==========================
        // TEST 5
        // STOP → IDLE
        // ==========================

        ser_done = 0;

        @(posedge clk);

        check(IDLE, 0, 2'b00, 0);


        // ==========================
        // TEST 6
        // PARITY ENABLED
        // ==========================

        data_valid = 1;
        par_en     = 1;

        @(posedge clk);

        check(START, 0, 2'b01, 1);


        @(posedge clk);

        check(DATA, 1, 2'b10, 1);


        // DATA → PARITY
        ser_done = 1;

        @(posedge clk);

        check(PARITY, 0, 2'b11, 1);


        // PARITY → STOP
        ser_done = 0;

        @(posedge clk);

        check(STOP, 0, 2'b00, 1);


        // STOP → IDLE
        @(posedge clk);

        check(IDLE, 0, 2'b00, 0);


        $display("======================");
        $display("TEST FINISHED");
        $display("======================");

        #10;

        $stop;

    end

endmodule