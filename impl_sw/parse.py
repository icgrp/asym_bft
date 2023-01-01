
clk_period_list = [1, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2, 2.1, 2.2, 2.3]
sw_list = ["t_switch", "t_switch_rand", "pi_switch"]

print("WNS-----")
for sw in sw_list:
    for clk_period in clk_period_list:
        timing_txt = "./report/t_" + sw + "_" + str(clk_period) + ".txt"
        with open(timing_txt, "r") as file:
            count = -1
            start = False
            WNS = 999
            for line in file:
                if line.strip().startswith("WNS(ns)"):
                    start = True
                    count = 0
                elif(start == True):
                    count += 1
                if(count == 2):
                    WNS = line.strip().split()[0]
                    break
        print(WNS, end = " ")
    print()

print("LUTs-----")
for sw in sw_list:
    for clk_period in clk_period_list:
        util_txt = "./report/ut_" + sw + "_" + str(clk_period) + ".txt"
        with open(util_txt, "r") as file:
            for line in file:
                if line.startswith("|   "  + sw + "_1"):
                    LUT = line.split("|")[3].strip()
                    FF = line.split("|")[7].strip()
        print(LUT, end = " ")
    print()

print("FFs-----")
for sw in sw_list:
    for clk_period in clk_period_list:
        util_txt = "./report/ut_" + sw + "_" + str(clk_period) + ".txt"
        with open(util_txt, "r") as file:
            for line in file:
                if line.startswith("|   "  + sw + "_1"):
                    LUT = line.split("|")[3].strip()
                    FF = line.split("|")[7].strip()
        print(FF, end = " ")
    print() 
#with open("./report/t_pi_switch_1.9.txt", "r") as file:
#rint(WNS)
'''
sw = "pi_switch"
with open("./report/ut_pi_switch_1.2.txt", "r") as file:
    for line in file:
        if line.startswith("|   "  + sw + "_1"):
            print(line.split("|")[3].strip())
'''
