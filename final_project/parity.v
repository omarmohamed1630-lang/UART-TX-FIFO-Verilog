module parity_bit #(parameter WIDTH = 8) (

    input clk,
    input rst_n,
    input [WIDTH-1:0] p_data,
    input par_type,
    input data_valid,

    output reg parity_out
    
);

function parity;
    input [WIDTH-1:0] data;
    begin
      parity = ^data;
    end
endfunction


always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        parity_out <= 1'b0;
    end
    else if (data_valid == 1'b1) begin

        if (par_type == 0) begin
            parity_out <= parity(p_data);    
        end
        
        else begin
            parity_out <= ~parity(p_data);    
        end
    end
end

endmodule //parity