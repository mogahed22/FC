module top #(
    parameter DATA_WIDTH = 8,  // Width of each data word //size of credit
    parameter FIFO_DEPTH = 16  // Depth of the FIFO (number of entries) //number of credits
)(
    input wire [DATA_WIDTH-1:0] data_in,
    output wire [DATA_WIDTH-1:0] ph_data_out,pd_data_out,nph_data_out,npd_data_out,ch_data_out,cd_data_out,
    output wire ph_full,ph_empty,pd_full,pd_empty,nph_full,nph_empty,npd_full,npd_empty,ch_full,ch_empty,cd_full,cd_empty,tx_full,tx_empty,
    input wire clk,wr_en,rst_n
);

wire [DATA_WIDTH-1:0] data_from_tx_to_rx;
wire [DATA_WIDTH-1:0] ph_credit_limit,pd_credit_limit,nph_credit_limit,npd_credit_limit,ch_credit_limit,cd_credit_limit;
    
TX_elements_VC0 tx(
    .clk(clk),.rst_n(rst_n),.wr_en(wr_en),.data_in(data_in),
    .PH_credit_limit(ph_credit_limit),.PD_credit_limit(pd_credit_limit),
    .NPH_credit_limit(nph_credit_limit),.NPD_credit_limit(npd_credit_limit),
    .CH_credit_limit(ch_credit_limit),.CD_credit_limit(cd_credit_limit),
    .full(tx_full),.empty(tx_empty),
    .data_out(data_from_tx_to_rx)
); 

RX_element_VC0 rx(
    .clk(clk),.data_in(data_from_tx_to_rx),
    .ph_data_out(ph_data_out),.ph_full(ph_full),.ph_empty(ph_empty),.ph_credit_limit(ph_credit_limit),
    .pd_data_out(pd_data_out),.pd_full(pd_full),.pd_empty(pd_empty),.pd_credit_limit(pd_credit_limit),
    .npd_data_out(npd_data_out),.npd_full(npd_full),.npd_empty(npd_empty),.npd_credit_limit(npd_credit_limit),
    .nph_data_out(nph_data_out),.nph_full(nph_full),.nph_empty(nph_empty),.nph_credit_limit(nph_credit_limit),
    .ch_data_out(ch_data_out),.ch_full(ch_full),.ch_empty(ch_empty),.ch_credit_limit(ch_credit_limit),
    .cd_data_out(cd_data_out),.cd_full(cd_full),.cd_empty(cd_empty),.cd_credit_limit(cd_credit_limit)
);
endmodule