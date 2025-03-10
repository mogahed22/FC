module TX_elements_VC0 #(
    parameter INFO_SIGNALS = 10 ,  // Width of each data word //size of credit
    parameter BYTES=8,
    parameter FIFO_DEPTH = 1024,  // Depth of the FIFO (number of entries) //number of credits
    parameter DW = 4* BYTES,
    parameter DATA_WIDTH = 5*DW,
    parameter BUFFER_TYPE = 3'b000 //PH BUFFER
)(
    input wire clk,rst_n,wr_en,
    input wire [DATA_WIDTH-1:0] data_in,
    input wire [INFO_SIGNALS-1:0] PH_credit_limit,PD_credit_limit,NPH_credit_limit,
    NPD_credit_limit,CH_credit_limit,CD_credit_limit,
    output wire [INFO_SIGNALS-1:0] data_out,
    output reg empty,full
);

wire [INFO_SIGNALS-1:0] ptlp;
wire [2:0] type_of_packet;
wire send_signal;
wire [INFO_SIGNALS-1:0] PH_credit_consumed;
wire [INFO_SIGNALS-1:0] PD_credit_consumed;
wire [INFO_SIGNALS-1:0] NPH_credit_consumed;
wire [INFO_SIGNALS-1:0] NPD_credit_consumed;
wire [INFO_SIGNALS-1:0] CH_credit_consumed;
wire [INFO_SIGNALS-1:0] CD_credit_consumed;
transaction_pending_buffer #(8,16) tpb(
    .data_in(data_in),
    .data_out(data_out),
    .clk(clk),
    .wr_en(wr_en),
    .rst_n(rst_n),
    .PH_credit_consumed(PH_credit_consumed),
    .PD_credit_consumed(PD_credit_consumed),
    .NPH_credit_consumed(PH_credit_consumed),
    .NPD_credit_consumed(PH_credit_consumed),
    .CH_credit_consumed(CH_credit_consumed),
    .CD_credit_consumed(CD_credit_consumed),
    .ptlp(ptlp),
    .send_signal(send_signal),
    .type_of_packet(type_of_packet)
    );


    FC_gating_logic #(8,16) FCgl(
        .PH_credit_consumed(PH_credit_consumed),
        .PD_credit_consumed(PD_credit_consumed),
        .NPH_credit_consumed(PH_credit_consumed),
        .NPD_credit_consumed(PH_credit_consumed),
        .CH_credit_consumed(CH_credit_consumed),
        .CD_credit_consumed(CD_credit_consumed),
        .PH_credit_limit(PH_credit_limit),
        .PD_credit_limit(PD_credit_limit),
        .NPH_credit_limit(NPH_credit_limit),
        .NPD_credit_limit(NPD_credit_limit),
        .CH_credit_limit(CH_credit_limit),
        .CD_credit_limit(CD_credit_limit),
        .clk(clk),
        .ptlp(ptlp),
        .send_signal(send_signal),
        .type_of_packet(type_of_packet)
    );
endmodule