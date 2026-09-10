module me_o_s (
    
    //inputs
    input in,
    input rstn,
    input clk,

    //outputs
    output reg out
);

parameter [2:0] S0 = 3'b000;
parameter [2:0] S1 = 3'b001;     
parameter [2:0] S2 = 3'b010;
parameter [2:0] S3 = 3'b011;
parameter [2:0] S4 = 3'b100;
parameter [2:0] S5 = 3'b101;

reg [2:0] cs , ns;

//state register
always @(posedge clk or negedge rstn) begin
    if (!rstn) begin
        cs <= S0;
    end
    else begin
        cs <= ns;
    end
        
end

//next state logic
always @(*) begin
    case (cs)
        S0 : begin
            if (in) begin
                ns = S1;
            end
            else begin
                ns = S0;
            end
        end

        S1 : begin
            if (in) begin
                ns = S2;
            end
            else begin
                ns = S1;
            end
        end

        S2 : begin
            if (!in) begin
                ns = S3;
            end
            else begin
                ns = S2;
            end
        end

        S3 : begin
            if (in) begin
                ns = S4;
            end
            else begin
                ns = S3;
            end
        end

        S4 : begin
            if (!in) begin
                ns = S5;
            end
            else begin
                ns = S4;
            end
        end

        S5 : begin
            if (in) begin
                ns = S2;
            end
            else begin
                ns = S0;
            end
        end
    endcase
end

//output logic
assign out = (cs == S5 && in);

endmodule //me_o_s