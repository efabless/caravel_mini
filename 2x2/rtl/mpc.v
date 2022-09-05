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
    output [9:0] IO_north_oe 
    ////////// INPUTS FROM THE IO PADS ///////////
    // input [9:0] north_i
);
// Wires between macros of the mpc
wire [13:0] west_o_4, west_oe_4, east_o_4, east_oe_4;
wire [9:0] north_o_4, north_oe_4, north_o_5, north_oe_5;

//
wire [9:0] north_i_buf_2, north_i_buf_3, north_i_buf_4;

//No connection nets
wire [13:0] NC_1, NC_2, NC_5, NC_6;
wire [9:0] NC_3, NC_4;


//vertical selectors
vertical_selector #(.position(0)) v_selector_0 (
    //inputs
    .configuration, 

    .north_o_0(north_o_0), .north_o_1(north_o_2),
    .north_oe_0(north_oe_0), .north_oe_1(north_oe_2),

    .west_o_0(west_o_0), .west_o_1(west_o_2), .west_o_2(west_o_4),
    .west_oe_0(west_oe_0), .west_oe_1(west_oe_2), .west_oe_2(west_o_4),

    .east_o_0(14'd0), .east_o_1(14'd0), .east_o_2(14'd0),
    .east_oe_0(14'd0), .east_oe_1(14'd0), .east_oe_2(14'd0),

    //outputs
    //North
    .north_o_selected(north_o_4),
    .north_oe_selected(north_oe_4),
    //West
    .west_o_selected(IO_west_o),
    .west_oe_selected(IO_west_oe),
    //East
    .east_o_selected(NC_1),
    .east_oe_selected(NC_2)

    );
vertical_selector #(.position(1)) v_selector_1 (
    //inputs
    .configuration, 

    .north_o_0(north_o_1), .north_o_1(north_o_3),
    .north_oe_0(north_oe_1), .north_oe_1(north_oe_3),

    .west_o_0(west_o_1), .west_o_1(west_o_3), .west_o_2(14'd0),
    .west_oe_0(west_oe_1), .west_oe_1(west_oe_3), .west_oe_2(14'd0),

    .east_o_0(east_o_0), .east_o_1(east_o_2), .east_o_2(14'd0),
    .east_oe_0(east_oe_0), .east_oe_1(east_oe_2), .east_oe_2(14'd0),

    //outputs
    //North
    .north_o_selected(north_o_5),
    .north_oe_selected(north_oe_5),
    //West
    .west_o_selected(west_o_4),
    .west_oe_selected(west_oe_4),
    //East
    .east_o_selected(east_o_4),
    .east_oe_selected(east_oe_4)

    );

vertical_selector #(.position(2)) v_selector_2 (
    //inputs
    .configuration, 

    .north_o_0(10'd0), .north_o_1(10'd0),
    .north_oe_0(10'd0), .north_oe_1(10'd0),

    .west_o_0(14'd0), .west_o_1(14'd0), .west_o_2(14'd0),
    .west_oe_0(14'd0), .west_oe_1(14'd0), .west_oe_2(14'd0),

    .east_o_0(east_o_1), .east_o_1(east_o_3), .east_o_2(east_o_4),
    .east_oe_0(east_oe_1), .east_oe_1(east_oe_3), .east_oe_2(east_oe_4),

    //outputs
    //North
    .north_o_selected(NC_3),
    .north_oe_selected(NC_4),
    //West
    .west_o_selected(NC_5),
    .west_oe_selected(NC_6),
    //East
    .east_o_selected(IO_east_o),
    .east_oe_selected(IO_east_oe)

    );

//upper selector
top_h_line u_selector
(
    .configuration,
    //north output signals from macros
    .north_o_0(north_o_4), .north_o_1(north_o_5),
    .north_oe_0(north_oe_4), .north_oe_1(north_oe_5),
    //selected output signal 
    .north_o_selected(IO_north_o),
    .north_oe_selected(IO_north_oe)
    //inputs from pads
    // .north_i,
    // //buffered inputs
    // .north_i_buf_2, .north_i_buf_3, .north_i_buf_4
);
endmodule