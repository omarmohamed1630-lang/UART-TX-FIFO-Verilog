module FSM (

    //inputs
    input clk,
    input data_valid,
    input ser_done,
    input par_en,
    input rst_n,

    //outputs
    output reg ser_en,
    output reg [1:0] mux_sel,
    output reg busy
    
);

parameter  IDLE   = 3'b000;
parameter  START  = 3'b001;
parameter  DATA   = 3'b010;
parameter  PARITY = 3'b011;
parameter  STOP   = 3'b100;
 
reg [2:0] cs , ns;
//state register
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      cs <= IDLE;
    end

    else begin
      cs <= ns;
    end
end


//next state logic
always @(*) begin
    case (cs)
        IDLE : if (data_valid) begin
                    ns = START;
               end
        
                else begin
                    ns = IDLE;
                end

        START : ns = DATA;

        DATA  : if (ser_done) begin
                    if (par_en) begin
                        ns = PARITY;
                    end

                    else begin
                        ns = STOP;
                    end  
                end 

                else begin
                    ns = DATA;
                end 


        PARITY : ns = STOP;

        STOP : ns = IDLE; 

        default : ns = IDLE;
            
    endcase
end


//output logic
always @(*) begin
    if (cs == IDLE) begin
        busy = 1'b0;
        mux_sel = 'b00;
        ser_en = 1'b0;
    end

    
    else if (cs == START) begin
        mux_sel = 2'b01;
        busy = 1'b1;
        ser_en = 1'b1;
    end

    else if (cs == DATA) begin
        ser_en = 1'b1;
        mux_sel = 2'b10;
        busy = 1'b1;
    end

    else if (cs == PARITY) begin
        mux_sel = 2'b11;
        busy = 1'b1;
        ser_en = 1'b0;
    end

    else begin
        busy = 1'b1;
        ser_en = 1'b0;
        mux_sel = 2'b00;
    end
end

endmodule //fsm