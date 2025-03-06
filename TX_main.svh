module TX_elements_VC0();
input wire [DATA_WIDTH-1:0] data_in; // Data input
output reg [DATA_WIDTH-1:0] data_out; // Data output
input reg [DATA_WIDTH-1:0] PH_credit_limit;
logic ptlp,send_signal,credit_consumed;
input reg clk,wr_en,rst_n;
transaction_pending_buffer #(8,16) tpb(
    .data_in(data_in),
    .data_out(data_out),
    .clk(clk),
    .wr_en(wr_en),
    .rst_n(rst_n),
    .credit_consumed(credit_consumed),
    .ptlp(ptlp),
    .send_signal(send_signal)
    );


    FC_gating_logic #(8,16) FCgl(
        .credit_consumed(credit_consumed),
        .PH_credit_limit(PH_credit_limit),
        .clk(clk),
        .ptlp(ptlp),
        .send_signal(send_signal)
    );
endmodule