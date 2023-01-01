def print_pretty(network_dict, test_case_list, injection_rate_list):
    print('##avg_latency')
    for test_case in test_case_list:
        print(test_case, end = ", ")
        if(test_case == 'test_9'):
            for network, data_list in network_dict.items(): # hom_0, ... , hetero_2 order
                print(network, end = ", ")
            print()
            for injection_rate_slow in injection_rate_list:
                print(injection_rate_slow, end = ", ")
                for network, data_list in network_dict.items(): # hom_0, ... , hetero_2 order
                    for data in data_list:
                        if(data['test_case'] == test_case and data['injection_rate_slow'] == injection_rate_slow):
                            assert(data['injection_rate'] == '100')
                            print(data['avg_latency'], end = ", ")
                print()
        else:
            for network, data_list in network_dict.items(): # hom_0, ... , hetero_2 order
                print(network, end = ", ")
            print()
            for injection_rate in injection_rate_list:
                print(injection_rate, end = ", ")
                for network, data_list in network_dict.items(): # hom_0, ... , hetero_2 order
                    for data in data_list:
                        if(data['test_case'] == test_case and data['injection_rate'] == injection_rate):
                            print(data['avg_latency'], end = ", ")
                print()
    print()
    print('##worst_latency')
    for test_case in test_case_list:
        print(test_case, end = ", ")
        if(test_case == 'test_9'):
            for network, data_list in network_dict.items(): # hom_0, ... , hetero_2 order
                print(network, end = ", ")
            print()
            for injection_rate_slow in injection_rate_list:
                print(injection_rate_slow, end = ", ")
                for network, data_list in network_dict.items(): # hom_0, ... , hetero_2 order
                    for data in data_list:
                        if(data['test_case'] == test_case and data['injection_rate_slow'] == injection_rate_slow):
                            assert(data['injection_rate'] == '100')
                            print(data['worst_latency'], end = ", ")
                print()
        else:
            for network, data_list in network_dict.items(): # hom_0, ... , hetero_2 order
                print(network, end = ", ")
            print()
            for injection_rate in injection_rate_list:
                print(injection_rate, end = ", ")
                for network, data_list in network_dict.items(): # hom_0, ... , hetero_2 order
                    for data in data_list:
                        if(data['test_case'] == test_case and data['injection_rate'] == injection_rate):
                            print(data['worst_latency'], end = ", ")
                print()
    print()
    print('##throughput')
    for test_case in test_case_list:
        print(test_case, end = ", ")
        if(test_case == 'test_9'):
            for network, data_list in network_dict.items(): # hom_0, ... , hetero_2 order
                print(network, end = ", ")
            print()
            for injection_rate_slow in injection_rate_list:
                print(injection_rate_slow, end = ", ")
                for network, data_list in network_dict.items(): # hom_0, ... , hetero_2 order
                    for data in data_list:
                        if(data['test_case'] == test_case and data['injection_rate_slow'] == injection_rate_slow):
                            assert(data['injection_rate'] == '100')
                            print(data['throughput'], end = ", ")
                print()
        else:
            for network, data_list in network_dict.items(): # hom_0, ... , hetero_2 order
                print(network, end = ", ")
            print()
            for injection_rate in injection_rate_list:
                print(injection_rate, end = ", ")
                for network, data_list in network_dict.items(): # hom_0, ... , hetero_2 order
                    for data in data_list:
                        if(data['test_case'] == test_case and data['injection_rate'] == injection_rate):
                            print(data['throughput'], end = ", ")
                print()



if __name__ == '__main__':
    # hom_0_list = []
    # hom_1_list = []
    # hetero_0_list = []
    # hetero_1_list = []
    # hetero_2_list = []
    # network_dict = {'hom_0': [], 'hom_1': [], 'hom_3': [], 'hetero_1': [], 'hetero_1_1': []}
    network_dict = {'s0': [], 's1': [], 's2': [], 'as0': []}

    test_case_list = ['test_0','test_3','test_5','test_7','test_9']
    # test_case_list = ['test_9']
    injection_rate_list = ['1','3','5','7','10','20','30','50','100']
    data = {'network':None, 'test_case':None, 'injection_rate':None, 'injection_rate_slow':None, \
            'avg_latency':None, 'worst_latency':None, 'throughput':None}
    with open('results.txt', 'r') as in_file:
        for line in in_file:
            if(line.startswith('network: ')):
                network = line.split('network: ')[1].strip()
            elif(line.startswith('test case: ')):
                test_case = line.split('test case: ')[1].strip()
            elif(line.startswith('injection_rate: ')):
                injection_rate = line.split('injection_rate: ')[1].strip()
            elif(line.startswith('injection_rate_slow: ')):
                injection_rate_slow = line.split('injection_rate_slow: ')[1].strip()
            elif(line.startswith('avg latency: ')):
                avg_latency = line.split('avg latency: ')[1].strip()
            elif(line.startswith('worst_latency: ')):
                worst_latency = line.split('worst_latency: ')[1].strip()
            elif(line.startswith('throughput: ')):
                throughput = line.split('throughput: ')[1].strip()
            # elif(line.startswith('202')):
            #     assert(line.startswith('2023') or line.startswith('2022-12-31'))
            elif(line.startswith('--')): # finish line
                data['network'] = network 
                data['test_case'] = test_case
                data['injection_rate'] = injection_rate
                data['injection_rate_slow'] = injection_rate_slow
                data['avg_latency'] = avg_latency 
                data['worst_latency'] = worst_latency 
                data['throughput'] = throughput 
                # print(data)
                network_dict[network].append(data)
                # add_to_dict(hom_0_list, hom_1_list, hetero_0_list, hetero_1_list, hetero_2_list, data)
                data = {'network':None, 'test_case':None, 'injection_rate':None, 'injection_rate_slow':None, \
                        'avg_latency':None, 'worst_latency':None, 'throughput':None}


    # print(het_t_rand_list)
    # print(network_dict)
    print_pretty(network_dict, test_case_list, injection_rate_list)
