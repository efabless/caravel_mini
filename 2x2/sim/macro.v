module macro #(
    parameter integer number = 0
) (
    //IOs
    input [9:0] IO_north_i,
    input [13:0] IO_east_i,
    input [13:0] IO_west_i,
    output [13:0] IO_east_o,
    output [13:0] IO_east_oe,
    output [13:0] IO_west_o,
    output [13:0] IO_west_oe,
    output [9:0] IO_north_o,
    output [9:0] IO_north_oe,
    //WB
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o
);
//
assign IO_east_oe = 14'b11_1111_1111_1111;
assign IO_west_oe = 14'b11_1111_1111_1111;
assign IO_north_oe = 10'b11_1111_1111;
//
generate
    case (number)
        0: begin
            assign IO_east_o = 14'b00_0000_0000_0001;
            assign IO_west_o = 14'b00_0000_0000_0001;
            assign IO_north_o = 10'b00_0000_0001;
            assign wbs_ack_o = 1;
            assign wbs_dat_o = 32'd1;
        end
        1: begin
            assign IO_east_o = 14'b00_0000_0000_0010;
            assign IO_west_o = 14'b00_0000_0000_0010;
            assign IO_north_o = 10'b00_0000_0010;
            assign wbs_ack_o = 1;
            assign wbs_dat_o = 32'd2;
        end
        2: begin
            assign IO_east_o = 14'b00_0000_0000_0100;
            assign IO_west_o = 14'b00_0000_0000_0100;
            assign IO_north_o = 10'b00_0000_0100;
            assign wbs_ack_o = 1;
            assign wbs_dat_o = 32'd4;
        end
        3: begin
            assign IO_east_o = 14'b00_0000_0000_1000;
            assign IO_west_o = 14'b00_0000_0000_1000;
            assign IO_north_o = 10'b00_0000_1000;
            assign wbs_ack_o = 1;
            assign wbs_dat_o = 32'd8;
        end
        4: begin
            assign IO_east_o = 14'b00_0000_0001_0000;
            assign IO_west_o = 14'b00_0000_0001_0000;
            assign IO_north_o = 10'b00_0001_0000;
        end
        5: begin
            assign IO_east_o = 14'b00_0000_0010_0000;
            assign IO_west_o = 14'b00_0000_0010_0000;
            assign IO_north_o = 10'b00_0010_0000;
        end
        6: begin
            assign IO_east_o = 14'b00_0000_0100_0000;
            assign IO_west_o = 14'b00_0000_0100_0000;
            assign IO_north_o = 10'b00_0100_0000;
        end
        7: begin
            assign IO_east_o = 14'b00_0000_1000_0000;
            assign IO_west_o = 14'b00_0000_1000_0000;
            assign IO_north_o = 10'b00_1000_0000;
        end
        8: begin
            assign IO_east_o = 14'b00_0001_0000_0000;
            assign IO_west_o = 14'b00_0001_0000_0000;
            assign IO_north_o = 10'b01_0000_0000;
        end
    endcase
endgenerate
//
endmodule