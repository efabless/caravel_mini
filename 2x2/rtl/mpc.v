module mpc #(
    parameter integer nh = 2, //2 or 3
    parameter integer nv = 2
) (
    input [3:0] configuration, //
    ////////// OUTPUTS FROM CHIP MACROS ///////////  (inputs to the mpc)
    //There are 4 chips: _0, _1, _2, _3
    //
    input [9:0] north_o_3, north_o_2, north_o_1, north_o_0,
    input [9:0] north_oe_3, north_oe_2, north_oe_1, north_oe_0,
    //
    input [13:0] west_o_3, west_o_2, west_o_1, west_o_0,
    input [13:0] west_oe_3, west_oe_2, west_oe_1, west_oe_0,
    //
    input [13:0] east_o_3, east_o_2, east_o_1, east_o_0,
    input [13:0] east_oe_3, east_oe_2, east_oe_1, east_oe_0,
    
    ////////// OUTPUTS TO THE IO PADS ///////////
    output [13:0] IO_east_o,
    output [13:0] IO_east_oe,
    output [13:0] IO_west_o,
    output [13:0] IO_west_oe,
    output [9:0] IO_north_o,
    output [9:0] IO_north_oe,

    ////////// INPUTS FROM THE IO PADS ///////////
    input [9:0] IO_north_i,
    input [13:0] IO_east_i,
    input [13:0] IO_west_i,
    //buffered inputs to user macros
    output [9:0] north_i_3, north_i_2, north_i_1, north_i_0,
    output [13:0] west_i_3, west_i_2, west_i_1, west_i_0,
    output [13:0] east_i_3, east_i_2, east_i_1, east_i_0,

    ////////// WB ///////////
    //
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,
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

// Wires between macros of the mpc
wire [13:0] west_o_4, west_oe_4, east_o_4, east_oe_4;
//
wire [9:0] north_o_0_buf, north_oe_0_buf, north_o_1_buf, north_oe_1_buf;
wire [9:0] north_i_buf_1_vline, north_i_buf_0_vline;
//
wire [13:0] west_i_buf_0_vline;
wire [13:0] east_i_buf_0_vline;
//
wire wb_clk_i_vline_0, wb_clk_i_vline_1;
wire wb_rst_i_vline_0, wb_rst_i_vline_1;
wire wbs_stb_i_vline_0, wbs_stb_i_vline_1;
wire wbs_cyc_i_vline_0, wbs_cyc_i_vline_1;
wire wbs_we_i_vline_0, wbs_we_i_vline_1;
wire [3:0] wbs_sel_i_vline_0, wbs_sel_i_vline_1;
wire [31:0] wbs_dat_i_vline_0, wbs_dat_i_vline_1;
wire [31:0] wbs_adr_i_vline_0, wbs_adr_i_vline_1;
//
wire wbs_ack_o_vline_0, wbs_ack_o_vline_1;
wire [31:0] wbs_dat_o_vline_0, wbs_dat_o_vline_1;
//No connection nets
wire [13:0] NC_1, NC_2, NC_5, NC_6, NC_8, NC_9, NC_10, NC_11, NC_12, NC_13, NC_14, NC_15;
wire [9:0] NC_3, NC_4, NC_7;
wire NC_16, NC_17, NC_18, NC_19, NC_20, NC_24;
wire [3:0] NC_21; 
wire [31:0] NC_22, NC_23, NC_25;


//vertical selectors
v_line #(.position(0)) v_selector_0 (
    //inputs
    .configuration, 

    .north_o_0(north_o_0), 
    .north_oe_0(north_oe_0), 

    .west_o_0(west_o_0), .west_o_1(west_o_2), .west_o_2(west_o_4),
    .west_oe_0(west_oe_0), .west_oe_1(west_oe_2), .west_oe_2(west_oe_4),

    .east_o_0(14'd0), .east_o_1(14'd0), .east_o_2(14'd0),
    .east_oe_0(14'd0), .east_oe_1(14'd0), .east_oe_2(14'd0),

    //outputs
    //North
    .north_o_buf(north_o_0_buf),
    .north_oe_buf(north_oe_0_buf),
    //West
    .west_o_selected(IO_west_o),
    .west_oe_selected(IO_west_oe),
    //East
    .east_o_selected(NC_1),
    .east_oe_selected(NC_2),
    
    //inputs
    .north_i(10'd0),
    .north_i_buf(NC_7),
    //
    .west_i(IO_west_i),
    .west_i_buf_0(west_i_0),
    .west_i_buf_1(west_i_2),
    .west_i_buf_2(west_i_buf_0_vline),
    //
    .east_i(14'd0),
    .east_i_buf_0(NC_8),
    .east_i_buf_1(NC_9),
    .east_i_buf_2(NC_10),
    //WB
    .wb_clk_i(1'b0),
    .wb_rst_i(1'b0),
    .wbs_stb_i(1'b0),
    .wbs_cyc_i(1'b0),
    .wbs_we_i(1'b0),
    .wbs_sel_i(4'd0),
    .wbs_dat_i(32'd0),
    .wbs_adr_i(32'd0),
    //
    .wb_clk_i_buf(NC_16),
    .wb_rst_i_buf(NC_17),
    .wbs_stb_i_buf(NC_18),
    .wbs_cyc_i_buf(NC_19),
    .wbs_we_i_buf(NC_20),
    .wbs_sel_i_buf(NC_21),
    .wbs_dat_i_buf(NC_22),
    .wbs_adr_i_buf(NC_23),
    //
    .wbs_ack_o(wbs_ack_o_2),
    .wbs_dat_o(wbs_dat_o_2),
    //
    .wbs_ack_o_buf(wbs_ack_o_vline_0),
    .wbs_dat_o_buf(wbs_dat_o_vline_0)
    );
v_line #(.position(1)) v_selector_1 (
    //inputs
    .configuration, 

    .north_o_0(north_o_1), 
    .north_oe_0(north_oe_1), 

    .west_o_0(west_o_1), .west_o_1(west_o_3), .west_o_2(14'd0),
    .west_oe_0(west_oe_1), .west_oe_1(west_oe_3), .west_oe_2(14'd0),

    .east_o_0(east_o_0), .east_o_1(east_o_2), .east_o_2(14'd0),
    .east_oe_0(east_oe_0), .east_oe_1(east_oe_2), .east_oe_2(14'd0),

    //outputs
    //North
    .north_o_buf(north_o_1_buf),
    .north_oe_buf(north_oe_1_buf),
    //West
    .west_o_selected(west_o_4),
    .west_oe_selected(west_oe_4),
    //East
    .east_o_selected(east_o_4),
    .east_oe_selected(east_oe_4),
    //inputs
    .north_i(north_i_buf_0_vline),
    .north_i_buf(north_i_0),
    //
    .west_i(west_i_buf_0_vline),
    .west_i_buf_0(west_i_1),
    .west_i_buf_1(west_i_3),
    .west_i_buf_2(NC_14),
    //
    .east_i(east_i_buf_0_vline),
    .east_i_buf_0(east_i_0),
    .east_i_buf_1(east_i_2),
    .east_i_buf_2(NC_15),
    //WB
    .wb_clk_i(wb_clk_i_vline_0),
    .wb_rst_i(wb_rst_i_vline_0),
    .wbs_stb_i(wbs_stb_i_vline_0),
    .wbs_cyc_i(wbs_cyc_i_vline_0),
    .wbs_we_i(wbs_we_i_vline_0),
    .wbs_sel_i(wbs_sel_i_vline_0),
    .wbs_dat_i(wbs_dat_i_vline_0),
    .wbs_adr_i(wbs_adr_i_vline_0),
    //
    .wb_clk_i_buf(wb_clk_i_2),
    .wb_rst_i_buf(wb_rst_i_2),
    .wbs_stb_i_buf(wbs_stb_i_2),
    .wbs_cyc_i_buf(wbs_cyc_i_2),
    .wbs_we_i_buf(wbs_we_i_2),
    .wbs_sel_i_buf(wbs_sel_i_2),
    .wbs_dat_i_buf(wbs_dat_i_2),
    .wbs_adr_i_buf(wbs_adr_i_2),
    //
    .wbs_ack_o(wbs_ack_o_3),
    .wbs_dat_o(wbs_dat_o_3),
    //
    .wbs_ack_o_buf(wbs_ack_o_vline_1),
    .wbs_dat_o_buf(wbs_dat_o_vline_1)
    );

v_line #(.position(2)) v_selector_2 (
    //inputs
    .configuration, 

    .north_o_0(10'd0), 
    .north_oe_0(10'd0), 

    .west_o_0(14'd0), .west_o_1(14'd0), .west_o_2(14'd0),
    .west_oe_0(14'd0), .west_oe_1(14'd0), .west_oe_2(14'd0),

    .east_o_0(east_o_1), .east_o_1(east_o_3), .east_o_2(east_o_4),
    .east_oe_0(east_oe_1), .east_oe_1(east_oe_3), .east_oe_2(east_oe_4),

    //outputs
    //North
    .north_o_buf(NC_3),
    .north_oe_buf(NC_4),
    //West
    .west_o_selected(NC_5),
    .west_oe_selected(NC_6),
    //East
    .east_o_selected(IO_east_o),
    .east_oe_selected(IO_east_oe),
    //inputs
    .north_i(north_i_buf_1_vline),
    .north_i_buf(north_i_1),
    //
    .east_i(IO_east_i),
    .east_i_buf_0(east_i_1),
    .east_i_buf_1(east_i_3),
    .east_i_buf_2(east_i_buf_0_vline),
    //
    .west_i(14'd0),
    .west_i_buf_0(NC_11),
    .west_i_buf_1(NC_12),
    .west_i_buf_2(NC_13),
    //WB
    .wb_clk_i(wb_clk_i_vline_1),
    .wb_rst_i(wb_rst_i_vline_1),
    .wbs_stb_i(wbs_stb_i_vline_1),
    .wbs_cyc_i(wbs_cyc_i_vline_1),
    .wbs_we_i(wbs_we_i_vline_1),
    .wbs_sel_i(wbs_sel_i_vline_1),
    .wbs_dat_i(wbs_dat_i_vline_1),
    .wbs_adr_i(wbs_adr_i_vline_1),
    //
    .wb_clk_i_buf(wb_clk_i_3),
    .wb_rst_i_buf(wb_rst_i_3),
    .wbs_stb_i_buf(wbs_stb_i_3),
    .wbs_cyc_i_buf(wbs_cyc_i_3),
    .wbs_we_i_buf(wbs_we_i_3),
    .wbs_sel_i_buf(wbs_sel_i_3),
    .wbs_dat_i_buf(wbs_dat_i_3),
    .wbs_adr_i_buf(wbs_adr_i_3),
    //
    .wbs_ack_o(1'b0),
    .wbs_dat_o(32'd0),
    //
    .wbs_ack_o_buf(NC_24),
    .wbs_dat_o_buf(NC_25)
    );

//upper horizontal line
top_h_line u_selector
(
    .configuration,
    //north output signals from macros
    .north_o_0(north_o_0_buf), .north_o_1(north_o_1_buf), .north_o_2, .north_o_3,
    .north_oe_0(north_oe_0_buf), .north_oe_1(north_oe_1_buf), .north_oe_2, .north_oe_3,
    //selected output signal 
    .north_o_selected(IO_north_o),
    .north_oe_selected(IO_north_oe),
    //inputs from pads
    .north_i(IO_north_i),
    //buffered inputs
    .north_i_buf_0(north_i_buf_0_vline), .north_i_buf_1(north_i_buf_1_vline), .north_i_buf_2(north_i_2), .north_i_buf_3(north_i_3)
);
//bottom horizontal line
bot_h_line b_selector 
(
    .configuration,
    //
    .wb_clk_i,
    .wb_rst_i,
    .wbs_stb_i,
    .wbs_cyc_i,
    .wbs_we_i,
    .wbs_sel_i,
    .wbs_dat_i,
    .wbs_adr_i,
    .wbs_ack_o,
    .wbs_dat_o,
    //
    .wb_clk_i_0,    .wb_clk_i_1(wb_clk_i_vline_0),  .wb_clk_i_2(wb_clk_i_1),        .wb_clk_i_3(wb_clk_i_vline_1),
    .wb_rst_i_0,    .wb_rst_i_1(wb_rst_i_vline_0),  .wb_rst_i_2(wb_rst_i_1),        .wb_rst_i_3(wb_rst_i_vline_1),
    .wbs_stb_i_0,   .wbs_stb_i_1(wbs_stb_i_vline_0), .wbs_stb_i_2(wbs_stb_i_1),     .wbs_stb_i_3(wbs_stb_i_vline_1),
    .wbs_cyc_i_0,   .wbs_cyc_i_1(wbs_cyc_i_vline_0), .wbs_cyc_i_2(wbs_cyc_i_1),     .wbs_cyc_i_3(wbs_cyc_i_vline_1),
    .wbs_we_i_0,    .wbs_we_i_1(wbs_we_i_vline_0),   .wbs_we_i_2(wbs_we_i_1),       .wbs_we_i_3(wbs_we_i_vline_1),
    .wbs_sel_i_0,   .wbs_sel_i_1(wbs_sel_i_vline_0), .wbs_sel_i_2(wbs_sel_i_1),     .wbs_sel_i_3(wbs_sel_i_vline_1),
    .wbs_dat_i_0,   .wbs_dat_i_1(wbs_dat_i_vline_0), .wbs_dat_i_2(wbs_dat_i_1),     .wbs_dat_i_3(wbs_dat_i_vline_1),
    .wbs_adr_i_0,   .wbs_adr_i_1(wbs_adr_i_vline_0), .wbs_adr_i_2(wbs_adr_i_1),     .wbs_adr_i_3(wbs_adr_i_vline_1),
    //
    .wbs_ack_o_0(wbs_ack_o_vline_0), .wbs_ack_o_1(wbs_ack_o_0), .wbs_ack_o_2(wbs_ack_o_vline_1), .wbs_ack_o_3(wbs_ack_o_1),
    .wbs_dat_o_0(wbs_dat_o_vline_0), .wbs_dat_o_1(wbs_dat_o_0), .wbs_dat_o_2(wbs_dat_o_vline_1), .wbs_dat_o_3(wbs_dat_o_1)
);
//
endmodule