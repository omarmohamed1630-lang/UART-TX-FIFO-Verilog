module ALU_test #(parameter WIDTH = 8);     

reg  [WIDTH-1:0] in_a;
reg  [WIDTH-1:0] in_b;
reg  [2:0]     oppcode;

wire [WIDTH-1:0] alu_out;
wire           a_is_zero;


ALU ALU_TEST_DUT (
        .in_a(in_a),
        .in_b(in_b),
        .oppcode(oppcode),
        .alu_out(alu_out),
        .a_is_zero(a_is_zero)
    );

initial begin
    $monitor("oppcode=%b in_a=%b in_b=%b a_is_zero=%b alu_out=%b", oppcode, in_a, in_b, a_is_zero, alu_out);

    oppcode=000; in_a=01000010; in_b=10000110;
    #10;
    
    oppcode=001; in_a=01000010; in_b=10000110;
    #10;
    
    oppcode=010; in_a=01000010; in_b=10000110;
    #10;
    
    oppcode=011; in_a=01000010; in_b=10000110;
    #10;
    
    oppcode=100; in_a=01000010; in_b=10000110;
    #10;
    
    oppcode=101; in_a=01000010; in_b=10000110;
    #10;
    
    oppcode=110; in_a=01000010; in_b=10000110;
    #10;
    
    oppcode=111; in_a=01000010; in_b=10000110;
    #10;
    
    oppcode=111; in_a=00000000; in_b=10000110;
    #10;
   
end

endmodule 