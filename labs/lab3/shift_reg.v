module SHIFT_REG #(parameter WIDTH = 3) (

    //INPUTS
    input    in1,
    input    clk,
    input a_rstn,
    //outputs
    output reg [WIDTH-1 : 0] out1
    
);


always @(posedge clk or negedge a_rstn) begin
    if (a_rstn) begin
        out1 <= 'b0;
    end

    else 
        out1 <= {out1[WIDTH-1:0],in1};

end

endmodule 

module decoder38(

    input      [2:0]  in2,

    output reg [7:0] out2
);


always @(*) begin
    case (in2)
        3'b000 : out2 = 8'b11111110; 
        3'b001 : out2 = 8'b11111101;
        3'b010 : out2 = 8'b11111011;
        3'b011 : out2 = 8'b11110111;
        3'b100 : out2 = 8'b11101111;
        3'b101 : out2 = 8'b11011111;
        3'b110 : out2 = 8'b10111111;
        3'b111 : out2 = 8'b01111111;
    endcase
end

endmodule 


module sipo_reg (
    
    //inputs
    input   d_in,
    input    clk,
    input a_rstn,

    //outputs
    output [7:0] d_out

);

wire [2:0] x;

SHIFT_REG r1 (
    .in1(d_in),
    .clk(clk),
    .a_rstn(a_rstn),
    .out1(x)

);


decoder38 r2 (
    .in2(x),
    .out2(d_out)

);



endmodule 