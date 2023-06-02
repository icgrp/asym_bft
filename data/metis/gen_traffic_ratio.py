import argparse, glob, json, os

BFT_N = 256

if __name__ == '__main__':
    benchmarks = [d for d in os.listdir("./") if not d.startswith("snap") and os.path.isdir(d)]
    #print(benchmarks)
    #print(len(benchmarks))
    for benchmark in benchmarks:

        count_0 = 0
        count_1 = 0
        count_2 = 0
        count_3 = 0

        results = ""
        for i in range(BFT_N):
            file_name = "./" + benchmark + "/" + str(BFT_N) + "/autogen_" + str(i) + ".trace"
            with open(file_name,"r") as file:
                for line in file:
                    addr_des = int(line.strip()[1:9],2)
                    if(addr_des < BFT_N/4):
                        count_0 = count_0 + 1
                    elif(BFT_N/4 <= addr_des and addr_des < BFT_N/2):
                        count_1 = count_1 + 1
                    elif(BFT_N/2 <= addr_des and addr_des < (BFT_N/4) * 3):
                        count_2 = count_2 + 1
                    else:
                        count_3 = count_3 + 1
        print(benchmark, end=",")
        print(str((count_0 + count_1)/(count_2+count_3)))
