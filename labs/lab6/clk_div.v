module clk_div (
    input clk_in,
    input a_rstn,
    output reg clk_out
);

reg [1:0] count;

always @(posedge clk_in or negedge a_rstn) begin

    if (a_rstn) begin
        count   <= 0;
        clk_out <= 0;
    end

    else begin
        if (count == 2) begin
            count   <= 0;
            clk_out <= ~clk_out;
        end
        else begin
            count <= count + 1;
        end
    end

end

endmodule


/*
module clk_50MHz_down_to_8HZ #(
    parameter reduce_to = 8
)(
    input wire clk_50MHz,
    input wire rst_n,
    output reg clk_8HZ
);

localparam integer COUNT_MAX = (50_000_000 / (2 * reduce_to));
localparam integer COUNT_WIDTH = $clog2(COUNT_MAX) + 1;

reg [COUNT_WIDTH-1:0] counter;

always @(posedge clk_50MHz or negedge rst_n) begin

    if (!rst_n) begin
        counter <= 32'b0;
        clk_8HZ <= 1'b0;
    end

    else if (counter == COUNT_MAX) begin
        counter <= 32'b0;
        clk_8HZ <= ~clk_8HZ;
    end

    else begin
        counter <= counter + 1'b1;
    end

end

endmodule


*/