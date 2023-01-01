#!/bin/bash -e

NUM_LEAVES=256
PACKET_SIZE=52
NUM_SENT_PER_LEAF=1024

TEST_SET=("test_0" "test_3" "test_5" "test_7")
# TEST_SET=("test_9")
INJECTION_RATE_SET=(1 3 5 7 10 20 30 50 100)

# Synthetic Random workloads
cp ./_network_backup/256leaves/gen_nw_s0.v gen_nw.v
for TEST in ${TEST_SET[@]}
do
    for IR in ${INJECTION_RATE_SET[@]}
    do
        python network_tester.py -nl $NUM_LEAVES -tp $TEST -ntw 's0' -nspl $NUM_SENT_PER_LEAF -irt $IR -pks $PACKET_SIZE
    done
done

# cp ./_network_backup/256leaves/gen_nw_s0.v gen_nw.v
# TEST="test_9"
# IR=100
# for IR_S in ${INJECTION_RATE_SLOW_SET[@]}
# do
#     python network_tester.py -nl $NUM_LEAVES -tp $TEST -ntw 's0' -nspl $NUM_SENT_PER_LEAF -irt $IR -pks $PACKET_SIZE -irt_s $IR_S     
# done


# Realistic workloads

# TEST_SET=("soc_rev" "human_rev" "facebook_rev" "DE_edges" "fb-new_sites_edges_rev" "fb-government_edges_rev" "fb-tvshow_edges" "CA-HepTh_rev" "CA-CondMat")
# INJECTION_RATE_SET=(1 3 5 7 10 20 30 50 100)

# IR=100
# cp ./_network_backup/256leaves/gen_nw_s0.v gen_nw.v
# for TEST in ${TEST_SET[@]}
# do
#     python network_tester.py -nl $NUM_LEAVES -tp $TEST -ntw 's0' -irt $IR -pks $PACKET_SIZE
# done