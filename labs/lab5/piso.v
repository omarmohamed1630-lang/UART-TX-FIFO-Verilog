module piso #(parameter WIDTH = 20)  (

    //inputs
    input clk,
    input rst_n,
    input [WIDTH-1:0] parallel_in,
    input en,

    //outputs
    output reg serial_out,
    output reg valid

);

reg [WIDTH-1:0] store; 

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        store <= 'b0;
        serial_out <= 'b0;
        valid <=0;
    end

    else if (en) begin
        store <= parallel_in;
        valid <=0;
    end

    else begin
      store <= {1'b0,store[WIDTH-1:1]};
      serial_out <= store[0];
      valid <= 1'b1;
    end
end
endmodule //piso