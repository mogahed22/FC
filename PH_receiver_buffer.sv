module PH_receiver_buffer#(
    parameter DATA_WIDTH = 8,  // Width of each data word //size of credit
    parameter FIFO_DEPTH = 16  // Depth of the FIFO (number of entries) //number of credits
    parameter BUFFER_TYPE = 3'b000 //PH BUFFER
)(
    input wire clk,            // Clock signal
    input wire rst_n,          // Active-low reset
    input wire wr_en,          // Write enable
    input wire rd_en,          // Read enable
    input wire [DATA_WIDTH-1:0] data_in, // Data input
    output reg [DATA_WIDTH-1:0] data_out, // Data output
    output wire full,          // FIFO full flag
    output wire empty,          // FIFO empty flag
    output reg [DATA_WIDTH+2:0]credit_limit
);

reg [DATA_WIDTH-1:0] mem [FIFO_DEPTH-1:0];
reg [$clog2(FIFO_DEPTH)-1:0]wr_ptr;
reg [$clog2(FIFO_DEPTH)-1:0]rd_ptr;
reg [DATA_WIDTH-1:0] credit_received;
reg [DATA_WIDTH-1:0] credit_alloc = FIFO_DEPTH;
reg error_flag;

assign full = (credit_received==FIFO_DEPTH);
assign empty = (credit_received ==0);

always @(posedge clk or negedge rst_n) begin
  
   if (!rst_n)begin
    credit_received<=0;
    wr_ptr<=0;
    credit_limit<={BUFFER_TYPE,credit_alloc};
   end

   else if (!full && wr_en ) begin
    mem[wr_ptr]<=data_in;
    wr_ptr<=wr_ptr+1;
    credit_received<=credit_received+1;
    credit_alloc <= credit_alloc-1;

    if(credit_received>credit_alloc)begin
        error_flag<=1'b1;
    end

    else begin
        credit_limit<={BUFFER_TYPE,credit_alloc};
    end

   end

end

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)begin
        credit_received<=0;
        rd_ptr<=0;
    end
    else if(!empty && rd_en && credit_alloc < FIFO_DEPTH)begin
        data_out<=mem[rd_ptr];
        rd_ptr<=rd_ptr+1;
        //credit_received<=credit_received-1;
        credit_alloc <= credit_alloc +1;

        if(credit_received>credit_alloc)begin
            error_flag<=1'b1;
        end

        else begin
            credit_limit<={BUFFER_TYPE,credit_alloc};
        end
    end
end
endmodule