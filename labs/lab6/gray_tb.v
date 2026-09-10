module gray_tb ;

parameter WIDTH = 4;

reg [WIDTH-1:0] gray;

wire [6:0] out;

segment DUT (
    .gray(gray),
    .out(out)
);

initial begin
    $monitor("t = %0t gray = %b out = %b", $time , gray , out);
    repeat(20) begin
      gray = $random;
      #10;
    end
end


endmodule //gray_tb