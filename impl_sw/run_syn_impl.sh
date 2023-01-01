#!/bin/bash -e

mkdir -p report
mkdir -p routed_dcp
mkdir -p logs

part_name=xczu9eg-ffvb1156-2-e
clk_period=1
echo "create_clock -period 1.000 -name clk -waveform {0.000 0.5} [get_ports clk]" > top.xdc
./run_tcl.sh syn_impl.tcl "t_switch" "256" $part_name $clk_period > "./logs/t_switch_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "t_switch_rand" "256" $part_name $clk_period > "./logs/t_switch_rand_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "pi_switch" "256" $part_name $clk_period > "./logs/pi_switch_$clk_period.log"

clk_period=1.1
echo "create_clock -period 1.100 -name clk -waveform {0.000 0.550} [get_ports clk]" > top.xdc
./run_tcl.sh syn_impl.tcl "t_switch" "256" $part_name $clk_period > "./logs/t_switch_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "t_switch_rand" "256" $part_name $clk_period > "./logs/t_switch_rand_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "pi_switch" "256" $part_name $clk_period > "./logs/pi_switch_$clk_period.log"

clk_period=1.2
echo "create_clock -period 1.200 -name clk -waveform {0.000 0.600} [get_ports clk]" > top.xdc
./run_tcl.sh syn_impl.tcl "t_switch" "256" $part_name $clk_period > "./logs/t_switch_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "t_switch_rand" "256" $part_name $clk_period > "./logs/t_switch_rand_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "pi_switch" "256" $part_name $clk_period > "./logs/pi_switch_$clk_period.log"

clk_period=1.3
echo "create_clock -period 1.300 -name clk -waveform {0.000 0.650} [get_ports clk]" > top.xdc
./run_tcl.sh syn_impl.tcl "t_switch" "256" $part_name $clk_period > "./logs/t_switch_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "t_switch_rand" "256" $part_name $clk_period > "./logs/t_switch_rand_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "pi_switch" "256" $part_name $clk_period > "./logs/pi_switch_$clk_period.log"

clk_period=1.4
echo "create_clock -period 1.400 -name clk -waveform {0.000 0.700} [get_ports clk]" > top.xdc
./run_tcl.sh syn_impl.tcl "t_switch" "256" $part_name $clk_period > "./logs/t_switch_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "t_switch_rand" "256" $part_name $clk_period > "./logs/t_switch_rand_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "pi_switch" "256" $part_name $clk_period > "./logs/pi_switch_$clk_period.log"

clk_period=1.5
echo "create_clock -period 1.5 -name clk -waveform {0.000 0.750} [get_ports clk]" > top.xdc
./run_tcl.sh syn_impl.tcl "t_switch" "256" $part_name $clk_period > "./logs/t_switch_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "t_switch_rand" "256" $part_name $clk_period > "./logs/t_switch_rand_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "pi_switch" "256" $part_name $clk_period > "./logs/pi_switch_$clk_period.log"

clk_period=1.6
echo "create_clock -period 1.6 -name clk -waveform {0.000 0.800} [get_ports clk]" > top.xdc
./run_tcl.sh syn_impl.tcl "t_switch" "256" $part_name $clk_period > "./logs/t_switch_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "t_switch_rand" "256" $part_name $clk_period > "./logs/t_switch_rand_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "pi_switch" "256" $part_name $clk_period > "./logs/pi_switch_$clk_period.log"

clk_period=1.7
echo "create_clock -period 1.7 -name clk -waveform {0.000 0.850} [get_ports clk]" > top.xdc
./run_tcl.sh syn_impl.tcl "t_switch" "256" $part_name $clk_period > "./logs/t_switch_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "t_switch_rand" "256" $part_name $clk_period > "./logs/t_switch_rand_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "pi_switch" "256" $part_name $clk_period > "./logs/pi_switch_$clk_period.log"

clk_period=1.8
echo "create_clock -period 1.8 -name clk -waveform {0.000 0.900} [get_ports clk]" > top.xdc
./run_tcl.sh syn_impl.tcl "t_switch" "256" $part_name $clk_period > "./logs/t_switch_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "t_switch_rand" "256" $part_name $clk_period > "./logs/t_switch_rand_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "pi_switch" "256" $part_name $clk_period > "./logs/pi_switch_$clk_period.log"

clk_period=1.9
echo "create_clock -period 1.9 -name clk -waveform {0.000 0.950} [get_ports clk]" > top.xdc
./run_tcl.sh syn_impl.tcl "t_switch" "256" $part_name $clk_period > "./logs/t_switch_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "t_switch_rand" "256" $part_name $clk_period > "./logs/t_switch_rand_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "pi_switch" "256" $part_name $clk_period > "./logs/pi_switch_$clk_period.log"

clk_period=2
echo "create_clock -period 2.000 -name clk -waveform {0.000 1.000} [get_ports clk]" > top.xdc
./run_tcl.sh syn_impl.tcl "t_switch" "256" $part_name $clk_period > "./logs/t_switch_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "t_switch_rand" "256" $part_name $clk_period > "./logs/t_switch_rand_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "pi_switch" "256" $part_name $clk_period > "./logs/pi_switch_$clk_period.log"

clk_period=2.1
echo "create_clock -period 2.1 -name clk -waveform {0.000 1.050} [get_ports clk]" > top.xdc
./run_tcl.sh syn_impl.tcl "t_switch" "256" $part_name $clk_period > "./logs/t_switch_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "t_switch_rand" "256" $part_name $clk_period > "./logs/t_switch_rand_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "pi_switch" "256" $part_name $clk_period > "./logs/pi_switch_$clk_period.log"

clk_period=2.2
echo "create_clock -period 2.222 -name clk -waveform {0.000 1.111} [get_ports clk]" > top.xdc
./run_tcl.sh syn_impl.tcl "t_switch" "256" $part_name $clk_period > "./logs/t_switch_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "t_switch_rand" "256" $part_name $clk_period > "./logs/t_switch_rand_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "pi_switch" "256" $part_name $clk_period > "./logs/pi_switch_$clk_period.log"

clk_period=2.3
echo "create_clock -period 2.300 -name clk -waveform {0.000 1.150} [get_ports clk]" > top.xdc
./run_tcl.sh syn_impl.tcl "t_switch" "256" $part_name $clk_period > "./logs/t_switch_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "t_switch_rand" "256" $part_name $clk_period > "./logs/t_switch_rand_$clk_period.log" &
./run_tcl.sh syn_impl.tcl "pi_switch" "256" $part_name $clk_period > "./logs/pi_switch_$clk_period.log"
