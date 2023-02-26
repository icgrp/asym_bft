# with open ("musae_DE_edges_graphfile_cluster", "r") as read_f:
#     with open("musae_DE_edges.csv", "w") as write_f:
#         write_f.write("Source,Target,Weight\n")
#         src = 1
#         src_dict = {}
#         for line in read_f:
#             dst_list = line.split()
#             dst_list_set = set(dst_list)
#             for dst in dst_list_set:
#                 write_f.write(str(src) + "," + str(dst) + "," + str(dst_list.count(dst)) + "\n")
#             # print(dst_list)

#             src = src+1
# print("done")

# with open ("musae_ENGB_edges_graphfile_cluster", "r") as read_f:
#     with open("musae_ENGB_edges_graphfile_cluster.csv", "w") as write_f:
#         write_f.write("Source,Target,Weight\n")
#         src = 1
#         src_dict = {}
#         for line in read_f:
#             dst_list = line.split()
#             dst_list_set = set(dst_list)
#             for dst in dst_list_set:
#                 write_f.write(str(src) + "," + str(dst) + "," + str(dst_list.count(dst)) + "\n")
#             # print(dst_list)

#             src = src+1
# print("done")


# with open ("./cdeezer_europe_edges_graphfile_cluster", "r") as read_f:
#     with open("deezer_europe_edges.csv", "w") as write_f:
#         write_f.write("Source,Target,Weight\n")
#         src = 1
#         src_dict = {}
#         for line in read_f:
#             dst_list = line.split()
#             dst_list_set = set(dst_list)
#             for dst in dst_list_set:
#                 write_f.write(str(src) + "," + str(dst) + "," + str(dst_list.count(dst)) + "\n")
#             # print(dst_list)

#             src = src+1
# print("done")

# import networkx as nx
# G = nx.complete_graph(5)
# nx.draw(G)


import os
# file_list = os.listdir("./clustered_graphfile_dir")
file_list = ['facebook_ego_graphfile_test_cluster']

for f in file_list:
    csv_file = f.replace("_graphfile_cluster","") + ".csv"
    with open ("./clustered_graphfile_dir/" + f, "r") as read_f:
        with open("./csv_dir/"+csv_file, "w") as write_f:
            write_f.write("Source,Target,Weight\n")
            src = 1
            src_dict = {}
            lines = read_f.readlines()
            for line in lines[1:]:
                dst_list = line.split()
                dst_list_set = set(dst_list)
                for dst in dst_list_set:
                    write_f.write(str(src) + "," + str(dst) + "," + str(dst_list.count(dst)) + "\n")
                # print(dst_list)

                src = src+1
    print("done")

