For simulation:
- In gen_asym_bft.py, function build_end(), uncomment 'f = open("bft_asym_fixed_sim.txt", "r")' and comment 'f = open("bft_asym_fixed_impl.txt", "r")'.
- Assign the bft pattern to the variable 'pattern' in function 'make_network()'.
- Run 'python3 ./gen_asym_bft_tester.py -nl 256'

For implementaion:
- Put desired bft patterns into the file 'tree_pattern.txt'.
- Modify the arguments for running run_tcl.sh in the file 'run_syn_impl.sh' (change the number after 'as').
- Run 'bash run_syn_impl.sh'.
