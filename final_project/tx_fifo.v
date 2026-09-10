module tx_fifo #(parameter WIDTH = 8)(

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

wire fifo_empty;
wire fifo_rd_en;
wire fifo_tx_data_valid;
wire [WIDTH-1:0] fifo_data_out;
wire fifo_full;

fifo x0 (
    .clk(clk),
    .rst_n(rst_n),
    .data_in(p_data),
    .wr_en(data_valid),
    .rd_en(fifo_rd_en),
    .data_out(fifo_data_out),
    .full(fifo_full),
    .empty(fifo_empty)
);

fifo_controller x1 (
    .clk(clk),
    .rst_n(rst_n),
    .busy(busy),
    .empty(fifo_empty),
    .rd_en(fifo_rd_en),
    .tx_data_valid(fifo_tx_data_valid)
);

tx x2 (
    .clk(clk),
    .rst_n(rst_n),
    .par_en(par_en),
    .p_data(fifo_data_out),
    .data_valid(fifo_tx_data_valid),
    .par_type(par_type),
    .tx_out(tx_out),
    .busy(busy)
);

endmodule