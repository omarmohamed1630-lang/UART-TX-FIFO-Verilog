module fifo #(parameter DATA_WIDTH = 8, parameter DEPTH = 10)(

    //inputs
    input clk,
    input rst_n,

    input [DATA_WIDTH-1:0] data_in,
    input wr_en,
    input rd_en,

    //outputs
    output reg [DATA_WIDTH-1:0] data_out,
    output full,
    output empty
);

reg [DATA_WIDTH-1:0] fifo [0:DEPTH-1];

reg [3:0] wr_ptr;
reg [3:0] rd_ptr;
reg [3:0] count;

assign full  = (count == DEPTH);
assign empty = (count == 0);

always @(posedge clk or negedge rst_n) begin

    if (!rst_n) begin
        wr_ptr   <= 0;
        rd_ptr   <= 0;
        count    <= 0;
        data_out <= 0;
    end

    else begin

        if (wr_en && !full) begin
            fifo[wr_ptr] <= data_in;
            if (wr_ptr == DEPTH-1)
                wr_ptr <= 4'b0;
            else
                wr_ptr <= wr_ptr + 1'b1;
        end

        if (rd_en && !empty) begin
            data_out <= fifo[rd_ptr];
            if (rd_ptr == DEPTH-1)
                rd_ptr <= 4'b0;
            else
                rd_ptr <= rd_ptr + 1'b1;
        end

        case ({wr_en && !full, rd_en && !empty})
            2'b10: count <= count + 1'b1;
            2'b01: count <= count - 1'b1;
            default: count <= count;
        endcase

    end
end

endmodule


