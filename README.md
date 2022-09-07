# Multi-Project Support for Caravel
The objective is to enable multiple users to share the same Caravel chip.  This would allow several small MPW projects to be implemented into a single chip, increasing the number of designs per each MPW run. For chipIgnite, it would reduce the fabrication cost for designs that don’t utilize the whole user’s area. Each design can still access the whole Caravel 38 user's I/Os as well as the WB bus. In addition to WB and I/O pads access, each design area gets a clock and reset signals. The reset signal is asserted through the FW. Also, the clock can be enabled/disabled through the FW.


To minimize the effort, we will leverage the existing Caravel chip design through a custom user’s project design. This unique design partitions the user’s project area between multiple projects. After fabrication, only one design can be active at any time. Design selection is performed through a special management SoC firmware. 

The project aims at the following configurations
- 4 (2x2) designs, each 1.3x1.7 mm2 (~ 200K Sky130 HD cells)
- 9 (3x3) designs, each 900x900 um2 (~ 80K Sky130 HD cells)
- 20 (5x4) designs, each 650x650 um2 (~ 40K Sky130 HD cells)
