module mealy (
    //inputs
    input clk,
    input rst,
    input level,

    //outputs
    output reg tec
);

parameter [1:0] S0 = 2'b00;
parameter [1:0] S1 = 2'b01;

reg [1:0] cs, ns;

// state register
always @(posedge clk or posedge rst) begin
    if (rst) begin
        cs <= S0;
    end 
    else begin
        cs <= ns;
    end
end

// next state logic
always @(*) begin
    case (cs)
        S0: begin
            if (level) begin
                ns = S1;
            end else begin
                ns = S0;
            end
        end

        S1: begin
            if (level) begin
                ns = S1;
            end else begin
                ns = S0;
            end
        end
    endcase
end

assign tec = (cs == S0 && level);

endmodule //mealy