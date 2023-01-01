BENCHMARK_LIST = ["add20","amazon","bomhof_1","bomhof_2","bomhof_3","google","hamm","human","roadnet","simucad_dac","simucad_ram2k","soc","stanford","wiki"]

BFT_N = 256

for BENCHMARK in BENCHMARK_LIST:
    # print("Idx\tTotal\tDense\tSparse")
    count_dense_total = 0
    count_sparse_total = 0

    count_dense_0_total = 0
    count_dense_1_total = 0
    count_sparse_0_total = 0
    count_sparse_1_total = 0

    for i in range(BFT_N):
        file_name = "./" + BENCHMARK + "/" + str(BFT_N) + "/autogen_" + str(i) + ".trace"
        # print(file_name)
        count_dense = 0
        count_sparse = 0
        with open(file_name,"r") as file:
            for line in file:
                val = int(line.strip(),16)
                if(val < BFT_N/2):
                    count_dense = count_dense + 1
                elif(val < BFT_N):
                    count_sparse = count_sparse + 1
        # print(str(i) + "\t" + str(count_dense + count_sparse) + "\t" + str(count_dense) + "\t" + str(count_sparse))
        count_dense_total += count_dense
        count_sparse_total += count_sparse

        if(i < BFT_N/2):
            count_dense_0_total += count_dense
            count_sparse_0_total += count_sparse
        elif(i < BFT_N):
            count_dense_1_total += count_dense
            count_sparse_1_total += count_sparse

    # print()
    print(BENCHMARK)
    print("dense total: " + str(count_dense_total) + ", sparse total: " + str(count_sparse_total))
    print("0's dense total: " + str(count_dense_0_total) + ", 0's sparse total: " + str(count_sparse_0_total))
    print("1's dense total: " + str(count_dense_1_total) + ", 1's sparse total: " + str(count_sparse_1_total))
    print("-----------------------------------------")