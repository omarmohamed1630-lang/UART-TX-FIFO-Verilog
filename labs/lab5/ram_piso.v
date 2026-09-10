module ram_piso #(parameter WIDTH=20) (
   //inputs
    input clk,
    input rst_n,
    input wr_en,
    input rd_en,
    input [7:0] addr,
    input [WIDTH-1:0] din,

    //outputs
    output serial_out,
    output valid
);


wire [WIDTH-1:0] w1;
wire w2;
wire w3;

ram c1 (
    .clk(clk),
    .rst_n(rst_n),
    .wr_en(wr_en),
    .addr(addr),
    .din(din),
    .rd_en(rd_en),
    .dout(w1),
    .valid(w3)
);

piso c2 (
    .clk(clk),
    .rst_n(rst_n),
    .parallel_in(w1),
    .en(w3),
    .serial_out(serial_out),
    .valid(valid)
);
endmodule //ram_piso