module fifo_controller (

    // inputs
    input clk,
    input rst_n,
    input busy,
    input empty,

    // outputs
    output reg rd_en,
    output reg tx_data_valid

);

parameter IDLE = 2'b00;
parameter READ = 2'b01;
parameter WAIT = 2'b10;
parameter SEND = 2'b11;

reg [1:0] cs, ns;


// state register
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cs <= IDLE;
    end

    else begin
        cs <= ns;
    end
end


// next state logic
always @(*) begin
    case (cs)
        IDLE : begin
            if (!empty && !busy) begin
                ns = READ;
            end

            else begin
                ns = IDLE;
            end
        end

        READ : begin
            ns = SEND;
        end

        WAIT : begin
            ns = SEND;
        end

        SEND : begin
            ns = IDLE;
        end

        default : ns = IDLE;

    endcase

end


// output logic
always @(*) begin

    if (cs == IDLE) begin
        rd_en = 1'b0;
        tx_data_valid = 1'b0;
    end

    else if (cs == READ) begin
        rd_en = 1'b1;
        tx_data_valid = 1'b0;
    end

    else if (cs == WAIT) begin
        rd_en = 1'b0;
        tx_data_valid = 1'b0;
    end

    else if (cs == SEND) begin
        rd_en = 1'b0;
        tx_data_valid = 1'b1;
    end

    else begin
        rd_en = 1'b0;
        tx_data_valid = 1'b0;
    end

end

endmodule