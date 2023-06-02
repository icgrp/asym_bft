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
data_width = 16
dummy_width = 32 - 1 - addr_width - data_width

'''
Create trace file for simulation 
'''
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-n', '--benchmark_name', type=str, help="benchmark name, output dir name")
    parser.add_argument('-r', '--reverse', help="swap top bottom", action='store_true') # default False
    parser.add_argument('-r_12', '--reverse_12', help="swap quad1 and quad2", action='store_true') # default False

    args = parser.parse_args()

    benchmark_name = args.benchmark_name
    is_reverse = args.reverse
    is_reverse_12 = args.reverse_12
    max_data = 2**data_width-1

    # with open(clustered_graph_filename, "r") as file:
    #     lines = file.readlines()
    # lines = lines[1:] # remove 1st line

    if(is_reverse):
        benchmark_name = benchmark_name + "_rev" + "/" + str(BFT_N)
    elif(is_reverse_12):
        benchmark_name = benchmark_name + "_rev_12" + "/" + str(BFT_N)

    os.system("mkdir -p " + benchmark_name)
    for i in range(BFT_N):
        with open("./" + args.benchmark_name + "/" + str(BFT_N) + "/autogen_" + str(i) + ".trace","r") as infile:
            lines = infile.readlines()
        addr_des_list = [int(line.strip()[1:1+addr_width],2) for line in lines]
        data = 0
        filedata = ""
        if(is_reverse):
            # print(benchmark_name)
            with open("./" + benchmark_name + "/autogen_" + str(BFT_N-1-i) + ".trace","w") as file:
                for addr_des in addr_des_list:
                    addr_des = int(addr_des)
                    # addr_des = addr_des-1
                    addr_des = BFT_N-1-int(addr_des)
                    packet = "1" + binary_output(addr_width, addr_des)\
                                 + binary_output(dummy_width, 0) + binary_output(data_width, data)
                    filedata += packet + "\n"
                    data += 1
                assert(data <= max_data) # if fails, change PACKET_SIZE
                file.write(filedata)
        elif(is_reverse_12):
            if i < BFT_N/2:
                with open("./" + benchmark_name + "/autogen_" + str(BFT_N//2-1-i) + ".trace","w") as file:
                    for addr_des in addr_des_list:
                        addr_des = int(addr_des)
                        # addr_des = addr_des-1
                        if addr_des < BFT_N/2:
                            addr_des = BFT_N//2-1-int(addr_des)
                        packet = "1" + binary_output(addr_width, addr_des)\
                                     + binary_output(dummy_width, 0) + binary_output(data_width, data)
                        filedata += packet + "\n"
                        data += 1
                    assert(data <= max_data) # if fails, change PACKET_SIZE
                    file.write(filedata)
            else:
                with open("./" + benchmark_name + "/autogen_" + str(i) + ".trace","w") as file:
                    for addr_des in addr_des_list:
                        addr_des = int(addr_des)
                        # addr_des = addr_des-1
                        if addr_des < BFT_N/2:
                            addr_des = BFT_N//2-1-int(addr_des)
                        addr_src = i
                        packet = "1" + binary_output(addr_width, addr_des)\
                                     + binary_output(dummy_width, 0) + binary_output(data_width, data)
                        filedata += packet + "\n"
                        data += 1
                    assert(data <= max_data) # if fails, change PACKET_SIZE
                    file.write(filedata)
        else:
            with open("./" + benchmark_name + "/autogen_" + str(i) + ".trace","w") as file:
                for addr_des in addr_des_list:
                    addr_des = int(addr_des)
                    # addr_des = addr_des-1
                    addr_src = i
                    # packet = "1" + binary_output(addr_width, addr_des) + binary_output(addr_width, addr_src) + binary_output(data_width, data)
                    # packet = "1" + binary_output(addr_width, addr_des) + binary_output(addr_width, addr_src) \
                    #              + binary_output(dummy_width, 0) + binary_output(data_width, data)
                    packet = "1" + binary_output(addr_width, addr_des)\
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