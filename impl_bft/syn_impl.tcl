set top_name gen_nw_top
set bft_name [lindex $argv 0]
set num_leaves [lindex $argv 1]
set part_name [lindex $argv 2]
set dir_name "${num_leaves}leaves"
set synth_file_name "${bft_name}_synth.dcp"
set routed_file_name "${bft_name}_routed.dcp"

set report_name "${bft_name}_report.txt"
set timing_report_name "${bft_name}_timing_report.txt"
set pow_report_name "${bft_name}_pow_report.txt"

add_files ./$dir_name/gen_nw_$bft_name.v
add_files axi_pe_$num_leaves.v
add_files -fileset constrs_1 -norecurse top.xdc
synth_design -top $top_name -part $part_name -mode out_of_context
write_checkpoint -force ./synth_dcp/$dir_name/$synth_file_name

opt_design
power_opt_design
place_design
route_design
write_checkpoint -force ./routed_dcp/$dir_name/$routed_file_name
report_utilization -force -hierarchical -file ./report/$dir_name/$report_name
report_timing_summary > ./report/$dir_name/$timing_report_name
report_power > ./report/$dir_name/$pow_report_name
