# SPDX-FileCopyrightText: 2020 Efabless Corporation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0

source $::env(DESIGN_DIR)/fixed_wrapper_cfgs.tcl
source $::env(DESIGN_DIR)/default_wrapper_cfgs.tcl
set ::env(IO_SYNC) 0

set ::env(DESIGN_NAME) user_project_wrapper
set ::env(ROUTING_CORES) 36
set ::env(DESIGN_IS_CORE) 1
set ::env(BASE_SDC_FILE) "$::env(DESIGN_DIR)/base_user_project_wrapper.sdc"
set ::env(RCX_SDC_FILE) "$::env(DESIGN_DIR)/signoff_user_project_wrapper.sdc"

set ::env(VERILOG_FILES) "\
                        $::env(DESIGN_DIR)/../../verilog/rtl/defines.v \
                        $::env(DESIGN_DIR)/../../verilog/rtl/user_project_wrapper.v \
"
                    
set ::env(RUN_KLAYOUT) 0

# clock constraints
set ::env(CLOCK_PORT) "wb_clk_i"
set ::env(CLOCK_NET) "mprj.clk"
set ::env(CLOCK_PERIOD) 20

# Synthesis
set ::env(SYNTH_STRATEGY) "DELAY 1"
set ::env(NO_SYNTH_CELL_LIST) $::env(DESIGN_DIR)/no_synth.cells
set ::env(DRC_EXCLUDE_CELL_LIST) $::env(DESIGN_DIR)/drc_exclude.cells
set ::env(SYNTH_READ_BLACKBOX_LIB) 0
set ::env(SYNTH_USE_PG_PINS_DEFINES) "USE_POWER_PINS"
set ::env(SYNTH_BUFFERING) 0
set ::env(SYNTH_MAX_FANOUT) 18
set ::env(SYNTH_CAP_LOAD) 52
set ::env(SYNTH_CLOCK_TRANSITION) 0.5
set ::env(SYNTH_CLOCK_UNCERTAINTY) 0.25
set ::env(SYNTH_MAX_TRAN) 0.75

## Floorplan
set ::env(FP_TAPCELL_DIST) 10

# set ::env(CELL_PAD) 0

## PDN 
set ::env(FP_PDN_MACRO_HOOKS) {
    genblk1\\\\\\[0\\\\\\].user_project vccd1 vssd1 vccd1 vssd1,\
    genblk1\\\\\\[0\\\\\\].user_project vccd2 vssd2 vccd2 vssd2,\
    genblk1\\\\\\[1\\\\\\].user_project vccd1 vssd1 vccd1 vssd1,\
    genblk1\\\\\\[1\\\\\\].user_project vccd2 vssd2 vccd2 vssd2,\
    genblk1\\\\\\[2\\\\\\].user_project vccd1 vssd1 vccd1 vssd1,\
    genblk1\\\\\\[2\\\\\\].user_project vccd2 vssd2 vccd2 vssd2,\
    genblk1\\\\\\[3\\\\\\].user_project vccd1 vssd1 vccd1 vssd1,\
    genblk1\\\\\\[3\\\\\\].user_project vccd2 vssd2 vccd2 vssd2
}


##CTS
set ::env(CLOCK_TREE_SYNTH) 1
set ::env(CTS_MAX_CAP) 0.5
set ::env(CTS_SINK_CLUSTERING_SIZE) 12
set ::env(CTS_SINK_CLUSTERING_MAX_DIAMETER) 30
set ::env(CTS_CLK_BUFFER_LIST) {sky130_fd_sc_hd__clkbuf_8 sky130_fd_sc_hd__clkbuf_4}
set ::env(CTS_CLK_MAX_WIRE_LENGTH) 600

##PLACEMENT
set ::env(PL_ROUTABILITY_DRIVEN) 0
set ::env(PL_TIME_DRIVEN) 1
set ::env(PL_TARGET_DENSITY) 0.15

set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_HOLD_SLACK_MARGIN) 0.03
set ::env(PL_RESIZER_ALLOW_SETUP_VIOS) 0
set ::env(PL_RESIZER_SETUP_SLACK_MARGIN) 0.1
set ::env(PL_RESIZER_MAX_WIRE_LENGTH) 1000
set ::env(PL_RESIZER_MAX_SLEW_MARGIN) 50
set ::env(PL_RESIZER_CAP_SLEW_MARGIN) 50
set ::env(PL_RESIZER_HOLD_MAX_BUFFER_PERCENT) 50

##ROUTING
set ::env(GRT_ALLOW_CONGESTION) 1
set ::env(GRT_OBS) "\
    met5 86 116 1386 1716, \
    met5 1534 116 2834 1716, \
    met5 86 1830 1386 3430, \
    met5 1534 1830 2834 3430 \
"
set ::env(GRT_ADJUSTMENT) 0.15
##                                li1 ,met1,met2,met3,met4,met5
set ::env(GRT_LAYER_ADJUSTMENTS) "0.99,0.10,0.05,0.10,0.05,0.00"
set ::env(GRT_OVERFLOW_ITERS) 50

set ::evn(DRT_OPT_ITERS) 12
set ::env(GRT_ESTIMATE_PARASITICS) 1

set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(GLB_RESIZER_HOLD_SLACK_MARGIN) 0.4
set ::env(GLB_RESIZER_SETUP_SLACK_MARGIN) 1
set ::env(GLB_RESIZER_MAX_WIRE_LENGTH) 600
set ::env(GLB_RESIZER_MAX_SLEW_MARGIN) 30
set ::env(GLB_RESIZER_MAX_CAP_MARGIN) 30

## Antenna
set ::env(DIODE_INSERTION_STRATEGY) 3
set ::env(GRT_ANT_ITERS) 15
set ::env(GRT_MAX_DIODE_INS_ITERS) 40
set ::env(DIODE_PADDING) 0

## MACROS
set ::env(MACRO_PLACEMENT_CFG) [glob $::env(DESIGN_DIR)/macro_placement.cfg]


set ::env(VERILOG_FILES_BLACKBOX) "\
    $::env(DESIGN_DIR)/../../verilog/rtl/defines.v \
    $::env(DESIGN_DIR)/../../verilog/rtl/user_project.v \
"

set ::env(EXTRA_LEFS) "\
    $::env(DESIGN_DIR)/../../lef/user_project.lef \
"

set ::env(EXTRA_GDS_FILES) "\
    $::env(DESIGN_DIR)/../../gds/user_project.gds \
"

set ::env(EXTRA_LIBS) "\
    $::env(DESIGN_DIR)/../../lib/user_project.nom.lib \
"

set ::env(STA_WRITE_LIB) 0

## For faster development
set ::env(QUIT_ON_TR_DRC) 0
set ::env(QUIT_ON_LVS_ERROR) 0
set ::env(QUIT_ON_MAGIC_DRC) 0

set ::env(MAGIC_DEF_LABELS) 0
set ::env(MAGIC_EXT_USE_GDS) 0