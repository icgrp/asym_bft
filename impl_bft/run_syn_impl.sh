#!/bin/bash -e

mkdir -p report/24leaves
mkdir -p report/256leaves
mkdir -p synth_dcp/24leaves
mkdir -p synth_dcp/256leaves
mkdir -p routed_dcp/24leaves
mkdir -p routed_dcp/256leaves
mkdir -p logs/24leaves
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
./run_tcl.sh syn_impl.tcl "s0" "256" $part_name > "./logs/256leaves/s0.log" &
./run_tcl.sh syn_impl.tcl "s1" "256" $part_name > "./logs/256leaves/s1.log" &
./run_tcl.sh syn_impl.tcl "as1" "256" $part_name > "./logs/256leaves/as1.log" &
./run_tcl.sh syn_impl.tcl "as5" "256" $part_name > "./logs/256leaves/as5.log"

./run_tcl.sh syn_impl.tcl "as0" "256" $part_name > "./logs/256leaves/as0.log" &
./run_tcl.sh syn_impl.tcl "as2" "256" $part_name > "./logs/256leaves/as2.log"
