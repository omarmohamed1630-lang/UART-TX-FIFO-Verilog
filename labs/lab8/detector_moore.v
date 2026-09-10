module detector_moore (
    //inputs
    input clk,
    input rst,
    input level,

    //outputs
    output  tec
);

parameter [1:0] S0 = 2'b00;
parameter [1:0] S1 = 2'b01;
parameter [1:0] S2 = 2'b10;

reg [1:0] cs, ns;


// statte register
always @(posedge clk or posedge rst) begin
    if (rst) begin
        cs <= S0;
    end else begin
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
                ns = S2;
            end else begin
                ns = S0;
            end
        end

        S2: begin
            if (level) begin
                ns = S2;
            end else begin
                ns = S0;
            end
        end
    endcase
end

// output logic
assign tec = (cs == S1);

endmodule