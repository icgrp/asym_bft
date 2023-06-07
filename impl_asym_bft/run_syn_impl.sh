#!/bin/bash -e

mkdir -p report/256leaves
mkdir -p synth_dcp/256leaves
mkdir -p routed_dcp/256leaves
mkdir -p logs/256leaves


mkdir -p report/16leaves
mkdir -p synth_dcp/16leaves
mkdir -p routed_dcp/16leaves
mkdir -p logs/16leaves


part_name=xczu9eg-ffvb1156-2-e
# N=16
# ./run_tcl.sh syn_impl.tcl "p05" "16" $part_name > "./logs/16leaves/p05.log"
# ./run_tcl.sh syn_impl.tcl "p067" "16" $part_name > "./logs/16leaves/p067.log"

# N=24
#./run_tcl.sh syn_impl.tcl "s0" "24" $part_name > "./logs/24leaves/s0.log" &
#./run_tcl.sh syn_impl.tcl "s1" "24" $part_name > "./logs/24leaves/s1.log" &
#./run_tcl.sh syn_impl.tcl "s2" "24" $part_name > "./logs/24leaves/s2.log" &
#./run_tcl.sh syn_impl.tcl "as0" "24" $part_name > "./logs/24leaves/as0.log"

N=256
# ./run_tcl.sh syn_impl.tcl "s0" "256" $part_name > "./logs/256leaves/s0.log" &
# ./run_tcl.sh syn_impl.tcl "s1" "256" $part_name > "./logs/256leaves/s1.log" &
./run_tcl.sh syn_impl.tcl "as7" "256" $part_name > "./logs/256leaves/as7.log" # &
#./run_tcl.sh syn_impl.tcl "as2" "256" $part_name > "./logs/256leaves/as2.log"

#./run_tcl.sh syn_impl.tcl "as3" "256" $part_name > "./logs/256leaves/as3.log" &
#./run_tcl.sh syn_impl.tcl "as4" "256" $part_name > "./logs/256leaves/as4.log"
