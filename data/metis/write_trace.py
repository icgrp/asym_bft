from math import ceil, log
import os
import argparse

def clog2(num):
    return int(ceil(log(num, 2)))

def binary_output(width, data_in):
    char_out = ''
    for _ in range(0, width):
        if(data_in % 2):
            char_out += '1'
        else:
            char_out += '0'
        data_in = data_in >> 1
    return char_out[::-1]


BFT_N = 256
PACKET_SIZE = 32
addr_width = clog2(BFT_N)
data_width = 32
dummy_width = 11 - addr_width

'''
Create trace file for simulation 
'''
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-n', '--benchmark_name', type=str, help="benchmark name, output dir name")
    parser.add_argument('-gf', '--graph_filename', type=str, help="graphfile after 256-clustering")
    parser.add_argument('-r', '--reverse', help="addr reverse", action='store_true') # default False
    args = parser.parse_args()

    clustered_graph_filename = args.graph_filename
    benchmark_name = args.benchmark_name
    is_reverse = args.reverse
    max_data = 2**data_width-1

    with open(clustered_graph_filename, "r") as file:
        lines = file.readlines()
    lines = lines[1:] # remove 1st line

    if(is_reverse):
        benchmark_name = benchmark_name + "_rev" + "/" + str(BFT_N)
    else:
        benchmark_name = benchmark_name + "/" + str(BFT_N)
    os.system("mkdir -p " + benchmark_name)
    for i in range(BFT_N):
        addr_des_list = lines[i].strip().split()
        data = 0
        filedata = ""
        if(is_reverse):
            with open("./" + benchmark_name + "/autogen_" + str(BFT_N-1-i) + ".trace","w") as file:
                for addr_des in addr_des_list:
                    addr_des = BFT_N-1-int(addr_des)
                    addr_src = BFT_N-1-i
                    # packet = "1" + binary_output(addr_width, addr_des) + binary_output(addr_width, addr_src) + binary_output(data_width, data)
                    packet = "1" + binary_output(addr_width, addr_des) + binary_output(addr_width, addr_src) \
                                 + binary_output(dummy_width, 0) + binary_output(data_width, data)
                    filedata += packet + "\n"
                    data += 1
                assert(data <= max_data) # if fails, change PACKET_SIZE
                file.write(filedata)
        else:
            with open("./" + benchmark_name + "/autogen_" + str(i) + ".trace","w") as file:
                for addr_des in addr_des_list:
                    addr_des = int(addr_des)
                    addr_src = i
                    # packet = "1" + binary_output(addr_width, addr_des) + binary_output(addr_width, addr_src) + binary_output(data_width, data)
                    packet = "1" + binary_output(addr_width, addr_des) + binary_output(addr_width, addr_src) \
                                 + binary_output(dummy_width, 0) + binary_output(data_width, data)
                    filedata += packet + "\n"
                    data += 1
                assert(data <= max_data) # if fails, change PACKET_SIZE
                file.write(filedata)

    # Write num_msg.txt
    filedata = ""
    for i in range(BFT_N):
        file_name = benchmark_name + "/autogen_" + str(i) + ".trace"
        max_data = 2**data_width-1
        data = 0
        with open(file_name,"r") as file:
            for line in file:                
                val = line.strip()
                if(val.startswith('1')): # valid data
                    data += 1
        filedata += str(data) + "\n"

    num_msg_file = benchmark_name + "/num_msg.txt"
    with open(num_msg_file,"w") as file:
        file.write(filedata)