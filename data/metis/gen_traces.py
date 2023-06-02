import argparse, glob, json, os

BFT_N = 256

if __name__ == '__main__':

    graph_node_data = {"Brightkite_edges": (58228, 428156),
                       "CA-AstroPh": (18772, 396160),
                       "CA-CondMat": (23133, 186936),
                       "CA-GrQc": (5242, 28980),
                       "CA-HepPh": (12008, 237010),
                       "CA-HepTh": (9877, 51971),
                       "deezer_europe_edges": (28281, 92752),
                       "Email-Enron": (36692, 367662),
                       "facebook_ego_raw": (4039, 88234),
                       "fb-athletes_edges": (13866, 86858),
                       "fb-company_edges": (14113, 52310),
                       "fb-government_edges": (7057, 89455),
                       "fb-new_sites_edges": (27917, 206259),
                       "fb-politician_edges": (5908, 41729),
                       "fb-public_figure_edges": (11565, 67114),
                       "fb-tvshow_edges": (3892, 17262),
                       "HR_edges": (54573, 498202),
                       "HU_edges": (47538, 222887),
                       "lastfm_asia_edges": (7624, 27806),
                       "musae_DE_edges": (9498, 153138),
                       "musae_ENGB_edges": (7126, 35324),
                       "musae_ES_edges": (4648, 59382),
                       "musae_facebook_edges": (22470, 171002),
                       "musae_FR_edges": (6549, 112666),
                       "musae_git_edges": (37700, 289003),
                       "musae_PTBR_edges": (1912, 31299),
                       "musae_RU_edges": (4385, 37304),
                       "RO_edges": (41773, 125826)
                       }

    os.system('rm results.txt') 

    for benchmark in graph_node_data:
        print(benchmark)
        (node,edge) = graph_node_data[benchmark]
        os.system('python preprocess_snap.py -f "./snap/' + benchmark + '.txt" -gf "./snap/' +\
                     benchmark + '_graphfile" -n ' + str(node) + ' -e ' + str(edge))
        os.system('gpmetis -ptype=rb ./snap/' + benchmark + '_graphfile ' + str(BFT_N))
        os.system('python cluster_256.py -gf "./snap/' + benchmark + '_graphfile"')
        os.system('python write_trace.py -n "' + benchmark + '" -gf "./snap/' + benchmark + '_graphfile_cluster"')

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
        new_result = benchmark + "\n" +\
                     "top: " + str(count_0 + count_1) + "\n" +\
                     "bot: " + str(count_2 + count_3) + "\n" +\
                     "count_0: " + str(count_0) + "\n" +\
                     "count_1: " + str(count_1) + "\n" +\
                     "count_2: " + str(count_2) + "\n" +\
                     "count_3: " + str(count_3) + "\n" +\
                     "avg: " + str((count_0 + count_1 + count_2 + count_3) / BFT_N) + "\n" +\
                     "-------------------------------------\n"
        results = results + new_result
        with open("results.txt", "a") as outfile:
            outfile.write(results)


        reverse_cond_0 = (count_0 + count_1 < count_2 + count_3) and (count_3 > count_2) # just reverse
        reverse_cond_1 = (count_0 + count_1 < count_2 + count_3) and (count_3 <= count_2) # reverse and then, reverse quad 1,2
        reverse_cond_2 = (count_0 + count_1 >= count_2 + count_3) and (count_1 > count_0) # reverse quad 1,2
        # reverse
        if reverse_cond_0:
            os.system('python reverse_trace.py -n "' + benchmark + '" -r') 
        elif reverse_cond_1:
            os.system('python reverse_trace.py -n "' + benchmark + '" -r') 
            os.system('python reverse_trace.py -n "' + benchmark + '_rev" -r_12')
        elif reverse_cond_2:
            os.system('python reverse_trace.py -n "' + benchmark + '" -r_12') 


        if reverse_cond_0 or reverse_cond_1 or reverse_cond_2:
            count_0 = 0
            count_1 = 0
            count_2 = 0
            count_3 = 0

            if reverse_cond_0:
                benchmark = benchmark + "_rev"
            if reverse_cond_1:
                benchmark = benchmark + "_rev_rev_12"
            elif reverse_cond_2:
                benchmark = benchmark + "_rev_12"

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
            new_result = benchmark + "\n" +\
                         "top: " + str(count_0 + count_1) + "\n" +\
                         "bot: " + str(count_2 + count_3) + "\n" +\
                         "count_0: " + str(count_0) + "\n" +\
                         "count_1: " + str(count_1) + "\n" +\
                         "count_2: " + str(count_2) + "\n" +\
                         "count_3: " + str(count_3) + "\n" +\
                         "avg: " + str((count_0 + count_1 + count_2 + count_3) / BFT_N) + "\n" +\
                         "-------------------------------------\n"
            results = results + new_result
            with open("results.txt", "a") as outfile:
                outfile.write(results)
