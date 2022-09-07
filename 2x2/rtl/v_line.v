module v_line #(parameter integer position = 0)
(
    //configuration
    input [3:0] configuration,

    //north outputs on macros
    input [9:0] north_o_0,
    input [9:0] north_oe_0, 
    //west outputs on macros
    input [13:0] west_o_0, west_o_1, west_o_2,
    input [13:0] west_oe_0, west_oe_1, west_oe_2,
    //east
    input [13:0] east_o_0, east_o_1, east_o_2,
    input [13:0] east_oe_0, east_oe_1, east_oe_2,

    //selected output signals 
    output [9:0] north_o_buf,
    output [9:0] north_oe_buf,
    output reg [13:0] west_o_selected,
    output reg [13:0] west_oe_selected,
    output reg [13:0] east_o_selected,
    output reg [13:0] east_oe_selected,

    //inputs to buffer
    input [9:0] north_i,
    input [13:0] east_i,
    input [13:0] west_i,
    //buffered inputs to the macros
    output [9:0] north_i_buf,
    output [13:0] east_i_buf_0, east_i_buf_1, east_i_buf_2,
    output [13:0] west_i_buf_0, west_i_buf_1, west_i_buf_2,

    //WB
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    //
    output wb_clk_i_buf,
    output wb_rst_i_buf,
    output wbs_stb_i_buf,
    output wbs_cyc_i_buf,
    output wbs_we_i_buf,
    output [3:0] wbs_sel_i_buf,
    output [31:0] wbs_dat_i_buf,
    output [31:0] wbs_adr_i_buf,
    //
    input wbs_ack_o,
    input [31:0] wbs_dat_o,
    //
    output wbs_ack_o_buf,
    output [31:0] wbs_dat_o_buf
);
//
reg [1 : 0] select; 
//mux select logic. The logic changes with the position of the vertical line
generate
    case(position)
    0:
        always@(*)
            case(configuration)
                0: select = 0;
                1: select = 2;
                2: select = 1;
                3: select = 2;
                default: select = 0;
            endcase
    1:
        always@(*)
            case(configuration)
                0: select = 0;
                1: select = 0;
                2: select = 1;
                3: select = 1;
                default: select = 0;
            endcase 
    2: 
        always@(*)
            case(configuration)
                0: select = 2;
                1: select = 0;
                2: select = 2;
                3: select = 1;
                default: select = 0;
            endcase
    endcase
endgenerate

//muxes
always @(*) begin
    case(select)
        0: west_o_selected = west_o_0;
        1: west_o_selected = west_o_1;
        2: west_o_selected = west_o_2;
        default: west_o_selected = west_o_0;
    endcase
end
always @(*) begin
    case(select)
        0: west_oe_selected = west_oe_0;
        1: west_oe_selected = west_oe_1;
        2: west_oe_selected = west_oe_2;
        default: west_oe_selected = west_oe_0;
    endcase
end
always @(*) begin
    case(select)
        0: east_o_selected = east_o_0;
        1: east_o_selected = east_o_1;
        2: east_o_selected = east_o_2;
        default: east_o_selected = east_o_0;
    endcase
end
always @(*) begin
    case(select)
        0: east_oe_selected = east_oe_0;
        1: east_oe_selected = east_oe_1;
        2: east_oe_selected = east_oe_2;
        default: east_oe_selected = east_oe_0;
    endcase
end
//
assign north_o_buf = north_o_0;
assign north_oe_buf = north_oe_0;
//
assign north_i_buf = north_i;
//
assign east_i_buf_0 = east_i;
assign east_i_buf_1 = east_i;
assign east_i_buf_2 = east_i;
//
assign west_i_buf_0 = west_i;
assign west_i_buf_1 = west_i;
assign west_i_buf_2 = west_i;
//WB forwawrding
assign wb_clk_i_buf = wb_clk_i;
assign wb_rst_i_buf = wb_rst_i;
assign wbs_stb_i_buf = wbs_stb_i;
assign wbs_cyc_i_buf = wbs_cyc_i;
assign wbs_we_i_buf = wbs_we_i;
assign wbs_sel_i_buf = wbs_sel_i;
assign wbs_dat_i_buf = wbs_dat_i;
assign wbs_adr_i_buf = wbs_adr_i;
//
assign wbs_ack_o_buf = wbs_ack_o;
assign wbs_dat_o_buf = wbs_dat_o;
//
endmodule