module macro #(
    parameter integer number = 0
) (
    output [13:0] IO_east_o,
    output [13:0] IO_east_oe,
    output [13:0] IO_west_o,
    output [13:0] IO_west_oe,
    output [9:0] IO_north_o,
    output [9:0] IO_north_oe 
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
        end
        1: begin
            assign IO_east_o = 14'b00_0000_0000_0010;
            assign IO_west_o = 14'b00_0000_0000_0010;
            assign IO_north_o = 10'b00_0000_0010;
        end
        2: begin
            assign IO_east_o = 14'b00_0000_0000_0100;
            assign IO_west_o = 14'b00_0000_0000_0100;
            assign IO_north_o = 10'b00_0000_0100;
        end
        3: begin
            assign IO_east_o = 14'b00_0000_0000_1000;
            assign IO_west_o = 14'b00_0000_0000_1000;
            assign IO_north_o = 10'b00_0000_1000;
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