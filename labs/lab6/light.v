module light #(parameter WIDTH = 10) (

    //inputs
    input clk_in,
    input a_rstn,
    input hold,

    //outputs
    output [WIDTH-1 : 0] out
);

wire wire1 ;

clk_div l0 (
    .clk_in(clk_in),
    .a_rstn(a_rstn),
    .clk_out(wire1)
);


light_couser l1 (
    .clk(wire1),
    .hold(hold),
    .a_rstn(a_rstn),
    .out(out)
);

endmodule //light