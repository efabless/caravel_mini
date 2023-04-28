## Clock constraints
# Clock network
set ::env(CLOCK_PORT) "wb_clk_i"
set ::env(CLOCK_PERIOD) 25

if {[info exists ::env(CLOCK_PORT)] && $::env(CLOCK_PORT) != ""} {
    set clk_input $::env(CLOCK_PORT)
    create_clock [get_ports $clk_input]  -name clk  -period $::env(CLOCK_PERIOD) 
    puts "\[INFO\]: Creating clock {clk} for port $clk_input with period: $::env(CLOCK_PERIOD)"
} else {
    set clk_input __VIRTUAL_CLK__
    create_clock -name clk -period $::env(CLOCK_PERIOD)
    puts "\[INFO\]: Creating virtual clock with period: $::env(CLOCK_PERIOD)"
}

set_propagated_clock [get_clocks {clk}]
set signoff_uncer 0.1
# Clock non-idealities
set_clock_uncertainty $signoff_uncer [get_clocks {clk}]
puts "\[INFO\]: Setting clock uncertainity to: $signoff_uncer"


# Clock transition
set clk_tran 0.1
set_input_transition $clk_tran [get_ports $clk_input] 
puts "\[INFO\]: Setting input clock transition: $clk_tran"

## Data paths Constraints
# Maximum transition time of the design nets 
set max_tran 1.5
set_max_transition $max_tran [current_design]

set ::env(SYNTH_TIMING_DERATE) 0.05
# Timing paths delays derate
set_timing_derate -early [expr {1-$::env(SYNTH_TIMING_DERATE)}]
set_timing_derate -late [expr {1+$::env(SYNTH_TIMING_DERATE)}]
puts "\[INFO\]: Setting timing derate to: [expr {$::env(SYNTH_TIMING_DERATE) * 100}] %"

# Input/Output delay budget
set clk_indx [lsearch [all_inputs] $clk_input]
set all_inputs_wo_clk [lreplace [all_inputs] $clk_indx $clk_indx ""]
set_input_delay 1 -clock [get_clocks {clk}] $all_inputs_wo_clk
set_output_delay 1 -clock [get_clocks {clk}] [all_outputs]

set_load 0.03 [all_outputs]