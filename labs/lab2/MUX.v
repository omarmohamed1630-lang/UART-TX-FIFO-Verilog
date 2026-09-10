module MUX #(parameter WIDTH = 5) (

    //inputs
    input [WIDTH-1:0] in0,
    input [WIDTH-1:0] in1,
    input             sel,

    //outputs
    output [WIDTH-1:0] mux_out

);


assign mux_out = sel ? in1 : in0 ;


endmodule 