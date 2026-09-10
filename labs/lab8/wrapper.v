module wrapper (
    //inputs
    input clk,
    input rst,
    input level,

    //outputs
    output [6:0] hex
);

wire wire1 ;
wire [3:0] wire2 ;

mealy m0 (
    .clk(clk),
    .rst(rst),
    .level(level),
    .tec(wire1)
);

edge_counter m1 (
    .clk(clk),
    .reset(rst),
    .enable(wire1),
    .count(wire2)
);

bin_hex m2 (
    .bin(wire2),
    .hex(hex)
);

endmodule //wrapper