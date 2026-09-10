module piso #(parameter WIDTH = 8) (

    input clk,
    input rst_n,
    input [WIDTH-1:0] parallel_in,
    input en,

    output reg serial_out,
    output reg valid

);

reg [WIDTH-1:0] store;
reg [3:0] count;

always @(posedge clk or negedge rst_n) begin

    if (!rst_n) begin
        store      <= 'b0;
        serial_out <= 1'b0;
        valid      <= 1'b0;
        count      <= 'b0;
    end

    else begin

        valid <= 1'b0;

        if (en && count == 0) begin

            serial_out <= parallel_in[0];
            store      <= {1'b0, parallel_in[WIDTH-1:1]};

            count <= 2'b01;

        end

        else if (en && count < WIDTH) begin

            serial_out <= store[0];
            store      <= {1'b0, store[WIDTH-1:1]};
            count <= count + 1'b1;

            if (count == WIDTH-1) begin
                valid <= 1'b1;
            end

        end

        else if (!en) begin

            count <= 'b0;

        end

    end

end

endmodule