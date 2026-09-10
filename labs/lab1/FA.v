module FULL_ADDER ( 

    //INPUTS
    input  wire A ,
    input  wire B , 
    input  wire C_IN, 
    //OUTPUTS
    output wire S , 
    output wire C_OUT

);

wire W0 , W1 , W2;


xor ( S , A , B , C_IN );
and (W0, A , B);
and (W1, A , C_IN);
and (W2, B , C_IN);
or (C_OUT , W0 , W1 , W2)


endmodule


