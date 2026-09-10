module FULL_ADDER ( 

    //INPUTS
    input  wire A ,
    input  wire B , 
    input  wire C_IN, 
    //OUTPUTS
    output wire S , 
    output wire C_OUT

);

assign S = A ^ B ^ C_IN;
assign C_OUT = ( A & B ) | ( A & C_IN ) | ( B & C_OUT );


endmodule 