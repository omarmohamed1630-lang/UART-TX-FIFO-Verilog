module sipo #(parameter WIDTH = 20) (

    //inputs
    input wire                     clk,
    input wire                   rst_n,
    input wire                shift_en,
    input wire               serial_in,

    //outputs
    output reg [WIDTH-1:0] parallel_out

);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        parallel_out <= 'b0;
    end

    else if (shift_en) begin
        parallel_out <= {serial_in , parallel_out[WIDTH-1:1]};
    end
end
endmodule 



module  alu (

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


module sipo_alu (

    //inputs
    input clk,
    input rst_n,
    input shift_en,
    input d_in,

    //outputs
    output [7:0] d_out,
    output a_is_zero
    
);

parameter WIDTH = 20 ;

wire [WIDTH-1:0] m; 

sipo a1 (
    .clk(clk),
    .rst_n(rst_n),
    .shift_en(shift_en),
    .serial_in(d_in),
    .parallel_out(m)
);



alu a2(
    .alu_en(m[19]),
    .opcode(m[18:16]),
    .in_a(m[15:8]),
    .in_b(m[7:0]),
    .alu_out(d_out),
    .a_is_zero(a_is_zero)
);

endmodule 