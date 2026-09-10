module tx #(parameter WIDTH = 8) (

    //inputs
    input clk,
    input rst_n,
    input par_en,
    input [WIDTH-1:0] p_data,
    input data_valid,
    input par_type,

    //outputs
    output tx_out,
    output busy
    
);

wire ser_done;
wire ser_en;
wire [1:0] mux_sel;
wire ser_data;
wire per_bit;

piso m0 (
    .clk(clk),
    .rst_n(rst_n),
    .parallel_in(p_data),
    .en(ser_en),
    .serial_out(ser_data),
    .valid(ser_done)
);

FSM m1 (
    .clk(clk),
    .rst_n(rst_n),
    .data_valid(data_valid),
    .par_en(par_en),
    .ser_done(ser_done),
    .ser_en(ser_en),
    .mux_sel(mux_sel),
    .busy(busy)
);

parity_bit m2 (
    .clk(clk),
    .rst_n(rst_n),
    .p_data(p_data),
    .par_type(par_type),
    .data_valid(data_valid),
    .parity_out(per_bit)
);

mux m3 (
    .sel(mux_sel),
    .start_bit(1'b0),
    .stop_bit(1'b1),
    .ser_data(ser_data),
    .per_bit(per_bit),
    .tx_out(tx_out)
);

endmodule //tx