module mpc_tb  ();
//
wire [13:0] IO_east_o;
wire [13:0] IO_east_oe;
wire [13:0] IO_west_o;
wire [13:0] IO_west_oe;
wire [9:0] IO_north_o;
wire [9:0] IO_north_oe; 
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

//macros
macro #(0) macro_0 (.IO_east_o(east_o_0), .IO_east_oe(east_oe_0), .IO_west_o(west_o_0), .IO_west_oe(west_oe_0), .IO_north_o(north_o_0), .IO_north_oe(north_oe_0));
macro #(1) macro_1 (.IO_east_o(east_o_1), .IO_east_oe(east_oe_1), .IO_west_o(west_o_1), .IO_west_oe(west_oe_1), .IO_north_o(north_o_1), .IO_north_oe(north_oe_1));
macro #(2) macro_2 (.IO_east_o(east_o_2), .IO_east_oe(east_oe_2), .IO_west_o(west_o_2), .IO_west_oe(west_oe_2), .IO_north_o(north_o_2), .IO_north_oe(north_oe_2));
macro #(3) macro_3 (.IO_east_o(east_o_3), .IO_east_oe(east_oe_3), .IO_west_o(west_o_3), .IO_west_oe(west_oe_3), .IO_north_o(north_o_3), .IO_north_oe(north_oe_3));
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
    .IO_north_oe
);
//
initial begin
    configuration = 0;
    forever begin
        #10 configuration = configuration + 1;
    end      
end
//
endmodule