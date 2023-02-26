import random
import numpy as np
import networkx as nx
import pandas as pd
import matplotlib.pyplot as plt
import os

random.seed(42)

pos_dict = {}
for src in range(1,257):
    if(src < 65):
        x = random.uniform(-0.5,0)
        y = random.uniform(-0.5,0)
    elif(65 <= src and src <129):
        x = random.uniform(-0.5,0)
        y = random.uniform(0,0.5)
    elif(129 <= src and src <193):
        x = random.uniform(0,0.5)
        y = random.uniform(0,0.5)
    else:
        x = random.uniform(0,0.5)
        y = random.uniform(-0.5,0)
    pos_dict[src] = np.array([x,y])


# for f in csv_file_list:
#     print(f)


# G = nx.Graph()
# got_data = pd.read_csv("./csv_dir/deezer_europe_edges.csv")

# sources = got_data['Source']
# targets = got_data['Target']
# weights = got_data['Weight']

# edge_data = zip(sources, targets, weights)
# for e in edge_data:
#                 src = e[0]
#                 dst = e[1]
#                 w = e[2]
#                 G.add_edge(src, dst, weight=w)

# w_delta = 2
# w_max = 100
# dict_elist = {}
# for x in range(0,w_max,w_delta):
#     elist = [(u, v) for (u, v, d) in G.edges(data=True) if x <= d["weight"] and d["weight"] < x+w_delta]
#     dict_elist[x] = elist

# elast = [(u, v) for (u, v, d) in G.edges(data=True) if d["weight"] >= w_max]
# dict_elist[w_max] = elast


# n_0 = [u for (u, v) in G.nodes(data=True) if u <65]
# n_1 = [u for (u, v) in G.nodes(data=True) if 65 <= u and u <129]
# n_2 = [u for (u, v) in G.nodes(data=True) if 129 <= u < 193]
# n_3 = [u for (u, v) in G.nodes(data=True) if 193 <= u]

# nx.draw_networkx_nodes(G, pos_dict, nodelist=n_0, node_size=5,node_color='red')
# nx.draw_networkx_nodes(G, pos_dict, nodelist=n_1, node_size=5,node_color='red')
# nx.draw_networkx_nodes(G, pos_dict, nodelist=n_2, node_size=5,node_color='green')
# nx.draw_networkx_nodes(G, pos_dict, nodelist=n_3, node_size=5,node_color='green')

# width = 0.01 # initiali width value
# width_delta = 0.01
# for x in range(0,w_max+w_delta,w_delta):
#     elist = dict_elist[x]
#     nx.draw_networkx_edges(G, pos_dict, edgelist=elist, width=width)
#     width = width + width_delta

# # plt.show()

# plt.axis('off')
# plt.savefig("./fig/deezer_europe_edges.png", format="png", dpi=600, bbox_inches='tight', pad_inches = 0)



G = nx.Graph()
got_data = pd.read_csv("./csv_dir/lastfm_asia_edges.csv")

sources = got_data['Source']
targets = got_data['Target']
weights = got_data['Weight']

edge_data = zip(sources, targets, weights)
for e in edge_data:
                src = e[0]
                dst = e[1]
                w = e[2]
                G.add_edge(src, dst, weight=w)

w_delta = 2
w_max = 100
dict_elist = {}
for x in range(0,w_max,w_delta):
    elist = [(u, v) for (u, v, d) in G.edges(data=True) if x <= d["weight"] and d["weight"] < x+w_delta]
    dict_elist[x] = elist

elast = [(u, v) for (u, v, d) in G.edges(data=True) if d["weight"] >= w_max]
dict_elist[w_max] = elast


n_0 = [u for (u, v) in G.nodes(data=True) if u <65]
n_1 = [u for (u, v) in G.nodes(data=True) if 65 <= u and u <129]
n_2 = [u for (u, v) in G.nodes(data=True) if 129 <= u < 193]
n_3 = [u for (u, v) in G.nodes(data=True) if 193 <= u]

nx.draw_networkx_nodes(G, pos_dict, nodelist=n_0, node_size=5,node_color='red')
nx.draw_networkx_nodes(G, pos_dict, nodelist=n_1, node_size=5,node_color='red')
nx.draw_networkx_nodes(G, pos_dict, nodelist=n_2, node_size=5,node_color='green')
nx.draw_networkx_nodes(G, pos_dict, nodelist=n_3, node_size=5,node_color='green')

width = 0.01 # initiali width value
width_delta = 0.01
for x in range(0,w_max+w_delta,w_delta):
    elist = dict_elist[x]
    nx.draw_networkx_edges(G, pos_dict, edgelist=elist, width=width)
    width = width + width_delta

# plt.show()

plt.axis('off')
plt.savefig("./fig/lastfm_asia_edges.png", format="png", dpi=600, bbox_inches='tight', pad_inches = 0)
