module mpc_tb  ();
//
wire [13:0] IO_east_o, IO_east_oe;
reg [13:0] IO_east_i;
wire [13:0] IO_west_o, IO_west_oe; 
reg [13:0] IO_west_i;
wire [9:0] IO_north_o, IO_north_oe;
reg [9:0] IO_north_i;
reg [3:0] configuration;
//
wire [9:0] north_o_3, north_o_2, north_o_1, north_o_0;
wire [9:0] north_oe_3, north_oe_2, north_oe_1, north_oe_0;
//west outputs on macros
wire [13:0] west_o_3, west_o_2, west_o_1, west_o_0;
wire [13:0] west_oe_3, west_oe_2, west_oe_1, west_oe_0;
//east
wire [13:0] east_o_3, east_o_2, east_o_1, east_o_0;
wire [13:0] east_oe_3, east_oe_2, east_oe_1, east_oe_0;
//
wire [9:0] north_i_3, north_i_2, north_i_1, north_i_0;
//
wire [13:0] west_i_3, west_i_2, west_i_1, west_i_0;
wire [13:0] east_i_3, east_i_2, east_i_1, east_i_0;
//WB
reg wb_clk_i;
reg wb_rst_i;
reg wbs_stb_i;
reg wbs_cyc_i;
reg wbs_we_i;
reg [3:0] wbs_sel_i;
reg [31:0] wbs_dat_i;
reg [31:0] wbs_adr_i;
wire wbs_ack_o;
wire [31:0] wbs_dat_o;
//
wire wb_clk_i_0, wb_clk_i_1, wb_clk_i_2, wb_clk_i_3;
wire wb_rst_i_0, wb_rst_i_1, wb_rst_i_2, wb_rst_i_3;
wire wbs_stb_i_0, wbs_stb_i_1, wbs_stb_i_2, wbs_stb_i_3;
wire wbs_cyc_i_0, wbs_cyc_i_1, wbs_cyc_i_2, wbs_cyc_i_3;
wire wbs_we_i_0, wbs_we_i_1, wbs_we_i_2, wbs_we_i_3;
wire [3:0] wbs_sel_i_0, wbs_sel_i_1, wbs_sel_i_2, wbs_sel_i_3;
wire [31:0] wbs_dat_i_0, wbs_dat_i_1, wbs_dat_i_2, wbs_dat_i_3;
wire [31:0] wbs_adr_i_0, wbs_adr_i_1, wbs_adr_i_2, wbs_adr_i_3;
//
wire wbs_ack_o_0, wbs_ack_o_1, wbs_ack_o_2, wbs_ack_o_3;
wire [31:0] wbs_dat_o_0, wbs_dat_o_1, wbs_dat_o_2, wbs_dat_o_3;

//macros
macro #(0) macro_0 (
    //WB
    .wb_clk_i(wb_clk_i_0), .wb_rst_i(wb_rst_i_0), .wbs_stb_i(wbs_stb_i_0), .wbs_cyc_i(wbs_cyc_i_0), .wbs_we_i(wbs_we_i_0), .wbs_sel_i(wbs_sel_i_0), .wbs_dat_i(wbs_dat_i_0), .wbs_adr_i(wbs_adr_i_0), .wbs_ack_o(wbs_ack_o_0), .wbs_dat_o(wbs_dat_o_0),
    //IOs
    .IO_north_i(north_i_0), .IO_east_i(east_i_0), .IO_west_i(west_i_0), .IO_east_o(east_o_0), .IO_east_oe(east_oe_0), .IO_west_o(west_o_0), .IO_west_oe(west_oe_0), .IO_north_o(north_o_0), .IO_north_oe(north_oe_0)
    );
macro #(1) macro_1 (
    //WB
    .wb_clk_i(wb_clk_i_1), .wb_rst_i(wb_rst_i_1), .wbs_stb_i(wbs_stb_i_1), .wbs_cyc_i(wbs_cyc_i_1), .wbs_we_i(wbs_we_i_1), .wbs_sel_i(wbs_sel_i_1), .wbs_dat_i(wbs_dat_i_1), .wbs_adr_i(wbs_adr_i_1), .wbs_ack_o(wbs_ack_o_1), .wbs_dat_o(wbs_dat_o_1),
    //IOs
    .IO_north_i(north_i_1), .IO_east_i(east_i_1), .IO_west_i(west_i_1), .IO_east_o(east_o_1), .IO_east_oe(east_oe_1), .IO_west_o(west_o_1), .IO_west_oe(west_oe_1), .IO_north_o(north_o_1), .IO_north_oe(north_oe_1)
    );
macro #(2) macro_2 (
    //WB
    .wb_clk_i(wb_clk_i_2), .wb_rst_i(wb_rst_i_2), .wbs_stb_i(wbs_stb_i_2), .wbs_cyc_i(wbs_cyc_i_2), .wbs_we_i(wbs_we_i_2), .wbs_sel_i(wbs_sel_i_2), .wbs_dat_i(wbs_dat_i_2), .wbs_adr_i(wbs_adr_i_2), .wbs_ack_o(wbs_ack_o_2), .wbs_dat_o(wbs_dat_o_2),
    //IOs
    .IO_north_i(north_i_2), .IO_east_i(east_i_2), .IO_west_i(west_i_2), .IO_east_o(east_o_2), .IO_east_oe(east_oe_2), .IO_west_o(west_o_2), .IO_west_oe(west_oe_2), .IO_north_o(north_o_2), .IO_north_oe(north_oe_2)
    );
macro #(3) macro_3 (
    //WB
    .wb_clk_i(wb_clk_i_3), .wb_rst_i(wb_rst_i_3), .wbs_stb_i(wbs_stb_i_3), .wbs_cyc_i(wbs_cyc_i_3), .wbs_we_i(wbs_we_i_3), .wbs_sel_i(wbs_sel_i_3), .wbs_dat_i(wbs_dat_i_3), .wbs_adr_i(wbs_adr_i_3), .wbs_ack_o(wbs_ack_o_3), .wbs_dat_o(wbs_dat_o_3),
    //IOs
    .IO_north_i(north_i_3), .IO_east_i(east_i_3), .IO_west_i(west_i_3), .IO_east_o(east_o_3), .IO_east_oe(east_oe_3), .IO_west_o(west_o_3), .IO_west_oe(west_oe_3), .IO_north_o(north_o_3), .IO_north_oe(north_oe_3)
    );
//
mpc dut
(
    //inputs
    .configuration,
    .north_o_3, .north_o_2, .north_o_1, .north_o_0,
    .north_oe_3, .north_oe_2, .north_oe_1, .north_oe_0,
    .west_o_3, .west_o_2, .west_o_1, .west_o_0,
    .west_oe_3, .west_oe_2, .west_oe_1, .west_oe_0,
    .east_o_3, .east_o_2, .east_o_1, .east_o_0,
    .east_oe_3, .east_oe_2, .east_oe_1, .east_oe_0,
    //outputs
    .IO_east_o,
    .IO_east_oe,
    .IO_west_o,
    .IO_west_oe,
    .IO_north_o,
    .IO_north_oe,
    //
    .IO_north_i,
    .IO_east_i,
    .IO_west_i,
    .north_i_3, .north_i_2, .north_i_1, .north_i_0,
    .west_i_3, .west_i_2, .west_i_1, .west_i_0,
    .east_i_3, .east_i_2, .east_i_1, .east_i_0,
    //WB
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
    .wb_clk_i_0, .wb_clk_i_1, .wb_clk_i_2, .wb_clk_i_3,
    .wb_rst_i_0, .wb_rst_i_1, .wb_rst_i_2, .wb_rst_i_3,
    .wbs_stb_i_0, .wbs_stb_i_1, .wbs_stb_i_2, .wbs_stb_i_3,
    .wbs_cyc_i_0, .wbs_cyc_i_1, .wbs_cyc_i_2, .wbs_cyc_i_3,
    .wbs_we_i_0, .wbs_we_i_1, .wbs_we_i_2, .wbs_we_i_3,
    .wbs_sel_i_0, .wbs_sel_i_1, .wbs_sel_i_2, .wbs_sel_i_3,
    .wbs_dat_i_0, .wbs_dat_i_1, .wbs_dat_i_2, .wbs_dat_i_3,
    .wbs_adr_i_0, .wbs_adr_i_1, .wbs_adr_i_2, .wbs_adr_i_3,
    //
    .wbs_ack_o_0, .wbs_ack_o_1, .wbs_ack_o_2, .wbs_ack_o_3,
    .wbs_dat_o_0, .wbs_dat_o_1, .wbs_dat_o_2, .wbs_dat_o_3
);
//
initial begin
    configuration = 0;
    forever begin
        #10 configuration = configuration + 1;
    end      
end
initial begin
    wb_clk_i = 0;
    forever begin
        #5 wb_clk_i = ~wb_clk_i;
    end      
end
initial begin
    wb_rst_i = 1;
    #5 wb_rst_i = 0;
end
//
initial begin
    IO_north_i = 10'd25;
    IO_east_i = 10'd30;
    IO_west_i = 10'd35;
    wbs_stb_i = 0;
    wbs_cyc_i = 0;
    wbs_we_i = 1;
    wbs_sel_i = 4'd10;
    wbs_dat_i = 32'd20;
    wbs_adr_i = 32'd30;
end
endmodule