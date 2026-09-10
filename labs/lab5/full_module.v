module full_module #(parameter WIDTH = 20) (
    //inputs
    input clk,
    input rst_n,
    input wr_en,
    input rd_en,
    input [7:0] addr,
    input [WIDTH-1:0] din,

    //outputs
    output [7:0] d_out,
    output a_is_zero
);

wire wire1;
wire wire2;

ram_piso m0 (
    .clk(clk),
    .rst_n(rst_n),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .addr(addr),
    .din(din),
    .serial_out(wire1),
    .valid(wire2)
);

sipo_alu m1 (
    .clk(clk),
    .rst_n(rst_n),
    .d_in(wire1),
    .shift_en(wire2),
    .d_out(d_out),
    .a_is_zero(a_is_zero)
);

endmodule //full_module