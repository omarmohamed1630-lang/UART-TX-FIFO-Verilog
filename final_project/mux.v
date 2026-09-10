module mux (
    
    //inputs 
    input [1:0] sel,
    input start_bit,
    input stop_bit,
    input ser_data,
    input per_bit,

    //outputs
    output reg tx_out
);

always @(*) begin
    case (sel)
        2'b00 : tx_out = stop_bit;

        2'b01 : tx_out = start_bit;

        2'b10 : tx_out = ser_data;

        2'b11 : tx_out = per_bit;

        default : tx_out = stop_bit;
    endcase
end

endmodule //mux