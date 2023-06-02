 #!/bin/bash -e

NUM_LEAVES=256
PACKET_SIZE=32
NUM_SENT_PER_LEAF=1024
# INJECTION_RATE_SET=(1 3 5 7 10 20 30 50 100)
INJECTION_RATE_SET=(100 50 30 20 10 7 5 3 1)

# Synthetic Random workloads

# ############
# ## test_9 ##
# ############
# INJECTION_RATE_SLOW_SET=(1 3 5 7 10 20 30 50 100)
# INJECTION_RATE_SLOW_SET=(100 50 30 20 10 7 5 3 1)

# cp ./_network_backup/256leaves/gen_nw_as3.v gen_nw.v
# TEST="test_9"
# IR=100
# for IR_S in ${INJECTION_RATE_SLOW_SET[@]}
# do
#     python network_tester.py -nl $NUM_LEAVES -tp ${TEST}_${IR_S} -ntw 'as3' -nspl $NUM_SENT_PER_LEAF -irt $IR -pks $PACKET_SIZE -irt_s $IR_S     
# done


##################
## test_0,3,5,7 ##
##################
# TEST_SET=("test_0" "test_5" "test_7" "test_3")
# TEST_SET=("test_0")

# INJECTION_RATE_SET=(100)
# cp ./_network_backup/256leaves/gen_nw_as1.v gen_nw.v
# for TEST in ${TEST_SET[@]}
# do
#     for IR in ${INJECTION_RATE_SET[@]}
#     do
#         python network_tester.py -nl $NUM_LEAVES -tp $TEST -ntw 'as3' -nspl $NUM_SENT_PER_LEAF -irt $IR -pks $PACKET_SIZE
#     done
# done


# Realistic workloads

# TEST_SET=("CA-CondMat" "CA-HepTh_rev" "DE_edges" "deezer_europe_edges_rev" "Email-Enron_rev" "fb-government_edges_rev" "fb-new_sites_edges_rev" "human_rev" "simucad_dac" "soc_rev" "stanford")
# INJECTION_RATE_SET=(1 3 5 7 10 20 30 50 100)

# IR=100
# cp ./_network_backup/256leaves/gen_nw_s0.v gen_nw.v
# for TEST in ${TEST_SET[@]}
# do
#     python network_tester.py -nl $NUM_LEAVES -tp $TEST -ntw 's0' -irt $IR -pks $PACKET_SIZE
# done




# Just generate random testbench

TEST_SET=("test_0" "test_5" "test_7" "test_3")

cp ./_network_backup/256leaves/gen_nw_s0.v gen_nw.v
for TEST in ${TEST_SET[@]}
do
    python network_tester.py -nl $NUM_LEAVES -tp $TEST -ntw 's0' -nspl $NUM_SENT_PER_LEAF -pks $PACKET_SIZE -tb
done


INJECTION_RATE_SLOW_SET=(1 3 5 7 10 20 30 50 100)
cp ./_network_backup/256leaves/gen_nw_s0.v gen_nw.v
TEST="test_9"
IR=100
for IR_S in ${INJECTION_RATE_SLOW_SET[@]}
do
    python network_tester.py -nl $NUM_LEAVES -tp ${TEST}_${IR_S} -ntw 's0' -nspl $NUM_SENT_PER_LEAF -irt $IR -pks $PACKET_SIZE -irt_s $IR_S -tb
done

INJECTION_RATE_SLOW_SET=(1 3 5 7 10 20 30 50 100)
cp ./_network_backup/256leaves/gen_nw_s0.v gen_nw.v
TEST="test_10"
IR=100
for IR_S in ${INJECTION_RATE_SLOW_SET[@]}
do
    python network_tester.py -nl $NUM_LEAVES -tp ${TEST}_${IR_S} -ntw 's0' -nspl $NUM_SENT_PER_LEAF -irt $IR -pks $PACKET_SIZE -irt_s $IR_S -tb
done
