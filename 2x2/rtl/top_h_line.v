module top_h_line (
    //configuration
    input [3:0] configuration,

    //north output signals from macros
    input [9:0] north_o_0, north_o_1,
    input [9:0] north_oe_0, north_oe_1,
    //selected output signal 
    output [9:0] north_o_selected,
    output [9:0] north_oe_selected

    // //north inputs from pads
    // input [9:0] north_i,
    // //buffered inputs to the macros
    // output [9:0] north_i_buf_2, north_i_buf_3, north_i_buf_4
);

reg select; 

//mux selector logic
always@(*)
    case(configuration)
        0: select = 0;
        1: select = 1;
        2: select = 0;
        3: select = 1;
        default: select = 0;
    endcase            

//mux
assign north_o_selected = select? north_o_1: north_o_0;
assign north_oe_selected = select? north_oe_1: north_oe_0;

//outputs to be buffered

//
endmodule