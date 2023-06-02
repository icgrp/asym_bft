./impl_bft: cd to the dir, source run_syn_impl.sh to generate implementation reports for different BFTs
./impl_sw: cd to the dir, source run_syn_impl.sh to generate implementation reports for switches
./_network_backup: BFTs in this dir are identical to those in ./impl_bft except the interface module

- source run_experiments.sh to generate synthetic workloads
- ./data/metis/: python gen_traces.py to generate realistic graph workloads

- source run_experiments.sh to run the experiments