module user_project #(
    parameter BITS = 30,
    parameter COUNT_STEP = 1,
    parameter COUNT_ADDR = 0) (
`ifdef USE_POWER_PINS
    inout VPWR,  // User area 1 1.8V supply
    inout VGND,  // User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
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

    // Logic Analyzer Signals
    input  [31:0] la_data_in,
    output [31:0] la_data_out,
    input  [31:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-3:0] io_in,
    output [`MPRJ_IO_PADS-3:0] io_out,
    output [`MPRJ_IO_PADS-3:0] io_oeb,

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

`ifdef PnR
    assign io_out = io_in;
`else
    wire valid = wbs_cyc_i && wbs_stb_i;
    assign io_oeb[37:32] = 6'h3f;

    counter #(.COUNT_STEP(COUNT_STEP),.COUNT_ADDR(COUNT_ADDR)) count(
        .wb_clk_i(wb_clk_i),
        .wb_rst_i(wb_rst_i),
        .la_clk_rst(la_data_in[31:30]),
        .la_clk_rst_oenb(la_oenb[31:30]),
        .valid(valid),
        .wstrb(wbs_sel_i & {4{wbs_we_i}}),
        .wdata(wbs_dat_i),
        .wbs_adr_i(wbs_adr_i),
        .la_write(~la_oenb[29:0] & ~{BITS-2{valid}}),
        .la_input(la_data_in[29:0]),
        .ready(wbs_ack_o),
        .rdata(wbs_dat_o),
        .count(io_out),
        .io_oeb(io_oeb[BITS-1:0])

    );
`endif

endmodule