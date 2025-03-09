module transaction_pending_buffer#(
    parameter DATA_WIDTH = 8,  // Width of each data word //size of credit
    parameter FIFO_DEPTH = 16  // Depth of the FIFO (number of entries) //number of credits
)(
    input wire clk,            // Clock signal
    input wire rst_n,          // Active-low reset
    input wire wr_en,          // Write enable
    input wire send_signal,          // Read enable
    input wire [DATA_WIDTH-1:0] data_in, // Data input
    output reg [DATA_WIDTH-1:0] data_out, // Data output
    output wire full,          // FIFO full flag
    output wire empty,          // FIFO empty flag
    output reg [DATA_WIDTH-1:0] PH_credit_consumed,
    output reg [DATA_WIDTH-1:0] PD_credit_consumed,
    output reg [DATA_WIDTH-1:0] NPH_credit_consumed,
    output reg [DATA_WIDTH-1:0] NPD_credit_consumed,
    output reg [DATA_WIDTH-1:0] CH_credit_consumed,
    output reg [DATA_WIDTH-1:0] CD_credit_consumed,
    output reg [DATA_WIDTH-1:0] ptlp,
    output reg [2:0] type_of_packet
);

reg [DATA_WIDTH-1:0] mem [FIFO_DEPTH-1:0];
reg [$clog2(FIFO_DEPTH)-1:0]wr_ptr;
reg [$clog2(FIFO_DEPTH)-1:0]rd_ptr;

reg [DATA_WIDTH-1:0] ptlp; //Number of transaction packets wating in buffer
reg [DATA_WIDTH-1:0] temp; // temp reg 

assign full = (ptlp==FIFO_DEPTH);
assign empty = (ptlp ==0);

always @(posedge clk or negedge rst_n) begin
   if (!rst_n)begin
    ptlp<=0;
    wr_ptr<=0;
   end 
   else if (!full && wr_en ) begin
    mem[wr_ptr]<=data_in;
    wr_ptr<=wr_ptr+1;
    ptlp<=ptlp+1;
   end
end

always @(posedge clk or negedge rst_n) begin
    temp <= mem[rd_ptr]; 
    type_of_packet <= temp[2:0];
    if (!rst_n)begin
        ptlp<=0;
        rd_ptr<=0;
    end
    else if(!empty && send_signal)begin
        data_out<=mem[rd_ptr];
        rd_ptr<=rd_ptr+1;
        ptlp<=ptlp-1;

        case(temp[2:0])
        000:PH_credit_consumed<=PH_credit_consumed+1; 
        001:PD_credit_consumed<=PD_credit_consumed+1; 
        010:NPH_credit_consumed<=NPH_credit_consumed+1; 
        011:NPD_credit_consumed<=NPH_credit_consumed+1; 
        100:CH_credit_consumed<=CH_credit_consumed+1; 
        101:CD_credit_consumed<=CD_credit_consumed+1; 
    endcase
    end
end

endmodule