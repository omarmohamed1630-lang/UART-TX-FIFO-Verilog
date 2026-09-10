module ram #(parameter WIDTH=20 , DEPTH=256) (

    //inputs
    input clk,
    input rst_n,
    input wr_en,
    input [7:0] addr,
    input [WIDTH-1:0] din,
    input rd_en,

    //outputs
    output reg [WIDTH-1:0] dout,
    output reg valid

);

reg [WIDTH-1:0] ram [0:DEPTH-1];
integer i;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        valid <= 1'b0;
        for (i =0 ;i<DEPTH ;i=i+1 ) begin
            ram[i] <= 'b0;
        end
    end
    else if (wr_en) begin
        ram[addr] <= din;
        valid <= 1'b0;
    end
    else if(rd_en) begin
        dout <= ram[addr];
        valid <= 1'b1;
    end
    else begin
      valid <= 1'b0;
    end
end
endmodule //ram