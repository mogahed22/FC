module RX_element_VC0(
    input wire ph_clk,            // Clock signal
    input wire ph_rst_n,          // Active-low reset
    input wire ph_wr_en,          // Write enable
    input wire ph_rd_en,          // Read enable
    input wire [DATA_WIDTH-1:0] ph_data_in, // Data input
    output reg [DATA_WIDTH-1:0] ph_data_out, // Data output
    output wire ph_full,          // FIFO full flag
    output wire ph_empty,          // FIFO empty flag
    output reg [DATA_WIDTH+2:0]ph_credit_limit

    input wire pd_clk,            // Clock signal
    input wire pd_rst_n,          // Active-low reset
    input wire pd_wr_en,          // Write enable
    input wire pd_rd_en,          // Read enable
    input wire [DATA_WIDTH-1:0] pd_data_in, // Data input
    output reg [DATA_WIDTH-1:0] pd_data_out, // Data output
    output wire pd_full,          // FIFO full flag
    output wire pd_empty,          // FIFO empty flag
    output reg [DATA_WIDTH+2:0] pd_credit_limit

    input wire nph_clk,            // Clock signal
    input wire nph_rst_n,          // Active-low reset
    input wire nph_wr_en,          // Write enable
    input wire nph_rd_en,          // Read enable
    input wire [DATA_WIDTH-1:0] nph_data_in, // Data input
    output reg [DATA_WIDTH-1:0] nph_data_out, // Data output
    output wire nph_full,          // FIFO full flag
    output wire nph_empty,          // FIFO empty flag
    output reg [DATA_WIDTH+2:0] nph_credit_limit

    input wire npd_clk,            // Clock signal
    input wire npd_rst_n,          // Active-low reset
    input wire npd_wr_en,          // Write enable
    input wire npd_rd_en,          // Read enable
    input wire [DATA_WIDTH-1:0] npd_data_in, // Data input
    output reg [DATA_WIDTH-1:0] npd_data_out, // Data output
    output wire npd_full,          // FIFO full flag
    output wire npd_empty,          // FIFO empty flag
    output reg [DATA_WIDTH+2:0] npd_credit_limit

    input wire ch_clk,            // Clock signal
    input wire ch_rst_n,          // Active-low reset
    input wire ch_wr_en,          // Write enable
    input wire ch_rd_en,          // Read enable
    input wire [DATA_WIDTH-1:0] ch_data_in, // Data input
    output reg [DATA_WIDTH-1:0] ch_data_out, // Data output
    output wire ch_full,          // FIFO full flag
    output wire ch_empty,          // FIFO empty flag
    output reg [DATA_WIDTH+2:0] ch_credit_limit

    input wire cd_clk,            // Clock signal
    input wire cd_rst_n,          // Active-low reset
    input wire cd_wr_en,          // Write enable
    input wire cd_rd_en,          // Read enable
    input wire [DATA_WIDTH-1:0] cd_data_in, // Data input
    output reg [DATA_WIDTH-1:0] cd_data_out, // Data output
    output wire cd_full,          // FIFO full flag
    output wire cd_empty,          // FIFO empty flag
    output reg [DATA_WIDTH+2:0] cd_credit_limit
);

PH_receiver_buffer #(8,16,000) posted_header_buffer(ph_clk,ph_rst_n,ph_wr_en,ph_rd_en,ph_data_in,ph_data_out,ph_full,ph_empty,ph_credit_limit);
PH_receiver_buffer #(8,16,001) posted_data_buffer(pd_clk,pd_rst_n,pd_wr_en,pd_rd_en,pd_data_in,pd_data_out,pd_full,pd_empty,pd_credit_limit);
PH_receiver_buffer #(8,16,010) non_posted_header_buffer(nph_clk,nph_rst_n,nph_wr_en,nph_rd_en,nph_data_in,nph_data_out,nph_full,nph_empty,nph_credit_limit);
PH_receiver_buffer #(8,16,011) non_posted_data_buffer(npd_clk,npd_rst_n,npd_wr_en,npd_rd_en,npd_data_in,npd_data_out,npd_full,npd_empty,npd_credit_limit);
PH_receiver_buffer #(8,16,100) completion_header_buffer(ch_clk,ch_rst_n,ch_wr_en,ch_rd_en,ch_data_in,ch_data_out,ch_full,ch_empty,ch_credit_limit);
PH_receiver_buffer #(8,16,101) completion_data_buffer(cd_clk,cd_rst_n,cd_wr_en,cd_rd_en,cd_data_in,cd_data_out,cd_full,cd_empty,cd_credit_limit);


endmodule