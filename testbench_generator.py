#!/usr/bin/python3
from network_generator import clog2
import pdb
import random
from math import ceil, log
import os

def clog2(num):
    return int(ceil(log(num, 2)))


def create_packet_creator(num_leaves, injection_rate, traffic_pattern, injection_rate_slow):
    import random
    from datetime import datetime
    random.seed(datetime.now())
    
    num_msg_file = "./data/bench/" + traffic_pattern + "/" + str(num_leaves) + "/num_msg.txt"
    num_msg_list = []
    with open(num_msg_file,"r") as file:
        for line in file:
            num_msg = int(line.strip())
            num_msg_list.append(num_msg)
    assert(len(num_msg_list) == num_leaves)

    code_string = ""
    num_leaves_power_of_two = 2**clog2(num_leaves)

    for i in range(num_leaves):
        if(traffic_pattern == "test_9" and i >= num_leaves_power_of_two//2): # slow injection rate in subtree2,3
            injection_rate = injection_rate_slow
        num_sent_per_leaf = num_msg_list[i]
        code_packet_creator = '\n'.join([
            'module packet_creator_' + str(i) + ' (',
            '\tinput clk, ',
            '\tinput reset,',
            '\tinput resend,',
            '\toutput reg [p_sz-1:0] bus_o',
            '\t);',
            '',
            '\tparameter num_leaves= ' + str(num_leaves) + ';',
            '\tparameter payload_sz = 1; // contains source address',
            '\tparameter addr= 1\'b0;',
            '\tparameter p_sz= 1 + $clog2(num_leaves) + payload_sz; // packet size',
            '\tparameter num_sent_per_leaf= ' + str(num_sent_per_leaf) + ';',
            '\t',
            '\tparameter send_order_sz= $clog2(num_sent_per_leaf);',
            '\treg [send_order_sz:0] i;',
            '\treg send_out;',
            '\tinteger seed= ' + str(random.randint(0,2**32-1)) + ';',
            '\treg [p_sz-1:0] data_to_be_sent[num_sent_per_leaf-1:0];', # changed
            '',            
            '\tinitial begin',
        '\t\t{i , send_out} <= 0;',
        '\t\t$readmemb("./data/bench/' + traffic_pattern + '/' + str(num_leaves) + '/autogen_' + str(i) +'.trace", data_to_be_sent);',
        '\tend',
        '\talways @(posedge clk) begin',
        '\t\tif (reset)',
        '\t\t\t{i, send_out, bus_o} <= 0;',
        '\t\telse if (!resend && send_out) begin',
        '\t\t\tbus_o <= data_to_be_sent[i];',
            '\t\t\ti <= i + 1;',
        '\t\t\tif (i < num_sent_per_leaf-1) begin',
            '\t\t\t\tsend_out <= (($random(seed) % ' + str(100 // injection_rate) + 
                ') == 1\'b0);',
            '\t\t\tend',
            '\t\t\telse',
            '\t\t\t\tsend_out <= 0;',
            '\t\tend',
            '\t\telse if (resend && send_out) begin',
            '\t\t\tbus_o <= 0;',
            '\t\tend',
            '\t\telse begin',
            '\t\t\tbus_o <= 0;',
            '\t\t\tif (i < num_sent_per_leaf) begin',
            '\t\t\t\tsend_out <= (($random(seed) % ' + str(100 // injection_rate) + 
                ') == 1\'b0);',
            '\t\t\tend',
            '\t\t\telse',
            '\t\t\t\tsend_out <= 0;',
            '\t\tend',
            '\tend',
            'endmodule',
            '',
            ''])
        code_string = code_string + code_packet_creator

    return code_string


def create_tb(traffic_pattern, num_leaves, injection_rate, addr_width, payload_sz):
    
    num_leaves_power_of_two = 2**clog2(num_leaves)

    num_msg_file = "./data/bench/" + traffic_pattern + "/" + str(num_leaves) + "/num_msg.txt"
    num_msg_list = []
    with open(num_msg_file,"r") as file:
        for line in file:
            num_msg = int(line.strip())
            num_msg_list.append(num_msg)
    assert(len(num_msg_list) == num_leaves)

    avg_num_sent_per_leaf = sum(num_msg_list)//len(num_msg_list)
    if(injection_rate < 50):
        wait_time = 50 + round(20*avg_num_sent_per_leaf*90*2) # relax the conservative wait time
    else:
        wait_time = 50 + round(20*avg_num_sent_per_leaf*90*100/injection_rate)

    code_string = '\n'.join([
            'module test;',
            '',
            '\tparameter num_leaves= ' + str(num_leaves) + ';',
            '\tparameter payload_sz= ' + str(payload_sz) + ';',
            '\tparameter p_sz= 1 + ' + str(addr_width) + ' + payload_sz;',
            '',
            '\tinteger k;',
            '',
            '\tinitial begin',
            '\t\t$dumpfile("gen_nw.vcd");',
            '\t\t$dumpvars(0, gen_nw_test);',
            '\t\t$dumpvars(0, test);',
            '\t\t$dumpvars(0, gen_pe[0]);',
            '\t\tfor (k= 0; k < num_leaves; k= k + 1) begin',
            '\t\t\t$dumpvars(0, test.pe_interface_arr[k]);',
            '\t\t\t$dumpvars(0, test.interface_pe_arr[k]);',
            '\t\t\tend',
            '\t\t#' + str(wait_time), 
            '\t\t$finish;',
            '\tend',
            '',
            '\treg clk;',
            '\treg reset;',
            '\t',
            '\twire [num_leaves*p_sz-1:0] pe_interface;',
            '\twire [num_leaves*p_sz-1:0] interface_pe;',
            '\twire [p_sz-1:0] pe_interface_arr [num_leaves-1:0];',
            '\twire [p_sz-1:0] interface_pe_arr [num_leaves-1:0];',
            '\twire [num_leaves-1:0] resend;',
            '',
            '\tinteger i;',
            '\tinitial begin',
            '\t\t{clk, reset}= 2\'b01;',
            '\t\t#50',
            '\t\tfor (i= 0; i < 2^(100); i= i + 1) begin',
            '\t\t\tif (i == 1) reset <= 0;',
            '\t\t\tclk<= ~clk;',
            '\t\t\t#10;',
            '\t\tend',
            '\tend',
            '',
            '\tgen_nw #(',
            '\t\t.num_leaves(num_leaves),',
            '\t\t.payload_sz(payload_sz),',
            '\t\t.p_sz(p_sz),',
            '\t\t.addr(1\'b0),',
            '\t\t.level(0))',
            '\t\tgen_nw_test(',
            '\t\t\t.clk(clk),',
            '\t\t\t.reset(reset),',
            '\t\t\t.pe_interface(pe_interface),',
            '\t\t\t.interface_pe(interface_pe),',
            '\t\t\t.resend(resend));',
            '',
            '\tgenvar j;',
            '\tgenerate',
            '\tfor (j= 0; j < num_leaves; j=j+1) begin : gen_pe',
            '\t\tassign pe_interface[j*p_sz+:p_sz]= pe_interface_arr[j];',
            '\t\tassign interface_pe_arr[j]=  interface_pe[j*p_sz+:p_sz];',
            '\tend',
            '\tendgenerate',
            '',
            '' ])

    for i in range(num_leaves):
        num_sent_per_leaf = num_msg_list[i]
        code_tb = '\n'.join([
            '\tpacket_creator_' + str(i) + ' #(',
            '\t\t.num_leaves(num_leaves),',
            '\t\t.payload_sz(payload_sz),',
            '\t\t.addr(' + str(i) + '),',
            '\t\t.p_sz(p_sz))',
            '\t\tpc_' + str(i) + '(',
            '\t\t\t.clk(clk),',
            '\t\t\t.reset(reset),',
            '\t\t\t.bus_o(pe_interface_arr[' + str(i) + ']),', 
            '\t\t\t.resend(resend[' + str(i) + ']));',
            '',
            '' ])
        code_string = code_string + code_tb

    code_end = '\n'.join([
            '\tinitial $display("type\\tPE\\tpacket\\t\\ttime");',
            '\tgenvar m;',
            '\tgenerate',
            '\tfor(m= 0; m < num_leaves; m= m + 1) begin',
            '\t\talways @(posedge clk) begin',
            '\t\t\tif (pe_interface_arr[m][p_sz-1])',
            '\t\t\t\t$display("sent\\t%05d\\t%b\\t%0d", m, pe_interface_arr[m], $time);',
            '\t\t\tif (interface_pe_arr[m][p_sz-1])',
            '\t\t\t\t$display("rcvd\\t%05d\\t%b\\t%0d", m, interface_pe_arr[m], $time);',
            #'\t\t\tif (gen_nw_test.subtree_left.subtree_left.subtree_left.bus_o[p_sz-1] == 1)',
            #'\t\t\t\t$display("000_bus_o:\\t%05d\\t%b\\t%0d", m, gen_nw_test.subtree_left.subtree_left.subtree_left.bus_o, $time);',
            '\t\tend',
            '\tend',
            '\tendgenerate',
            'endmodule ',
            ''])
    code_string = code_string + code_end

    return code_string


def binary_output(width, data_in):
    char_out = ''
    for _ in range(0, width):
        if(data_in % 2):
            char_out += '1'
        else:
            char_out += '0'
        data_in = data_in >> 1
    return char_out[::-1]


# For now...
def get_local_subtree_lvl(num_leaves):
    if(num_leaves<32):
        return 2
    elif(num_leaves<512):
        return 3


# Create test pattern for Random traffic
def make_test_pattern(traffic_pattern, num_leaves, num_sent_per_leaf, addr_width, payload_width, injection_rate_slow):
    num_leaves_power_of_two = 2**clog2(num_leaves)
    data_width = payload_width - 11
    dummy_width = 11 - addr_width
    os.system("mkdir -p ./data/bench/" + traffic_pattern + "/" + str(num_leaves))

    # write .trace files
    for addr_src in range(num_leaves):
        file_name = "./data/bench/" + traffic_pattern + "/" + str(num_leaves) + "/autogen_" + str(addr_src) + ".trace"
        filedata = ""

        if(traffic_pattern == "test_9"):
            num_valid_leaves_sparse = num_leaves - num_leaves_power_of_two//2 
            valid_leaves_s2s3 = get_valid_leaves_s2s3(num_leaves, num_valid_leaves_sparse)

            # dense part, subtree_0 and subtree_1
            if(addr_src < int(num_leaves_power_of_two/2)):
                for data in range(0, num_sent_per_leaf):
                    addr_des = test_9(addr_src, num_leaves_power_of_two)
                    valid = "1"
                    packet = valid + binary_output(addr_width, addr_des) + binary_output(addr_width, addr_src) + \
                                     binary_output(dummy_width, 0) + binary_output(data_width, data)
                    filedata += packet + "\n"
            # sparse part, subtree_2 and subtree_3
            else:
                num_sent_per_leaf_slow = int(num_sent_per_leaf//(100/injection_rate_slow))
                for data in range(0, num_sent_per_leaf_slow):
                    if(addr_src in valid_leaves_s2s3): # send to subtree_0/1
                        addr_des = test_9(addr_src, num_leaves_power_of_two)
                        valid = "1"
                    else:
                        addr_des = addr_src
                        valid = "0"
                    packet = valid + binary_output(addr_width, addr_des) + binary_output(addr_width, addr_src) + \
                                     binary_output(dummy_width, 0) + binary_output(data_width, data)
                    filedata += packet + "\n"
        else:
            for data in range(0, num_sent_per_leaf):
                if traffic_pattern == "test_0": # RANDOM
                    addr_des = test_0(addr_src,num_leaves)
                    valid = "1"
                elif traffic_pattern == "test_3":
                    if(addr_src < num_leaves_power_of_two/2):
                        addr_des = test_3(addr_src, num_leaves_power_of_two)
                        valid = "1"
                    else:
                        addr_des = addr_src # invalid
                        valid = "0"
                elif traffic_pattern == "test_5": # LOCAL, within 2**level subtree
                    local_subtree_level = get_local_subtree_lvl(num_leaves)
                    addr_des = test_5(addr_src, local_subtree_level)
                    valid = "1"
                elif(traffic_pattern == 'test_7'): # RANDOM, 1/4 nodes in subtree_2,3 active
                    num_remaining_leaves = num_leaves - num_leaves_power_of_two/2
                    # only 1/4 active
                    valid_leaves_s2s3 = get_valid_leaves_s2s3(num_leaves, num_remaining_leaves//4) 
                    valid_leaves_all = list(range(0,num_leaves_power_of_two//2)) + valid_leaves_s2s3
                    if(addr_src in valid_leaves_all):
                        valid_leaves_all.remove(addr_src) # except self
                        addr_des = random.choice(valid_leaves_all)
                        valid = "1"
                    else:
                        addr_des = addr_src
                        valid = "0"

                packet = valid + binary_output(addr_width, addr_des) + binary_output(addr_width, addr_src) + \
                                 binary_output(dummy_width, 0) + binary_output(data_width, data)
                filedata += packet + "\n"

        with open(file_name,"w") as file:
            file.write(filedata)

    # write num_msg.txt
    data_lengths = ""
    for addr_src in range(num_leaves):
        file_name = "./data/bench/" + traffic_pattern + "/" + str(num_leaves) + "/autogen_" + str(addr_src) + ".trace"
        max_data = 2**data_width-1
        data = 0
        with open(file_name,"r") as file:
            for line in file:                
                val = line.strip()
                if(val.startswith('1')): # valid data
                    data += 1
        assert(data <= max_data) # if fails, change PACKET_SIZE
        data_lengths += str(data) + "\n"

    num_msg_file = "./data/bench/" + traffic_pattern + "/" + str(num_leaves) + "/num_msg.txt"
    with open(num_msg_file,"w") as file:
        file.write(data_lengths)


# It will return a list of valid leaves in subtree_2 and subtree_3
# that are the same distance away from each other, that
# is determined by the "num_valid_leaves_sparse"
def get_valid_leaves_s2s3(num_leaves, num_valid_leaves_sparse):
    num_leaves_power_of_two = 2**clog2(num_leaves)
    num_leaves_subtree_2 = num_leaves - num_leaves_power_of_two//2

    n = 2**clog2(num_valid_leaves_sparse)
    distance = num_leaves_subtree_2 // n
    valid_leaves_list = []
    idx_leaves = num_leaves_power_of_two//2
    while(len(valid_leaves_list) < num_valid_leaves_sparse):
        valid_leaves_list.append(idx_leaves)
        idx_leaves = idx_leaves + distance

    assert(len(valid_leaves_list) == num_valid_leaves_sparse)
    for idx_leaves in valid_leaves_list:
        assert(idx_leaves < num_leaves)
    return valid_leaves_list


# test_0: random
def test_0(addr_src, num_leaves):
    valid_leaves_des = list(range(0, num_leaves))
    valid_leaves_des.remove(addr_src) # except self
    return random.choice(valid_leaves_des)

# test_3: random, no node in subtree_2 and subtree_3
def test_3(addr_src, num_leaves_power_of_two):
    valid_leaves_des = list(range(0, num_leaves_power_of_two//2))
    valid_leaves_des.remove(addr_src) # except self
    return random.choice(valid_leaves_des)

# test_5: local, communicate within only in 2^level subtree
def test_5(addr_src, level):
    subtree_size = 2**level
    for i in range(addr_src+1, addr_src+subtree_size+1):
        if(i%subtree_size == 0):
            idx_end = i
    idx_start = idx_end-subtree_size

    valid_leaves_des = list(range(idx_start,idx_end)) # leaves in subtree
    valid_leaves_des.remove(addr_src) # except self
    # print(valid_leaves_des)
    return random.choice(valid_leaves_des)

# test_7: random, but 1/4 nodes in subtree_2/3 active

# test_9: random in subtree_0/1, and nodes in subtree_2/3 send to subtree_0/1 in low injection rate
# ok.. this function turns out to be the same as test_3
def test_9(addr_src, num_leaves_power_of_two):
    valid_leaves_des = list(range(0, num_leaves_power_of_two//2))
    if(addr_src in valid_leaves_des): # subtree_0/1 case
        valid_leaves_des.remove(addr_src) # except self
    return random.choice(valid_leaves_des)
