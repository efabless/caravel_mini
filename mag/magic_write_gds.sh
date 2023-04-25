#!/bin/sh
export PDK=sky130A
export MAGIC=magic
export PDKPATH=$PDK_ROOT/sky130A ; 
export MACRO=user_project_wrapper
$MAGIC -dnull -noconsole -rcfile $PDKPATH/libs.tech/magic/sky130A.magicrc  <<EOF

gds readonly true
gds rescale false

load $MACRO
select top cell

cif *hier write disable
cif *array write disable

gds nodatestamp yes

gds write $MACRO.gds
quit -noprompt
EOF

# feedback save ${1%.mag}.ext.tcl
# snap int
# source 	${1%.mag}.ext.tcl