import argparse

# Returns get_clustered_id, which is ... clustered_node_id = get_clustered_id[old_node_id]
# e.g. 1 <= clustered_node_id <= 256
#      1 <= old_node_id <= 4039
def gen_get_clustered_id_list(graph_filename):
    get_clustered_id = ["dummy"]
    with open (graph_filename+".part.256", "r") as file:
        for line in file:
            clustered_node_id = int(line.strip()) + 1 # idx starts from 1
            get_clustered_id.append(clustered_node_id)
    # print(get_clustered_id)
    print("step_1 done")
    return get_clustered_id


def add_key(dict, key):
    if key not in dict:
        dict[key] = []


def gen_clustered_graphfile(graph_filename, get_clustered_id):
    cluster_dict = {}
    with open (graph_filename, "r") as file:
        i_dst = 1
        lines = file.readlines()
        for old_node_id, line in enumerate(lines[1:]): # skip 1st line (nodes, edges)
            old_node_id = old_node_id + 1 # metis output starts from 0... so
            clustered_list = [get_clustered_id[int(elem)] for elem in line.strip().split()]
            cluster_id = get_clustered_id[old_node_id]
            add_key(cluster_dict, cluster_id)
            # cluster_dict[cluster_id] += clustered_list
            # Don't include itself because it could cause too much local traffic...
            cluster_dict[cluster_id] += [elem for elem in clustered_list if elem != cluster_id] 

    print("step2-1 done")
    # for key in sorted(cluster_dict.keys()):
    #     clustered_list = cluster_dict[key]
    #     # clustered_list = list(set(clustered_list))
    #     # if key in clustered_list:
    #     #     clustered_list.remove(key)
    #     cluster_dict[key] = clustered_list

    # print(cluster_dict)
    # print(len(cluster_dict.keys()))
    assert(len(cluster_dict.keys()) == 256)

    num_edges = 0
    for key in sorted(cluster_dict.keys()):
        num_edges += len(cluster_dict[key])
    print(num_edges/2)
    num_edges = int(num_edges/2)

    with open (graph_filename + "_cluster", "w") as file:
        file.write("256 " + str(num_edges) + "\n")
        for i in range(1,257):
            str_list = [str(elem) for elem in cluster_dict[i]] 
            filedata = " ".join(str_list) + "\n"
            file.write(filedata)
    print("step2-2 done")

'''
Create clustered(256 nodes) graphfile from metis's output 
'''
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-gf', '--graph_filename', type=str, help="graph filename")

    args = parser.parse_args()
    graph_filename = args.graph_filename

    get_clustered_id = gen_get_clustered_id_list(graph_filename)
    gen_clustered_graphfile(graph_filename, get_clustered_id)
    # test(graph_filename)
