module bot_h_line(
    input [3:0] configuration,
    //
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output reg wbs_ack_o,
    output reg [31:0] wbs_dat_o,
    //
    output wb_clk_i_0, wb_clk_i_1, wb_clk_i_2, wb_clk_i_3,
    output wb_rst_i_0, wb_rst_i_1, wb_rst_i_2, wb_rst_i_3,
    output wbs_stb_i_0, wbs_stb_i_1, wbs_stb_i_2, wbs_stb_i_3,
    output wbs_cyc_i_0, wbs_cyc_i_1, wbs_cyc_i_2, wbs_cyc_i_3,
    output wbs_we_i_0, wbs_we_i_1, wbs_we_i_2, wbs_we_i_3,
    output [3:0] wbs_sel_i_0, wbs_sel_i_1, wbs_sel_i_2, wbs_sel_i_3,
    output [31:0] wbs_dat_i_0, wbs_dat_i_1, wbs_dat_i_2, wbs_dat_i_3,
    output [31:0] wbs_adr_i_0, wbs_adr_i_1, wbs_adr_i_2, wbs_adr_i_3,
    //
    input wbs_ack_o_0, wbs_ack_o_1, wbs_ack_o_2, wbs_ack_o_3,
    input [31:0] wbs_dat_o_0, wbs_dat_o_1, wbs_dat_o_2, wbs_dat_o_3
);
//Output selection
always @(*) begin
    case(configuration)
        0: wbs_dat_o = wbs_dat_o_1;
        1: wbs_dat_o = wbs_dat_o_3;
        2: wbs_dat_o = wbs_dat_o_0;
        3: wbs_dat_o = wbs_dat_o_2;
        default: wbs_dat_o = wbs_dat_o_1;
    endcase
end
always @(*) begin
    case(configuration)
        0: wbs_ack_o = wbs_ack_o_1;
        1: wbs_ack_o = wbs_ack_o_3;
        2: wbs_ack_o = wbs_ack_o_0;
        3: wbs_ack_o = wbs_ack_o_2;
        default: wbs_ack_o = wbs_ack_o_1;
    endcase
end
//input forwarding
//
assign wb_clk_i_0 = wb_clk_i;
assign wb_clk_i_1 = wb_clk_i;
assign wb_clk_i_2 = wb_clk_i;
assign wb_clk_i_3 = wb_clk_i;
//
assign wb_rst_i_0 = wb_rst_i;
assign wb_rst_i_1 = wb_rst_i;
assign wb_rst_i_2 = wb_rst_i;
assign wb_rst_i_3 = wb_rst_i;
//
assign wbs_stb_i_0 = wbs_stb_i;
assign wbs_stb_i_1 = wbs_stb_i;
assign wbs_stb_i_2 = wbs_stb_i;
assign wbs_stb_i_3 = wbs_stb_i;
//
assign wbs_cyc_i_0 = wbs_cyc_i;
assign wbs_cyc_i_1 = wbs_cyc_i;
assign wbs_cyc_i_2 = wbs_cyc_i;
assign wbs_cyc_i_3 = wbs_cyc_i;
//
assign wbs_we_i_0 = wbs_we_i;
assign wbs_we_i_1 = wbs_we_i;
assign wbs_we_i_2 = wbs_we_i;
assign wbs_we_i_3 = wbs_we_i;
//
assign wbs_sel_i_0 = wbs_sel_i;
assign wbs_sel_i_1 = wbs_sel_i;
assign wbs_sel_i_2 = wbs_sel_i;
assign wbs_sel_i_3 = wbs_sel_i;
//
assign wbs_dat_i_0 = wbs_dat_i;
assign wbs_dat_i_1 = wbs_dat_i;
assign wbs_dat_i_2 = wbs_dat_i;
assign wbs_dat_i_3 = wbs_dat_i;
//
assign wbs_adr_i_0 = wbs_adr_i;
assign wbs_adr_i_1 = wbs_adr_i;
assign wbs_adr_i_2 = wbs_adr_i;
assign wbs_adr_i_3 = wbs_adr_i;
//
endmodule