// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`define MPRJ_IO_PADS_1 19	/* number of user GPIO pads on user1 side */
`define MPRJ_IO_PADS_2 19	/* number of user GPIO pads on user2 side */
`define MPRJ_IO_PADS (`MPRJ_IO_PADS_1 + `MPRJ_IO_PADS_2)

module user_project_wrapper #(
    parameter BITS = 32,
    parameter integer CFG_ADDRESS = 32'h300FFFFC,  // last address in address space
    parameter integer USER_PROJECTS = 4,
    parameter integer CFG_BITS = $ceil($clog2(USER_PROJECTS))
) (
`ifdef USE_POWER_PINS
    inout vdda1,  // User area 1 3.3V supply
    inout vdda2,  // User area 2 3.3V supply
    inout vssa1,  // User area 1 analog ground
    inout vssa2,  // User area 2 analog ground
    inout vccd1,  // User area 1 1.8V supply
    inout vccd2,  // User area 2 1.8v supply
    inout vssd1,  // User area 1 digital ground
    inout vssd2,  // User area 2 digital ground
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
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

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
  wire  [     CFG_BITS-1:0] configuration;


  // Wishbone Slave outputs from user projects
  wire                     proj_wbs_ack_o  [USER_PROJECTS-1:0];
  wire [             31:0] proj_wbs_dat_o  [USER_PROJECTS-1:0];

  // Logic Analyzer Signals outputs from user projects
  wire [             31:0] proj_la_data_out[USER_PROJECTS-1:0];

  // IOs outputs from user projects
  wire [`MPRJ_IO_PADS-CFG_BITS-1:0] proj_io_out     [USER_PROJECTS-1:0];
  wire [`MPRJ_IO_PADS-CFG_BITS-1:0] proj_io_oeb     [USER_PROJECTS-1:0];

  // ANALOG IOs

  // User maskable interrupt signals
  wire [              2:0] proj_user_irq   [USER_PROJECTS-1:0];

  // Configuration update
  assign configuration = io_in[`MPRJ_IO_PADS-1:`MPRJ_IO_PADS-CFG_BITS];

  // User projects
  genvar i;
  generate
    for (i = 0; i < USER_PROJECTS; i = i + 1) begin : user_projects
      if (i % 2 == 0)
        user_project_wrapper_mini4 #(
            `ifndef PnR 
            .COUNT_STEP(2 * i + 1)
            `endif 
        ) user_project_wrapper_mini4 (
`ifdef USE_POWER_PINS
            .VPWR(vccd2), // User area 1 1.8V supply
            .VGND(vssd2), // User area 1 digital ground
`endif
            // Wishbone Slave ports (WB MI A)
            .wb_clk_i   (wb_clk_i && (configuration == i)),
            .wb_rst_i   (wb_rst_i),
            .wbs_stb_i  (wbs_stb_i),
            .wbs_cyc_i  (wbs_cyc_i),
            .wbs_we_i   (wbs_we_i),
            .wbs_sel_i  (wbs_sel_i),
            .wbs_dat_i  (wbs_dat_i),
            .wbs_adr_i  (wbs_adr_i),
            .wbs_ack_o  (proj_wbs_ack_o[i]),
            .wbs_dat_o  (proj_wbs_dat_o[i]),

            // // Logic Analyzer Signals
            .la_data_in (la_data_in[31:0]),
            .la_data_out(proj_la_data_out[i]),
            .la_oenb    (la_oenb[31:0]),

            // IOs
            .io_in (io_in[`MPRJ_IO_PADS-CFG_BITS-1:0]),
            .io_out(proj_io_out[i]),
            .io_oeb(proj_io_oeb[i]),

            // Analog (direct connection to GPIO pad---use with caution)
            // Note that analog I/O is not available on the 7 lowest-numbered
            // GPIO pads, and so the analog_io indexing is offset from the
            // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
            // analog_io,

            // Independent clock (on independent integer divider)
            .user_clock2(user_clock2),

            // User maskable interrupt signals
            .user_irq(proj_user_irq[i])
        );
      else
        user_project_wrapper_mini4 #(
            `ifndef PnR 
            .COUNT_STEP(2 * i + 1)
            `endif 
        ) user_project_wrapper_mini4 (
`ifdef USE_POWER_PINS
            .VPWR(vccd1), // User area 1 1.8V supply
            .VGND(vssd1), // User area 1 digital ground
`endif
            // Wishbone Slave ports (WB MI A)
            .wb_clk_i   (wb_clk_i && (configuration == i)),
            .wb_rst_i   (wb_rst_i),
            .wbs_stb_i  (wbs_stb_i),
            .wbs_cyc_i  (wbs_cyc_i),
            .wbs_we_i   (wbs_we_i),
            .wbs_sel_i  (wbs_sel_i),
            .wbs_dat_i  (wbs_dat_i),
            .wbs_adr_i  (wbs_adr_i),
            .wbs_ack_o  (proj_wbs_ack_o[i]),
            .wbs_dat_o  (proj_wbs_dat_o[i]),

            // // Logic Analyzer Signals
            .la_data_in (la_data_in[31:0]),
            .la_data_out(proj_la_data_out[i]),
            .la_oenb    (la_oenb[31:0]),

            // IOs
            .io_in (io_in[`MPRJ_IO_PADS-CFG_BITS-1:0]),
            .io_out(proj_io_out[i]),
            .io_oeb(proj_io_oeb[i]),

            // Analog (direct connection to GPIO pad---use with caution)
            // Note that analog I/O is not available on the 7 lowest-numbered
            // GPIO pads, and so the analog_io indexing is offset from the
            // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
            // analog_io,

            // Independent clock (on independent integer divider)
            .user_clock2(user_clock2),

            // User maskable interrupt signals
            .user_irq(proj_user_irq[i])
        );
    end
  endgenerate

  // WB outputs selection
  assign wbs_ack_o   = proj_wbs_ack_o[configuration];
  assign wbs_dat_o   = proj_wbs_dat_o[configuration];

  // Logic Analyzer Outputs selection
  assign la_data_out = {96'd0, proj_la_data_out[configuration]};

  // IOs selection
  assign io_out      = proj_io_out[configuration];
  assign io_oeb      = proj_io_oeb[configuration];

  // IRQ selection
  assign user_irq    = proj_user_irq[configuration];

  //assigning unconnected outputs
  genvar j;
  generate
    for (j = `MPRJ_IO_PADS - CFG_BITS; j < `MPRJ_IO_PADS; j = j + 1) begin
      assign io_out[j] = 0;
      assign io_oeb[j] = 1;
    end
  endgenerate

endmodule
