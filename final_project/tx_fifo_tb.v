module tx_fifo_tb ;

parameter WIDTH = 8;

reg clk;
reg rst_n;
reg par_en;
reg [WIDTH-1:0] p_data;
reg data_valid;
reg par_type;

wire tx_out;
wire busy;

tx_fifo DUT (
    .clk(clk),
    .rst_n(rst_n),
    .par_en(par_en),
    .p_data(p_data),
    .data_valid(data_valid),
    .par_type(par_type),
    .tx_out(tx_out),
    .busy(busy)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    
    // Initial values
    $display("================================");
    $display("Starting Testbench");
    $display("================================");
    rst_n = 0;
    par_en = 0;
    p_data = 8'b00000000;
    data_valid = 0;
    par_type = 0;

    @(negedge clk);

    // Release Reset
    rst_n = 1;
    @(negedge clk);

    //drive inputs
    $display("================================");
    $display("ٌReults when parity is disabled and par_type = 0");
    par_type = 1'b0;
    par_en = 1'b0;
    data();
    @(negedge clk);

    $display("================================");
    $display("ٌReults when parity is enabled and par_type = 0");
    par_type = 1'b0;
    par_en = 1'b1;
    data();
    @(negedge clk);

    $display("================================");
    $display("ٌReults when parity is disabled and par_type = 1");
    par_type = 1'b1;
    par_en = 1'b0;
    data();
    @(negedge clk);

    $display("================================");
    $display("ٌReults when parity is enabled and par_type = 1");
    par_type = 1'b1;
    par_en = 1'b1;
    data();
    @(negedge clk);
    $display("================================");
    $display("Testbench completed");
    $display("================================");
    $stop;

end

task data ;
    integer i;

    begin
        for (i = 0; i < 256; i = i + 1) begin
            data_valid = 1'b1;
            p_data = i;
            @(negedge clk);

            data_valid = 1'b0;
            //@(negedge clk);
            wait (busy == 1'b1);
            @(negedge clk);
            check(i, par_type, par_en);
            wait (busy == 1'b0);
            @(negedge clk);

        end
    end
endtask

task check;
    input [WIDTH-1:0] expected_data;
    input expected_par_type;
    input expected_par_en;
    reg expected_parity;

    integer i;

    begin

        //clac expected parity bit
        if (expected_par_type == 1'b0)begin
            expected_parity = ^expected_data;
        end 
        else begin
            expected_parity = ~^expected_data; 
        end

        //check start bit
        //@(negedge clk);
        if (tx_out == 1'b0) begin
            $display("PASS | START TEST | Start Bit = 0");
        end
        else begin
            $display("FAIL | START TEST | Start Bit = 0");
        end
        @(negedge clk);


        //check data
        for (i = 0; i < WIDTH; i = i + 1) begin

            
            if (tx_out == expected_data[i]) begin
                $display("PASS | DATA TEST | Bit %0d | Expected DATA = %b | Actual DATA = %b", i, expected_data[i], tx_out);
            end 
            else begin
                $display("FAIL | DATA TEST | Bit %0d | Expected DATA = %b | Actual DATA = %b", i, expected_data[i], tx_out);
            end
            @(negedge clk);
            

        end

        
        //check parity bit
        if(expected_par_en == 1'b1) begin

            
            if (tx_out == expected_parity) begin
                $display("PASS | PARITY TEST | Expected Parity = %b | Actual Parity = %b", expected_parity, tx_out);
            end 
            else begin
                $display("FAIL | PARIT TEST | Expected Parity = %b | Actual Parity = %b", expected_parity, tx_out);
            end
            @(negedge clk);

        end
        
        //check stop bit
        //@(negedge clk);
        if (tx_out == 1'b1) begin
            $display("PASS | STOP TEST | Stop Bit = 1");
        end
        else begin
            $display("FAIL | STOP TEST | Stop Bit = 1");
        end

    end
endtask
endmodule //tx_tb