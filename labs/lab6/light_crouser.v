module light_couser #(parameter WIDTH = 10) (

    //INPUTS
    input    hold,
    input    clk,
    input a_rstn,
    //outputs
    output reg [WIDTH-1 : 0] out
    
);


always @(posedge clk or negedge a_rstn) begin
    if (!a_rstn) begin
        out <= 10'b1000000000;
    end

    else if (hold) begin
        out <= out;
    end

    else 
        out <= {1'b0,out[WIDTH-1:1]};

end
endmodule