module gray_binary #(parameter WIDTH = 4) (

    //inputs
    input [WIDTH-1:0] gray,

    //outputs
    output [WIDTH-1:0] binary
    
);

assign binary[3] = gray[3];
assign binary[2] = gray[3]    ^ gray[2];
assign binary[1] = binary[2] ^ gray[1];
assign binary[0] = binary[1] ^ gray[0];


endmodule //gray_binary


module decoder (

    //inputs
    input [3:0] in,

    ///outputs
    output reg [6:0] out
);

always @(*) begin
    case (in)
        4'b0000: out = 7'b0000001;
        4'b0001: out = 7'b1001111;
        4'b0010: out = 7'b0010010;
        4'b0011: out = 7'b0000110;
        4'b0100: out = 7'b1001100;
        4'b0101: out = 7'b0100100;
        4'b0110: out = 7'b0100000;
        4'b0111: out = 7'b0001111;
        4'b1000: out = 7'b0000000;
        4'b1001: out = 7'b0000100;
        4'b1010: out = 7'b0001001;
        4'b1011: out = 7'b1100000;
        4'b1100: out = 7'b0110001;
        4'b1101: out = 7'b1000010;
        4'b1110: out = 7'b0110000;
        4'b1111: out = 7'b0111000;
    endcase
end

endmodule


module segment #(parameter WIDTH =4)(

    //inputs
    input [WIDTH-1:0] gray,

    ///outputs
    output  [6:0] out
    
);

wire [WIDTH-1:0] wire1;

gray_binary x0 (
    .gray(gray),
    .binary(wire1)
);

decoder x1 (
    .in(wire1),
    .out(out)
);

endmodule //gray_binary