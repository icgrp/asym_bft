import gen_asym_bft as ng

def run_scripts() :
    f = open("tree_pattern.txt", "r")
    cnt = 0
    for line in f:
        if cnt % 2 :
            filename = "256leaves/gen_nw_as"+str(int(cnt//2))+".v"
            ng.build_bft_asym(line, filename)
        cnt += 1
    f.close()

if __name__ == '__main__':
    run_scripts()