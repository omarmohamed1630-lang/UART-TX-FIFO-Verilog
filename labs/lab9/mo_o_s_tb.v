module mo_o_s_tb ;

reg clk;
reg rstn;
reg in;

wire out;

mo_o_s DUT (
    .clk(clk),
    .rstn(rstn),
    .in(in),
    .out(out)
);

initial begin
    clk = 0;
    forever begin
        #5 clk =~ clk;
    end
end

initial begin
    $monitor("T = %0t  IN = %b  OUT = %b", $time , in , out);

    rstn=0;
    in=0;
    @(negedge clk);

    rstn=1;
    in=0;
    @(negedge clk);

  
    in=1;
    @(negedge clk);

   
    in=1;
    @(negedge clk);

    
    in=0;
    @(negedge clk);

   
    in=1;
    @(negedge clk);

   
    in=0;
    @(negedge clk);

  
    in=1;
    @(negedge clk);

    in=1;
    @(negedge clk);

    in=0;
    @(negedge clk);

    in=1;
    @(negedge clk);

    in=0;
    @(negedge clk);

    in=1;
    @(negedge clk);


end

endmodule //mo_n_s_tb