import argparse

def add_key(dict, key):
    if key not in dict:
        dict[key] = []

def what_separated(filename):
    with open(filename, "r") as file:
        lines = file.readlines()
        if(" " in lines[0]):
            return " "
        elif("\t" in lines[0]):
            return "\t"
        elif("," in lines[0]):
            return ","
        else:
            print("why here?")
            return None

def make_consecutive(filename, num_nodes):
    consecutive_dict = {}
    count = 1
    sep = what_separated(filename)
    # print(sep)
    with open(filename, "r") as file:
        for line in file:
            # IT COULD BE EITHER SPACE-SEPARATED OR TAB-SEPARATED!!!

            # nodes = line.strip().split(" ")
            nodes = line.strip().split(sep)
            if(nodes[0] not in consecutive_dict):
                consecutive_dict[nodes[0]] = count
                count = count+1
            if(nodes[1] not in consecutive_dict):
                consecutive_dict[nodes[1]] = count
                count = count+1
    # print(consecutive_dict)
    print("num_nodes: " + str(count-1))
    assert(num_nodes == count-1)
    return consecutive_dict
'''
Create final_dict
final_dict[node_0] = list of neighboring nodes of node_0
'''
def gen_graph_list(filename, num_edges, consecutive_dict):
    final_dict = {}
    count = 0
    sep = what_separated(filename)
    # print(sep)
    with open(filename, "r") as file:
        for line in file:
            nodes = line.strip().split(sep)
            # metis graphfile starts from idx==1
            # add_key(final_dict, int(nodes[0]) + 1) 
            # add_key(final_dict, int(nodes[1]) + 1)
            # final_dict[int(nodes[0]) + 1].append(int(nodes[1]) + 1)
            # final_dict[int(nodes[1]) + 1].append(int(nodes[0]) + 1)
            new_node_0 = consecutive_dict[nodes[0]]
            new_node_1 = consecutive_dict[nodes[1]]

            add_key(final_dict, new_node_0)
            add_key(final_dict, new_node_1) 
            final_dict[new_node_0].append(new_node_1)
            final_dict[new_node_1].append(new_node_0)

    # print(len(final_dict))
    count = 0
    for elem in final_dict.keys():
        count += len(final_dict[elem])
    print("num_edges: " + str(count//2)) # shuold print num_edges
    assert(num_edges == count//2)
    return final_dict


'''
Create graphfile based on final_dict
'''
def write_graphfile_metis(final_dict, graph_filename, num_nodes, num_edges):
    filedata = ""
    with open(graph_filename, "w") as file:
        filedata = str(num_nodes) + " " + str(num_edges) + "\n" # 1st line
        # for elem in graph_list:
        #     for idx, node_id in enumerate(elem):
        #         if(idx != len(elem)-1):
        #             filedata += str(node_id) + " "
        #         else:
        #             filedata += str(node_id) + "\n"

        for key in sorted(final_dict.keys()):
            # print(key)
            str_list = [str(elem) for elem in final_dict[key]]
            filedata += " ".join(str_list)
            filedata += "\n"
        file.write(filedata)

'''
Create graphfile from raw file from SNAP 
'''
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-f', '--filename', type=str, help="raw graph filename from SNAP")
    parser.add_argument('-gf', '--graph_filename', type=str, help="output graph filename for metis")
    parser.add_argument('-n', '--nodes', type=int, help="number of nodes")
    parser.add_argument('-e', '--edges', type=int, help="num of edges")

    args = parser.parse_args()
    filename = args.filename
    graph_filename = args.graph_filename
    num_nodes = args.nodes
    num_edges = args.edges

    consecutive_dict = make_consecutive(filename, num_nodes)
    final_dict = gen_graph_list(filename, num_edges, consecutive_dict)
    write_graphfile_metis(final_dict, graph_filename, num_nodes, num_edges)
