module FC_gating_logic#(
    parameter DATA_WIDTH = 8,  // Width of each data word //size of credit
    parameter FIFO_DEPTH = 16  // Depth of the FIFO (number of entries) //number of credits
)(
    input reg [DATA_WIDTH-1:0] credit_consumed,
    input reg [DATA_WIDTH-1:0] PH_credit_limit,
    input reg [DATA_WIDTH-1:0] PD_credit_limit,
    input reg [DATA_WIDTH-1:0] NPH_credit_limit,
    input reg [DATA_WIDTH-1:0] NPD_credit_limit,
    input reg [DATA_WIDTH-1:0] CH_credit_limit,
    input reg [DATA_WIDTH-1:0] CD_credit_limit,
    input reg [DATA_WIDTH-1:0] ptlp,
    input reg clk,
    output reg send_signal
);

reg [DATA_WIDTH-1:0] credit_required;
reg [DATA_WIDTH-1:0] send_condition;
always @(posedge clk) begin
    credit_required <= credit_consumed + ptlp;
    send_condition <= (PH_credit_limit-credit_required) % power(2,6);
    if(send_condition<= power(2,6)/2)begin
        send_signal <= 1'b1;
    end
    else begin
        send_signal<=1'b0;
    end
end

endmodule