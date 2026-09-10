module parity_bit (

    input clk,
    input rst,
    input serial_in,

    output reg parity_out
    
);

function parity;
    input [7:0] data;
    begin
      parity = ^data;
    end
endfunction

reg [7:0] shift;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        parity_out <= 1'b0;
        shift <= 'b0;
    end
    else begin
        shift <= {shift[6:0],serial_in};
        parity_out <= parity({shift[6:0],serial_in});
    end
end

endmodule //parity