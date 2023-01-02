#!/bin/bash` -e

NUM_LEAVES=24
NUM_SENT_PER_LEAF=1024
PACKET_SIZE=49
INJECTION_RATE_SET=(1 3 5 7 10 20 30 50 100)
#INJECTION_RATE_SET=(100)

############
## test_9 ##
############
INJECTION_RATE_SLOW_SET=(1 3 5 7 10 20 30 50 100)

cp ./_network_backup/24leaves/gen_nw_s0.v gen_nw.v
TEST="test_9"
IR=100
for IR_S in ${INJECTION_RATE_SLOW_SET[@]}
do
    python network_tester.py -nl $NUM_LEAVES -tp ${TEST}_${IR_S} -ntw 's0' -nspl $NUM_SENT_PER_LEAF -irt $IR -pks $PACKET_SIZE -irt_s $IR_S     
done

# cp ./_network_backup/24leaves/gen_nw_s1.v gen_nw.v
# TEST="test_9"
# IR=100
# for IR_S in ${INJECTION_RATE_SLOW_SET[@]}
# do
#     python network_tester.py -nl $NUM_LEAVES -tp $TEST -ntw 's1' -nspl $NUM_SENT_PER_LEAF -irt $IR -pks $PACKET_SIZE -irt_s $IR_S     
# done

# cp ./_network_backup/24leaves/gen_nw_s2.v gen_nw.v
# TEST="test_9"
# IR=100
# for IR_S in ${INJECTION_RATE_SLOW_SET[@]}
# do
#     python network_tester.py -nl $NUM_LEAVES -tp $TEST -ntw 's2' -nspl $NUM_SENT_PER_LEAF -irt $IR -pks $PACKET_SIZE -irt_s $IR_S     
# done

# cp ./_network_backup/24leaves/gen_nw_as0.v gen_nw.v
# TEST="test_9"
# IR=100
# for IR_S in ${INJECTION_RATE_SLOW_SET[@]}
# do
#     python network_tester.py -nl $NUM_LEAVES -tp $TEST -ntw 'as0' -nspl $NUM_SENT_PER_LEAF -irt $IR -pks $PACKET_SIZE -irt_s $IR_S     
# done


##################
## test_0,3,5,7 ##
##################
TEST_SET=("test_0" "test_5" "test_7" "test_3")

cp ./_network_backup/24leaves/gen_nw_s0.v gen_nw.v
for IR in ${INJECTION_RATE_SET[@]}
do
    for TEST in ${TEST_SET[@]}
    do
        python network_tester.py -nl $NUM_LEAVES -tp $TEST -ntw 's0' -nspl $NUM_SENT_PER_LEAF -irt $IR -pks $PACKET_SIZE        
    done
done

# cp ./_network_backup/24leaves/gen_nw_s1.v gen_nw.v
# for IR in ${INJECTION_RATE_SET[@]}
# do
#     for TEST in ${TEST_SET[@]}
#     do
#         python network_tester.py -nl $NUM_LEAVES -tp $TEST -ntw 's1' -nspl $NUM_SENT_PER_LEAF -irt $IR -pks $PACKET_SIZE        
#     done
# done

# cp ./_network_backup/24leaves/gen_nw_s2.v gen_nw.v
# for IR in ${INJECTION_RATE_SET[@]}
# do
#     for TEST in ${TEST_SET[@]}
#     do
#         python network_tester.py -nl $NUM_LEAVES -tp $TEST -ntw 's2' -nspl $NUM_SENT_PER_LEAF -irt $IR -pks $PACKET_SIZE        
#     done
# done

# cp ./_network_backup/24leaves/gen_nw_as0.v gen_nw.v
# for IR in ${INJECTION_RATE_SET[@]}
# do
#     for TEST in ${TEST_SET[@]}
#     do
#         python network_tester.py -nl $NUM_LEAVES -tp $TEST -ntw 'as0' -nspl $NUM_SENT_PER_LEAF -irt $IR -pks $PACKET_SIZE        
#     done
# done
