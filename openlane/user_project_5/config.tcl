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

source $::env(DESIGN_DIR)/default_cfgs.tcl
source $::env(DESIGN_DIR)/fixed_cfgs.tcl

set ::env(DESIGN_NAME) user_project_5
set ::env(BASE_SDC_FILE) $::env(DESIGN_DIR)/base_user_project.sdc
set ::env(VERILOG_FILES) "\
	$script_dir/../../verilog/rtl/user_project_5.v \
	$script_dir/../../verilog/rtl/counter.v"

set ::env(CLOCK_PORT) "wb_clk_i"
set ::env(CLOCK_NET) "wb_clk_i"

set ::env(CLOCK_PERIOD) "30"
set ::env(SYNTH_CLOCK_TRANSITION) 0.64
set ::env(SYNTH_CLOCK_UNCERTAINTY) 0.3
set ::env(SYNTH_MAX_TRAN) 1.0
set ::env(SYNTH_MAX_FANOUT) 14
set ::env(SYNTH_TIMING_DERATE) 0.08

##PLACEMENT
set ::env(PL_ROUTABILITY_DRIVEN) 1
set ::env(PL_TIME_DRIVEN) 1
set ::env(PL_TARGET_DENSITY) 0.24
set ::env(PL_WIRELENGTH_COEF) 0.01

set ::env(PL_RESIZER_DESIGN_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(PL_RESIZER_HOLD_SLACK_MARGIN) 0.5
set ::env(PL_RESIZER_ALLOW_SETUP_VIOS) 0
set ::env(PL_RESIZER_SETUP_SLACK_MARGIN) 0.1
set ::env(PL_RESIZER_MAX_WIRE_LENGTH) 600
set ::env(PL_RESIZER_MAX_SLEW_MARGIN) 20
set ::env(PL_RESIZER_MAX_CAP_MARGIN) 20

##CTS
set ::env(CLOCK_TREE_SYNTH) 1
set ::env(CTS_MAX_CAP) 0.4
set ::env(CTS_SINK_CLUSTERING_SIZE) 12
set ::env(CTS_SINK_CLUSTERING_MAX_DIAMETER) 30
set ::env(CTS_CLK_BUFFER_LIST) {sky130_fd_sc_hd__clkbuf_16 sky130_fd_sc_hd__clkbuf_8 sky130_fd_sc_hd__clkbuf_4}
set ::env(CTS_CLK_MAX_WIRE_LENGTH) 500

##Routing
set ::env(ROUTING_CORES) 32
set ::env(GLB_RESIZER_TIMING_OPTIMIZATIONS) 1
set ::env(GLB_RESIZER_HOLD_SLACK_MARGIN) 1.2
set ::env(GLB_RESIZER_SETUP_SLACK_MARGIN) 1
set ::env(GLB_RESIZER_MAX_WIRE_LENGTH) 600
set ::env(GLB_RESIZER_MAX_SLEW_MARGIN) 20
set ::env(GLB_RESIZER_MAX_CAP_MARGIN) 20

## Antenna
set ::env(GRT_REPAIR_ANTENNAS) 1
set ::env(RUN_HEURISTIC_DIODE_INSERTION) 1
set ::env(HEURISTIC_ANTENNA_THRESHOLD) 400
set ::env(DIODE_ON_PORTS) "both"
set ::env(GRT_ANT_ITERS) 12
set ::env(GRT_ANT_MARGIN) 20
set ::env(GRT_MAX_DIODE_INS_ITERS) 4
set ::env(DIODE_PADDING) 0

##Signoff
set ::env(RUN_KLAYOUT) 0