#!/usr/bin/python3
import network_generator as ng
import testbench_generator as tg
import subprocess
import pdb
import argparse
from datetime import datetime
import os
from math import ceil, log


def clog2(num):
    return int(ceil(log(num, 2)))

def record_results(test_case, avg_latency, worst_latency, throughput, args):
    time = datetime.today().strftime('%Y-%m-%d-%H:%M:%S')
    network = args.network
    num_sent_per_leaf = args.num_sent_per_leaf
    injection_rate = args.injection_rate
    injection_rate_slow = args.injection_rate_slow

    out_file = open('results.txt', 'a+')
    out_file.write(time + '\n')
    out_file.write('network: ' + network + '\n')
    out_file.write('test case: ' + test_case + '\n')
    out_file.write('num_sent_per_leaf: ' + str(num_sent_per_leaf) + '\n')
    out_file.write('injection_rate: ' + str(injection_rate) + '\n')
    out_file.write('injection_rate_slow: ' + str(injection_rate_slow) + '\n')
    out_file.write('avg latency: ' + str(avg_latency) + '\n')
    out_file.write('worst_latency: ' + str(worst_latency) + '\n')
    out_file.write('throughput: ' + str(throughput) + '\n')
    out_file.write('----------------------------------------\n')
    out_file.close()

def gen_synth_file(num_leaves):
    out_file = open('gen_nw_vivado.v', 'w')
    in_file = open('gen_nw.v', 'r')
    for line in in_file:
        if line.startswith('module gen_nw'):
          out_file.write('module gen_nw' +str(num_leaves) + ' # (\n')
        else:
          out_file.write(line)
    in_file.close()
    in_file = open('./basic/basic.v', 'r')
    for line in in_file:
        out_file.write(line)
    in_file.close()
    out_file.close()

def make_clean():
    subprocess.call(['make', 'clean'])

def get_throughput(num_sent_per_leaf, args,
                         filename='simulation.log'):
    num_leaves = args.num_leaves
    traffic_pattern = args.traffic_pattern
    injection_rate_slow = args.injection_rate_slow
    num_sent_per_leaf_slow = int(num_sent_per_leaf//(100/injection_rate_slow))

    num_leaves_power_of_two = 2**clog2(num_leaves)
    num_leaves_sparse = num_leaves - num_leaves_power_of_two//2 # num_leaves of G2/G3


    found_start = False
    start_time = -1
    end_time = -1
    with open(filename, 'r') as f:
        for line in f:
            if(found_start == False):
                if(line.startswith('sent')):
                    data = line.split('\t')
                    start_time = int(data[3])
                    found_start = True
            if(line.startswith('rcvd')):
                data = line.split('\t')
                end_time = int(data[3])

    assert(start_time != -1 and end_time != -1)
    elapsed_cycles = (end_time - start_time) / 20
    # throughput = num_sent_per_leaf / elapsed_cycles
    if(traffic_pattern == "test_9"):
        num_pck_total = num_sent_per_leaf*num_leaves_power_of_two//2 + num_sent_per_leaf_slow*num_leaves_sparse
    else:
        num_pck_total = num_sent_per_leaf*num_leaves
    throughput = (num_pck_total / elapsed_cycles) / num_leaves # pkt/cyc/PE
    return throughput


def make_packet_creator(num_leaves, injection_rate, traffic_pattern, args):
    with open('gen_packet_creator.v', 'w') as pc:
        pc.write(tg.create_packet_creator(num_leaves, injection_rate, traffic_pattern, args.injection_rate_slow))

def make_testbench(num_leaves, injection_rate, num_sent_per_leaf, addr_width, payload_width, traffic_pattern, args):  
    if(args.traffic_pattern.startswith("test")): # Random synthetic test
        tg.make_test_pattern(traffic_pattern, num_leaves,  num_sent_per_leaf, addr_width, payload_width, args.injection_rate_slow)
    with open('gen_nw_tb.v', 'w') as tb:
        tb.write(tg.create_tb(traffic_pattern, num_leaves, injection_rate, addr_width, payload_width))

def make_network(num_leaves, p, payload_width, args):
    with open('gen_nw.v', 'w') as nw:
        nw.write(ng.create_leafless_network(num_leaves, p, payload_width, args))
def make_axi_pe(num_leaves, p, payload_width, args):
    with open('axi_pe.v', 'w') as ap:
        ap.write(ng.generate_axi_pe(num_leaves, p, payload_width, args))

def make_test(num_leaves, injection_rate, traffic_pattern, num_sent_per_leaf, addr_width, payload_width, args):
    make_testbench(num_leaves, injection_rate, num_sent_per_leaf, addr_width, payload_width, traffic_pattern, args)
    make_packet_creator(num_leaves, injection_rate, traffic_pattern, args)

def make_src_modules(num_leaves, p, payload_width, args):
    make_network(num_leaves, p, payload_width, args)
    make_axi_pe(num_leaves, p, payload_width, args)



# Messy glue logic between python and Makefile and iverilog...
def make_simulation_log(args):
    if(args.network is None): # Not hetero BFT test mode
        os.environ['TEST_MODE'] = "0"
    else:
        os.environ['TEST_MODE'] = "1"
    subprocess.call(['make', 'gen_nw.vcd'])

# fyi, this code is relatively dangerous if you put a non-file name for
# filename, e.g., if filename='a && rm -rf *'
def save_simulation_log(args):
    ntw = args.network
    tp = args.traffic_pattern
    irt = args.injection_rate
    irt_s = args.injection_rate_slow
    nspl = args.num_sent_per_leaf
    num_leaves = args.num_leaves

    if(tp == "test_9"):
        filename = './logs_' + str(num_leaves) + '/' + str(ntw) + '_' + str(tp) + '_' + str(irt) + '-' + str(irt_s) + '_' + str(nspl) + '.log'
    else:
        filename = './logs_' + str(num_leaves) + '/' + str(tp) + '_' + str(irt) + '_' + str(nspl) + '.log'        
    subprocess.call(['cp', 'simulation.log', filename])


# Parses filename simulation log and returns 2 dicts as a tuple:
# a sent_dict and a received_dict. 
# For both dicts, the key is the packet, and the value is the
# time the packet was sent
def parse_simulation_log(num_leaves, 
                         filename='simulation.log'):
    with open(filename, 'r') as f:
        sent_dict={} 
        received_dict={} 
        for i, line in enumerate(f):
            if i > 2:
                data= line.split('\t')

                if (data[0] == 'sent'):
                    packet = data[2]
                    time = data[3]
                        # start_index= 1 + ng.clog2(num_leaves)
                        # end_index= start_index + ng.clog2(num_leaves)
                        # src= int(data[2][start_index:end_index], 2)
                        # if int(data[1]) == src:
                        #     sent_dict[data[2]]= int(data[3])
                    sent_dict[packet]= int(data[3]) # data[3] is time
                elif data[0] == 'rcvd':
                    packet = data[2]
                    time = data[3]
                    dest= int(data[2][1:1+ng.clog2(num_leaves)], 2)
                    if int(data[1]) == dest:
                        received_dict[packet]= int(time)  # data[3] is time
        return sent_dict, received_dict


def verify_simulation(sent_dict, received_dict):
    total_num_hops= 0;
    bool_val = True
    lost_packets = []
    worst_latency = -1
    for sent_packet, send_time in sent_dict.items():
        # first verify that the packet exists in both dicts
        if sent_packet not in received_dict.keys():
            print("Not all packets sent were recieved")
            print('sent_packet: ' + sent_packet)
            # print('first-case: ' + sent_packet)
            # print('len(sent_dict): ' + str(len(sent_dict)))
            # print('len(recv_dict): ' + str(len(received_dict)))
            # return False
            bool_val = False
            lost_packets.append(sent_packet)
        # verify received came after sent
        elif received_dict[sent_packet] < send_time:
            print("packet received before it was sent!")
            print('sent_packet: ' + sent_packet)
            print('rcvd_time: ' + str(received_dict[sent_packet]))
            print('send_time: ' + str(send_time))
            # return False
            bool_val = False
        # verify valid packet
        elif sent_packet[0] != '1':
            print("non-valid packet")
            # return False
            bool_val = False
        else:
            latency = (received_dict[sent_packet] - send_time) / 20
            total_num_hops+= latency
            if(latency>worst_latency):
                worst_latency = latency

    print('num of sent packets: ' + str(len(sent_dict)))
    print('num of rcvd packets: ' + str(len(received_dict)))
    avg_latency = total_num_hops/len(sent_dict)
    # print('average latency: ' + str(avg_latency))
    assert(len(sent_dict) == len(received_dict))
    return bool_val, avg_latency, worst_latency

def get_throughput_trace(args, filename='simulation.log'):
    num_leaves = args.num_leaves
    traffic_pattern = args.traffic_pattern

    found_start = False
    start_time = -1
    end_time = -1
    with open(filename, 'r') as f:
        for line in f:
            if(found_start == False):
                if(line.startswith('sent')):
                    data = line.split('\t')
                    start_time = int(data[3])
                    found_start = True
            if(line.startswith('rcvd')):
                data = line.split('\t')
                end_time = int(data[3])

    assert(start_time != -1 and end_time != -1)
    elapsed_cycles = (end_time - start_time) / 20

    num_msg_file = "./data/bench/" + traffic_pattern + "/" + str(num_leaves) + "/num_msg.txt"
    num_total_msgs = 0
    with open(num_msg_file,"r") as file:
        for line in file:
            num_total_msgs += int(line.strip())

    throughput = (num_total_msgs / elapsed_cycles) / num_leaves # pkt/cyc/PE
    return throughput


def simulate_more(simulation_num, addr_width, payload_width, traffic_pattern, args):
    i = 0
    latency_sum = 0
    simulation_true = True
    while i<simulation_num:
        i += 1;
        if args.network is None:
            make_src_modules(num_leaves, p, payload_width, args)
        make_test(num_leaves, injection_rate, traffic_pattern, num_sent_per_leaf, addr_width, payload_width, args)
        make_simulation_log(args)
        sent_dict, received_dict= parse_simulation_log(num_leaves)
        # print(sent_dict)
        # print(received_dict)
        save_simulation_log(args)
        bool_val, avg_latency, worst_latency = verify_simulation(sent_dict, received_dict)

        if bool_val != True:
            print("Hoops! Something Wrong.")
            simulation_true = False
            break
        else:
            throughput = get_throughput_trace(args)
            print('-avg_latency(cycles): '+str(avg_latency))
            print('-worst_latency(cycles): '+str(worst_latency))
            print('-throughput(pkt/cycle/pe): '+str(throughput))
            print ('Success: '+str(i)+'!')
        print()
        # latency_sum += avg_latency

    if simulation_true:
        return avg_latency, worst_latency, throughput
    else:
        return False


#-------------------  USERSPACE BELOW ------------------------#

# network params
# num_leaves : BFT leaves
# p : Rent parameter

# testbench params
# injection_rate : as a percent (out of 100) 
# num_sent_per_leaf : how many total packets each pe will send 

# Packet composition
# {v_bit(1), dest_addr_bit(log2(num_leaves)), payload(port, fifo_addr, data)}
# In PRflow, port is 4 bits, fifo_addr is 7 bits, data is 32 bits
# Here, for testing purpose, {port,fifo_addr} are {src_addr,0's}

if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-flt', '--flatten', help="flatten the BFT in top module", action='store_true')
    parser.add_argument('-sg', '--src_gen', help="no verilog source generation", action='store_false') # default true
    parser.add_argument('-pp', '--pipeline', type=int, default=0, help="pipeline the network")
    parser.add_argument('-v', '--verbose', help="print parameters for debugging", action='store_true')
    parser.add_argument('-s', '--synth', help="generate synthesizable gen_nw_vivado.v", action='store_true') # default false
    parser.add_argument('-tp', '--traffic_pattern', type=str, default="complement", help="choose optimization type")
    # parser.add_argument('-oft', '--offset', type=int, default=5, help="the offset number for uniform")
    parser.add_argument('-irt', '--injection_rate', type=int, default=5, help="injectoin rate in percentage")
    parser.add_argument('-nspl', '--num_sent_per_leaf', type=int, default=30, help="num_sent_per_leaf")
    parser.add_argument('-pks', '--packet_size', type=int, default=52, help="the width for each package")
    #parser.add_argument('-pls', '--payload_size', type=int, default=43, help="the width for each payload")
    parser.add_argument('-nl', '--num_leaves', type=int, default=8, help="the leave number for the BFT")
    parser.add_argument('-p', '--p', type=float, default=0.5, help="the P parameter in rent law")
    parser.add_argument('-ntw', '--network', type=str, default=None, \
                                            help="network type, only used in hetero BFT test mode")
    parser.add_argument('-tr', '--tree_type', type=str, default='regular', \
                                            choices=["regular","pptt"], \
                                            help="ptpt(regular) or pptt, only applicable when p==0.5")
    parser.add_argument('-irt_s', '--injection_rate_slow', type=int, default=5)

    args = parser.parse_args()
    num_leaves = args.num_leaves
    p = args.p
    injection_rate= args.injection_rate
    num_sent_per_leaf= args.num_sent_per_leaf
    addr_width = ng.clog2(args.num_leaves)
    payload_width = args.packet_size - ng.clog2(args.num_leaves) - 1 # same as payload_sz
    traffic_pattern = args.traffic_pattern
    # traffic_params = {'pattern':args.traffic_pattern, 'offset':args.offset}

    print("===================================")
    print("network: ", args.network)
    print("traffic pattern: ", args.traffic_pattern)
    # print("num set per leaf: ", args.num_sent_per_leaf) # outdated
    print("injection rate: ", args.injection_rate)
    # print("args.packet_size: ", args.packet_size)
    # print("args.addr_width: ", addr_width)
    # print("args.synth: ", args.synth) # default false
    print("args.src_gen: ",args.src_gen) # default true, outdated
    # print(traffic_params)
    print("-----------------------------------")

    if args.synth:
        make_network(num_leaves, p, payload_width, args)
        gen_synth_file(num_leaves)
    else:
        avg_latency, worst_latency, throughput = simulate_more(1, addr_width, payload_width, traffic_pattern, args)

        if(args.network is not None):
            # assert(traffic_params['pattern'].startswith('test'))
            record_results(traffic_pattern, avg_latency, worst_latency, throughput, args)

#    make_clean()
