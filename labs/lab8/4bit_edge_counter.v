module edge_counter (

//inputs
input clk,
input reset,
input enable,

//outputs
output reg [3:0] count
);

parameter [1:0] S0 = 2'b00;
parameter [1:0] S1 = 2'b01;

reg [1:0] cs, ns;

//state register
always @(posedge clk or posedge reset) begin
    if (reset) begin
        cs <= S0;    
    end else begin
        cs <= ns;
    end
end

//next state logic
always @(*) begin
    if (enable) begin
        case (cs)
            S0: begin
                ns = S1;
            end

            S1: begin
                ns = S1;
            end
        endcase
    end else begin
        ns = cs;
    end
end

//output logic
always@(*)begin
    if(reset)begin
        count = 'b0;
    end 
    else if(cs == S1 && enable)begin
        count = count + 1;
    end
end

endmodule