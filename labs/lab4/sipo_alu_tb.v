module sipo_alu_tb ;
    
parameter WIDTH = 20;

reg      clk_t;
reg    rst_n_t;
reg shift_en_t;
reg     d_in_t;

wire [7:0] d_out_t;
wire   a_is_zero_t;


sipo_alu DUT (
    .clk(clk_t),
    .rst_n(rst_n_t),
    .shift_en(shift_en_t),
    .d_in(d_in_t),
    .d_out(d_out_t),
    .a_is_zero(a_is_zero_t)
);

always #10 clk_t =~ clk_t;

integer i;

initial begin
    clk_t = 0;
    d_in_t = $random;
    rst_n_t = 0;
    shift_en_t = 1;
    repeat(2)@(negedge clk_t);

    d_in_t = $random;
    rst_n_t = 1;
    shift_en_t = 0;
    repeat(2)@(negedge clk_t);
    
    rst_n_t = 1;
    shift_en_t = 1;
    for ( i = 0 ; i<1000 ; i = i+1 ) begin
        d_in_t = $random;
        @(negedge clk_t);
        $display("d_in = %b rst_n = %b shift_en = %b d_out = %b" , d_in_t , rst_n_t , shift_en_t , d_out_t);
    end
end
endmodule 