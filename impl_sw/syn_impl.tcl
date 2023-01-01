set sw_name [lindex $argv 0]
set num_leaves [lindex $argv 1]
set part_name [lindex $argv 2]
set clk_period [lindex $argv 3]
set top_name "${sw_name}_top"
set routed_file_name "${sw_name}_${clk_period}_routed.dcp"
set report_name "ut_${sw_name}_${clk_period}.txt"
set t_report_name "t_${sw_name}_${clk_period}.txt"

add_files ./src/$top_name.v
add_files ./src/$sw_name.v
add_files -fileset constrs_1 -norecurse top.xdc

synth_design -top $top_name -part $part_name -mode out_of_context
opt_design
place_design
route_design
write_checkpoint -force ./routed_dcp/$routed_file_name
report_utilization -force -hierarchical -file ./report/$report_name
report_timing_summary > ./report/$t_report_name
