module FC_gating_logic#(
    parameter DATA_WIDTH = 8,  // Width of each data word //size of credit
    parameter FIFO_DEPTH = 16  // Depth of the FIFO (number of entries) //number of credits
)(
    input wire [DATA_WIDTH-1:0] PH_credit_consumed,
    input wire [DATA_WIDTH-1:0] PD_credit_consumed,// consumed
    input wire [DATA_WIDTH-1:0] NPH_credit_consumed,
    input wire [DATA_WIDTH-1:0] NPD_credit_consumed,
    input wire [DATA_WIDTH-1:0] CH_credit_consumed,
    input wire [DATA_WIDTH-1:0] CD_credit_consumed,
    input wire [DATA_WIDTH-1:0] PH_credit_limit,
    input wire [DATA_WIDTH-1:0] PD_credit_limit,
    input wire [DATA_WIDTH-1:0] NPH_credit_limit,
    input wire [DATA_WIDTH-1:0] NPD_credit_limit,
    input wire [DATA_WIDTH-1:0] CH_credit_limit,
    input wire [DATA_WIDTH-1:0] CD_credit_limit,
    input wire [DATA_WIDTH-1:0] ptlp,
    input wire clk,
    input wire [2:0] type_of_packet,
    output reg send_signal
);

reg [DATA_WIDTH-1:0] credit_required;
reg [DATA_WIDTH-1:0] send_condition;
//reg [2:0] type_of_packet;
always @(posedge clk) begin
    case(type_of_packet)
        000:begin
             credit_required <= PH_credit_consumed + ptlp; 
            send_condition <= (PH_credit_limit-credit_required) % 2**6;
        end
        001:begin
             credit_required <= PD_credit_consumed + ptlp; 
            send_condition <= (PD_credit_limit-credit_required) % 2**6;
        end
        010:begin
             credit_required <= NPH_credit_consumed + ptlp; 
            send_condition <= (NPH_credit_limit-credit_required) % 2**6;
        end
        011:begin
             credit_required <= NPD_credit_consumed + ptlp; 
            send_condition <= (NPD_credit_limit-credit_required) % 2**6;
        end
        100:begin
             credit_required <= CH_credit_consumed + ptlp; 
            send_condition <= (CH_credit_limit-credit_required) % 2**6;
        end
        101:begin
             credit_required <= CD_credit_consumed + ptlp; 
            send_condition <= (CD_credit_limit-credit_required) % 2**6;
        end
    endcase 
    
    if(send_condition<= (2**6)/2) begin
        send_signal <= 1'b1;
    end
    else begin
        send_signal<=1'b0;
    end
end

endmodule