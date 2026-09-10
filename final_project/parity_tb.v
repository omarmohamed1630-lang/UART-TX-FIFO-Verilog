`timescale 1ns/1ps

module parity_tb;

    parameter WIDTH = 8;

    reg clk;
    reg rst_n;
    reg serial_in;
    reg par_type;
    reg data_valid;

    wire parity_out;


    // DUT
    parity_bit #(WIDTH) DUT (
        .clk(clk),
        .rst_n(rst_n),
        .serial_in(serial_in),
        .par_type(par_type),
        .parity_out(parity_out),
        .data_valid(data_valid)

    );


    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end


    // Task to send 8 bits
    task send_data;
        input [WIDTH-1:0] data;
        integer i;

        begin
            for (i = WIDTH-1; i >= 0; i = i - 1) begin
                serial_in = data[i];
                @(posedge clk);
            end
        end
    endtask


    initial begin

        // Initial values
        rst_n = 0;
        serial_in = 0;
        par_type = 0;
        data_valid = 0;

        #10;

        // Release Reset
        rst_n = 1;
        data_valid = 1;


        // =========================
        // TEST 1: EVEN PARITY
        // =========================

        par_type = 0;

        send_data(8'b10110001);

        #1;

        if (parity_out == 1'b0)
            $display("TEST EVEN PARITY: PASS");
        else
            $display("TEST EVEN PARITY: FAIL");


        // =========================
        // RESET
        // =========================

        rst_n = 0;
        #10;
        rst_n = 1;


        // =========================
        // TEST 2: ODD PARITY
        // =========================

        par_type = 1;

        send_data(8'b10110001);

        #1;

        if (parity_out == 1'b1)
            $display("TEST ODD PARITY: PASS");
        else
            $display("TEST ODD PARITY: FAIL");


        #10;

        $finish;

    end


endmodule