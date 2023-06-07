#!/bin/bash -e

tcl_name=$1
tcl_argv1=$2
tcl_argv2=$3
tcl_argv3=$4

vivado -mode batch -source  ${tcl_name} -tclargs $2 $3 $4
