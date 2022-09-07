module top_h_line (
    //configuration
    input [3:0] configuration,

    //north output signals from macros
    input [9:0] north_o_0, north_o_1, north_o_2, north_o_3,
    input [9:0] north_oe_0, north_oe_1, north_oe_2, north_oe_3,
    //selected output signal 
    output reg [9:0] north_o_selected,
    output reg [9:0] north_oe_selected,

    // //north inputs from pads
    input [9:0] north_i,
    // //buffered inputs to the macros
    output [9:0] north_i_buf_0, north_i_buf_1, north_i_buf_2, north_i_buf_3
);

//mux logic
always@(*)
    case(configuration)
        0: north_o_selected = north_o_0;
        1: north_o_selected = north_o_1;
        2: north_o_selected = north_o_2;
        3: north_o_selected = north_o_3;
        default: north_o_selected = north_o_0;
    endcase            

always@(*)
    case(configuration)
        0: north_oe_selected = north_oe_0;
        1: north_oe_selected = north_oe_1;
        2: north_oe_selected = north_oe_2;
        3: north_oe_selected = north_oe_3;
        default: north_oe_selected = north_oe_0;
    endcase 

//outputs to be buffered
assign north_i_buf_0 = north_i;
assign north_i_buf_1 = north_i;
assign north_i_buf_2 = north_i;
assign north_i_buf_3 = north_i;
//
endmodule