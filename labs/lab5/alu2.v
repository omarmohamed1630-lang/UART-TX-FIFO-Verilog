module  alu2 (

    //inputs
    input wire       alu_en,
    input wire [2:0] opcode,
    input wire [7:0]   in_a,
    input wire [7:0]   in_b,

    //outputs
    output reg [7:0] alu_out,
    output wire    a_is_zero
    
);

assign a_is_zero = in_a ? 1'b0 : 1'b1 ;

always @(*) begin
    if (!alu_en) begin
        alu_out = 'b0;
    end

    else
    case (opcode)
        3'b000 : alu_out = in_a + in_b;
        3'b001 : alu_out = in_a - in_b;
        3'b010 : alu_out = in_a & in_b;
        3'b011 : alu_out = in_a ^ in_b;
        3'b100 : alu_out = in_a | in_b;
        3'b101 : alu_out = in_a;
        3'b110 : alu_out = 'b0;
        3'b111 : alu_out = 'b0;
    endcase
end
endmodule 