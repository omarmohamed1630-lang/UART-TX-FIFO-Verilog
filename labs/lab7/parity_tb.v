module parity_tb ;

reg clk;
reg rst;
reg serial_in;

wire parity_out;

parity_bit DUT (
    .clk(clk),
    .rst(rst),
    .serial_in(serial_in),
    .parity_out(parity_out)
);

always #5 clk =~ clk;

initial begin
    
    clk=0;
    rst=1;
    serial_in=1;
    @(negedge clk);

    rst=0;
    @(negedge clk);

    all();

    @(negedge clk);

    $finish;

end

task all ;
    reg expected;
    integer i;
    integer j;

    begin
        for (i = 0; i < 255; i = i + 1) begin

            for (j = 0; j < 7; j = j + 1) begin
                //@(negedge clk);
                serial_in = i[j];
                @(negedge clk);
            end

            @(negedge clk);

            expected = ^i;

            if (parity_out == expected)
                $display("PASS | t= %0t | Data = %08b | Expected = %b | Actual = %b", $time, i, expected, parity_out);
            else
                $display("FAIL | t= %0t | Data = %08b | Expected = %b | Actual = %b", $time, i, expected, parity_out);
        end
    end
endtask
endmodule //parity_tb
