import json
import math
from math import ceil, log

def clog2(num):
    return int(ceil(log(num, 2)))

def build_bft_asym(pattern, filename="gen_nw.v") :
    # pattern = '["pi,pi,pi,pi,pi,pi","pi,pi,t,t,pi,pi","t,pi,t,pi,t,pi,t"]'

    if pattern == '':
        return ''
    load = json.loads(pattern)
    type1 = load[0]
    type2 = load[1]
    type3 = load[2] 

    type1Pattern = type1.split(',')
    type2Pattern = type2.split(',')
    type3Pattern = type3.split(',')

    t1_t_num = 0
    t1_pi_num = 0
    t2_t_num = 0
    t2_pi_num = 0
    t3_t_num = 0
    t3_pi_num = 0

    for type in type1Pattern :
        if type == 't' :
            t1_t_num += 1
        elif type == 'pi' :
            t1_pi_num += 1

    t1_num_switch = 2**t1_pi_num

    for type in type2Pattern :
        if type == 't' :
            t2_t_num += 1
        elif type == 'pi' :
            t2_pi_num += 1

    t2_num_switch = 2**t2_pi_num

    for type in type3Pattern :
        if type == 't' :
            t3_t_num += 1
        elif type == 'pi' :
            t3_pi_num += 1

    t3_num_switch = 2**t3_pi_num

    text_out = build_level0(type3)
    type3_6 = type3Pattern.pop()
    text_out += build_level1(type1Pattern, type2Pattern, type3Pattern, type3_6)
    text_out += build_leveln(type1Pattern, type2Pattern, type3Pattern)
    text_out += build_level8()
    text_out += hetero_sw(t1_num_switch, t2_num_switch, t3_num_switch)
    text_out += build_end()

    f = open(filename, "w")
    f.write(text_out)
    f.close()

def build_level0(type3) :
    type3Pattern = type3.split(',')
    t_num = 0
    pi_num = 0

    for type in type3Pattern :
        if type == 't' :
            t_num += 1
        elif type == 'pi' :
            pi_num += 1

    num_switch = 2**pi_num
    
    return '\n'.join([
        '//--------level=0--------------',
        'module  gen_nw # (',
        '\tparameter num_leaves= 256,',
        '\tparameter payload_sz= 23,',
        '\tparameter p_sz= 1 + $clog2(num_leaves) + payload_sz, //packet size',
        '\tparameter addr= 0,',
        '\tparameter level= 0',
        '\t) (',
        '\tinput clk,',
        '\tinput reset,',
        '\tinput [p_sz*256-1:0] pe_interface,',
        '\toutput [p_sz*256-1:0] interface_pe,',
        '\toutput [256-1:0] resend',
        '\t);',
        '\twire [p_sz*'+str(num_switch)+'-1:0] left_switch_0_0;',
        '\twire [p_sz*'+str(num_switch)+'-1:0] right_switch_0_0;',
        '\twire [p_sz*'+str(num_switch)+'-1:0] switch_left_0_0;',
        '\twire [p_sz*'+str(num_switch)+'-1:0] switch_right_0_0;',
        '\tt_cluster #(',
        '\t\t.num_leaves(num_leaves),',
        '\t\t.payload_sz(payload_sz),',
        '\t\t.addr(addr),',
        '\t\t.level(level),',
        '\t\t.p_sz(p_sz),',
        '\t\t.num_switches('+str(num_switch)+'))',
        '\t\tt_lvl0(',
        '\t\t.clk(clk),',
        '\t\t.reset(reset),', 
        '\t\t.l_bus_i(left_switch_0_0),',
        '\t\t.r_bus_i(right_switch_0_0),',
        '\t\t.l_bus_o(switch_left_0_0),',
        '\t\t.r_bus_o(switch_right_0_0));\n'
    ])

def t_cluster(addr, level, num_switch, u0, u1, lr0, lr1) :
    u_bus = ''
    if addr % 2 : 
        u_bus = 'right'
    else :
        u_bus = 'left'

    return '\n'.join([
        '\tt_cluster #(',
        '\t\t.num_leaves(num_leaves),',
        '\t\t.payload_sz(payload_sz),',
        '\t\t.addr('+str(addr)+'),',
        '\t\t.level('+str(level)+'),',
        '\t\t.p_sz(p_sz),',
        '\t\t.num_switches('+str(num_switch)+')',
        '\t\t)t_lvl_'+str(lr0)+'_'+str(lr1)+'(',
        '\t\t.clk(clk),',
        '\t\t.reset(reset),', 
        '\t\t.u_bus_o('+u_bus+'_switch_'+str(u0)+'_'+str(u1)+'),',
        '\t\t.u_bus_i(switch_'+u_bus+'_'+str(u0)+'_'+str(u1)+'),',
        '\t\t.l_bus_i(left_switch_'+str(lr0)+'_'+str(lr1)+'),',
        '\t\t.r_bus_i(right_switch_'+str(lr0)+'_'+str(lr1)+'),',
        '\t\t.l_bus_o(switch_left_'+str(lr0)+'_'+str(lr1)+'),',
        '\t\t.r_bus_o(switch_right_'+str(lr0)+'_'+str(lr1)+'));\n\n'
    ])

def pi_cluster(addr, level, num_switch, u0, u1, lr0, lr1) :
    u_bus = ''
    if addr % 2 : 
        u_bus = 'right'
    else :
        u_bus = 'left'

    return '\n'.join([
        '\tpi_cluster #(',
        '\t\t.num_leaves(num_leaves),',
        '\t\t.payload_sz(payload_sz),',
        '\t\t.addr('+str(addr)+'),',
        '\t\t.level('+str(level)+'),',
        '\t\t.p_sz(p_sz),',
        '\t\t.num_switches('+str(num_switch)+')',
        '\t\t)pi_lvl_'+str(lr0)+'_'+str(lr1)+'(',
        '\t\t.clk(clk),',
        '\t\t.reset(reset),', 
        '\t\t.u_bus_o('+u_bus+'_switch_'+str(u0)+'_'+str(u1)+'),',
        '\t\t.u_bus_i(switch_'+u_bus+'_'+str(u0)+'_'+str(u1)+'),',
        '\t\t.l_bus_i(left_switch_'+str(lr0)+'_'+str(lr1)+'),',
        '\t\t.r_bus_i(right_switch_'+str(lr0)+'_'+str(lr1)+'),',
        '\t\t.l_bus_o(switch_left_'+str(lr0)+'_'+str(lr1)+'),',
        '\t\t.r_bus_o(switch_right_'+str(lr0)+'_'+str(lr1)+'));\n\n'
    ])

def build_level1(type1Pattern, type2Pattern, type3Pattern, type3_6) :
    t1_t_num = 0
    t1_pi_num = 0
    t2_t_num = 0
    t2_pi_num = 0
    t3_t_num = 0
    t3_pi_num = 0

    for type in type1Pattern :
        if type == 't' :
            t1_t_num += 1
        elif type == 'pi' :
            t1_pi_num += 1

    t1_num_switch = 2**t1_pi_num

    for type in type2Pattern :
        if type == 't' :
            t2_t_num += 1
        elif type == 'pi' :
            t2_pi_num += 1

    t2_num_switch = 2**t2_pi_num

    for type in type3Pattern :
        if type == 't' :
            t3_t_num += 1
        elif type == 'pi' :
            t3_pi_num += 1

    t3_num_switch = 2**t3_pi_num

    cluster_type = t_cluster(1, 1, t3_num_switch, 0, 0, 1, 1)

    factor = 1

    if type3_6 == 'pi' :
        cluster_type = pi_cluster(1, 1, t3_num_switch, 0, 0, 1, 1)
        factor = 2

    return '\n'.join([
        '//--------level=1--------------',
        '\twire [p_sz*'+str(t1_num_switch)+'-1:0] left_switch_1_0;',
        '\twire [p_sz*'+str(t2_num_switch)+'-1:0] right_switch_1_0;',
        '\twire [p_sz*'+str(t1_num_switch)+'-1:0] switch_left_1_0;',
        '\twire [p_sz*'+str(t2_num_switch)+'-1:0] switch_right_1_0;',
        '\t',
        '\twire [p_sz*'+str(t3_num_switch)+'-1:0] left_switch_1_1;',
        '\twire [p_sz*'+str(t3_num_switch)+'-1:0] right_switch_1_1;',
        '\twire [p_sz*'+str(t3_num_switch)+'-1:0] switch_left_1_1;',
        '\twire [p_sz*'+str(t3_num_switch)+'-1:0] switch_right_1_1;',
        '\t',
        '\thetero_sw_'+str(t1_num_switch)+str(t2_num_switch)+str(t3_num_switch*factor)+' #(',
        '\t\t.num_leaves(num_leaves),',
        '\t\t.payload_sz(payload_sz),',
        '\t\t.addr(0),',
        '\t\t.level(1),',
        '\t\t.p_sz(p_sz)',
        '\t\t)hetero_sw_'+str(t1_num_switch)+str(t2_num_switch)+str(t3_num_switch)+'_lvl_1_0(',
        '\t\t.clk(clk),',
        '\t\t.reset(reset),',
        '\t\t.u_bus_o(left_switch_0_0),',
        '\t\t.u_bus_i(switch_left_0_0),',
        '\t\t.l_bus_i(left_switch_1_0),',
        '\t\t.r_bus_i(right_switch_1_0),',
        '\t\t.l_bus_o(switch_left_1_0),',
        '\t\t.r_bus_o(switch_right_1_0));'
    ]) + '\n' + cluster_type

def build_leveln(type1Pattern, type2Pattern, type3Pattern) :
    t1_t_num = 0
    t1_pi_num = 0
    t2_t_num = 0
    t2_pi_num = 0
    t3_t_num = 0
    t3_pi_num = 0

    for type in type1Pattern :
        if type == 't' :
            t1_t_num += 1
        elif type == 'pi' :
            t1_pi_num += 1

    t1_num_switch = 2**t1_pi_num

    for type in type2Pattern :
        if type == 't' :
            t2_t_num += 1
        elif type == 'pi' :
            t2_pi_num += 1

    t2_num_switch = 2**t2_pi_num

    for type in type3Pattern :
        if type == 't' :
            t3_t_num += 1
        elif type == 'pi' :
            t3_pi_num += 1

    t3_num_switch = 2**t3_pi_num

    # Actually bandwicth
    num_switch_array = [t1_num_switch, t2_num_switch, t3_num_switch, t3_num_switch]

    pattern = [type1Pattern, type2Pattern, type3Pattern, type3Pattern]

    switch_factor = [1, 1, 1, 1]

    str_return = ''

    for level in range(2, 8) :
        addr_cnt = 0
        num_switch_each_branch = 2**level
        num_switch = 2**(level-2)
        str_return += '//--------level='+str(level)+'--------------\n'

        for index in range(4) :
            if (pattern[index][7-level] == 'pi') :
                switch_factor[index] *= 2
            else :
                switch_factor[index] *= 1
        
        for layer in range(num_switch_each_branch) :
            pattern_index = layer // num_switch

            bandwidth = int(num_switch_array[pattern_index] / switch_factor[pattern_index])

            str_return += '\twire [p_sz*'+str(bandwidth)+'-1:0] left_switch_'+str(level)+'_'+str(layer)+';\n'
            str_return += '\twire [p_sz*'+str(bandwidth)+'-1:0] right_switch_'+str(level)+'_'+str(layer)+';\n'
            str_return += '\twire [p_sz*'+str(bandwidth)+'-1:0] switch_left_'+str(level)+'_'+str(layer)+';\n'
            str_return += '\twire [p_sz*'+str(bandwidth)+'-1:0] switch_right_'+str(level)+'_'+str(layer)+';\n'

        for index in range(4) :

            curr_num_switch = int(num_switch_array[index] / switch_factor[index])

            switch_type = pattern[index][7-level]

            for num in range(num_switch) :
                if switch_type == 'pi' :
                    str_return += pi_cluster(addr_cnt, level, curr_num_switch, level-1, addr_cnt//2, level, addr_cnt)
                else :
                    str_return += t_cluster(addr_cnt, level, curr_num_switch, level-1, addr_cnt//2, level, addr_cnt)
                addr_cnt += 1

    return str_return

def build_level8() :
    str_return = '//--------level=8--------------\n'
    for addr in range(256) :
        str_return += interface(addr)

    return str_return + 'endmodule\n\n'

def interface(addr) :
    u_bus = ''
    if addr % 2 : 
        u_bus = 'right'
    else :
        u_bus = 'left'

    return '\n'.join([
        '\tinterface #(',
        '\t\t.num_leaves(num_leaves),',
        '\t\t.payload_sz(payload_sz),',
        '\t\t.addr('+str(addr)+'),',
        '\t\t.p_sz(p_sz)',
        '\t\t)interface_'+str(addr)+'(',
        '\t\t.clk(clk),',
        '\t\t.reset(reset),',
        '\t\t.bus_i(switch_'+u_bus+'_7_'+str(addr//2)+'),',
        '\t\t.bus_o('+u_bus+'_switch_7_'+str(addr//2)+'),',
        '\t\t.pe_interface(pe_interface[p_sz*'+str(addr+1)+'-1:p_sz*'+str(addr)+']),',
        '\t\t.interface_pe(interface_pe[p_sz*'+str(addr+1)+'-1:p_sz*'+str(addr)+']),',
        '\t\t.resend(resend['+str(addr)+']));\n\n'
    ])

def build_rest() :
    return '\n'.join([
        '`ifndef DIRECTION_PARAMS_H',
        '`define DIRECTION_PARAMS_H',
        '`define VOID 2\'b00',
        '`define LEFT 2\'b01'
    ])

def t_switch_rand_level0(order) :
    return '\n'.join([
        '\tt_switch_rand #(',
        '\t\t.num_leaves(num_leaves),',
        '\t\t.payload_sz(payload_sz),',
        '\t\t.addr(addr),',
        '\t\t.level(level),',
        '\t\t.p_sz(p_sz))',
        '\t\tts_r_0_'+str(order)+' (',
        '\t\t.clk(clk),',
        '\t\t.reset(reset),',
        '\t\t.l_bus_i(left_switch_0_'+str(order)+'),',
        '\t\t.r_bus_i(right_switch_0_'+str(order)+'),',
        '\t\t.u_bus_i(up_switch_0_0['+str(order)+'*p_sz+:p_sz]),',
        '\t\t.l_bus_o(switch_left_0_'+str(order)+'),',
        '\t\t.r_bus_o(switch_right_0_'+str(order)+'),',
        '\t\t.u_bus_o(switch_up_0_0['+str(order)+'*p_sz+:p_sz]));\n\n'
    ])

def t_switch_after_rand(level, order) :
    u_bus_o = ''
    if order % 2 : 
        u_bus_o = 'right'
    else :
        u_bus_o = 'left'
    return '\n'.join([
        '\tt_switch #(',
        '\t\t.num_leaves(num_leaves),',
        '\t\t.payload_sz(payload_sz),',
        '\t\t.addr(addr),',
        '\t\t.level(level),',
        '\t\t.p_sz(p_sz))',
        '\t\tts_'+str(level)+'_'+str(order)+' (',
        '\t\t.clk(clk),',
        '\t\t.reset(reset),',
        '\t\t.l_bus_i(left_switch_'+str(level)+'_'+str(order)+'),',
        '\t\t.r_bus_i(right_switch_'+str(level)+'_'+str(order)+'),',
        '\t\t.u_bus_i(switch_'+u_bus_o+'_'+str(level-1)+'_'+str(order//2)+'),',
        '\t\t.l_bus_o(switch_left_'+str(level)+'_'+str(order)+'),',
        '\t\t.r_bus_o(switch_right_'+str(level)+'_'+str(order)+'),',
        '\t\t.u_bus_o('+u_bus_o+'_switch_'+str(level-1)+'_'+str(order//2)+'));\n\n'
    ])

def t_switch(level, order) :
    return '\n'.join([
        '\tt_switch #(',
        '\t\t.num_leaves(num_leaves),',
        '\t\t.payload_sz(payload_sz),',
        '\t\t.addr(addr),',
        '\t\t.level(level),',
        '\t\t.p_sz(p_sz))',
        '\t\tts_'+str(level)+'_'+str(order)+' (',
        '\t\t.clk(clk),',
        '\t\t.reset(reset),',
        '\t\t.l_bus_i(left_switch_'+str(level)+'_'+str(order)+'),',
        '\t\t.r_bus_i(right_switch_'+str(level)+'_'+str(order)+'),',
        '\t\t.u_bus_i(switch_right_'+str(level-1)+'_'+str(order)+'),',
        '\t\t.l_bus_o(switch_left_'+str(level)+'_'+str(order)+'),',
        '\t\t.r_bus_o(switch_right_'+str(level)+'_'+str(order)+'),',
        '\t\t.u_bus_o(right_switch_'+str(level-1)+'_'+str(order)+'));\n\n'
    ])

def t_switch_rand(level, order) :
    u_bus_o = ''
    if order % 2 : 
        u_bus_o = 'right'
    else :
        u_bus_o = 'left'
    return '\n'.join([
        '\tt_switch_rand #(',
        '\t\t.num_leaves(num_leaves),',
        '\t\t.payload_sz(payload_sz),',
        '\t\t.addr(addr),',
        '\t\t.level(level),',
        '\t\t.p_sz(p_sz))',
        '\t\tts_r_'+str(level)+'_'+str(order)+' (',
        '\t\t.clk(clk),',
        '\t\t.reset(reset),',
        '\t\t.l_bus_i(left_switch_'+str(level)+'_'+str(order)+'),',
        '\t\t.r_bus_i(right_switch_'+str(level)+'_'+str(order)+'),',
        '\t\t.u_bus_i(switch_'+u_bus_o+'_'+str(level-1)+'_'+str(order//2)+'),',
        '\t\t.l_bus_o(switch_left_'+str(level)+'_'+str(order)+'),',
        '\t\t.r_bus_o(switch_right_'+str(level)+'_'+str(order)+'),',
        '\t\t.u_bus_o('+u_bus_o+'_switch_'+str(level-1)+'_'+str(order//2)+'));\n\n'
    ])


def hetero_sw(num_switch_1, num_switch_2, num_switch_3) :
    str_return = 'module hetero_sw_'+str(num_switch_1)+str(num_switch_2)+str(num_switch_3)+'(\n'
    str_return += '\tinput clk,\n'
    str_return += '\tinput reset,\n'
    str_return += '\tinput ['+str(num_switch_1)+'*p_sz-1:0] l_bus_i,\n'
    str_return += '\tinput ['+str(num_switch_2)+'*p_sz-1:0] r_bus_i,\n'
    str_return += '\tinput ['+str(num_switch_3)+'*p_sz-1:0] u_bus_i,\n'
    str_return += '\toutput ['+str(num_switch_1)+'*p_sz-1:0] l_bus_o,\n'
    str_return += '\toutput ['+str(num_switch_2)+'*p_sz-1:0] r_bus_o,\n'
    str_return += '\toutput ['+str(num_switch_3)+'*p_sz-1:0] u_bus_o\n'
    str_return += '\t);\n'
    str_return += '\t// Override these values in top modules\n'
    str_return += '\tparameter num_leaves= 2;\n'
    str_return += '\tparameter payload_sz= 1;\n'
    str_return += '\tparameter addr= 1\'b0;\n'
    str_return += '\tparameter level= 0; // only change if level == 0\n'
    str_return += '\tparameter p_sz= 1+$clog2(num_leaves)+payload_sz;\n'

    #t_switch_rand layers

    num_switch_2_to_3 = int(math.log2(num_switch_2 // num_switch_3))

    for iteration in range(num_switch_2_to_3) :
        str_return += '\t//---------------sub-level='+str(iteration)+'---------------\n'
        if iteration == 0 :
            str_return += '\twire ['+str(num_switch_3)+'*p_sz-1:0] up_switch_0_0;\n'
            str_return += '\twire ['+str(num_switch_3)+'*p_sz-1:0] switch_up_0_0;\n'

        for index in range(num_switch_3*2**iteration) :
            str_return += '\twire [p_sz-1:0] left_switch_'+str(iteration)+'_'+str(index)+';\n'
            str_return += '\twire [p_sz-1:0] right_switch_'+str(iteration)+'_'+str(index)+';\n'
            str_return += '\twire [p_sz-1:0] switch_left_'+str(iteration)+'_'+str(index)+';\n'
            str_return += '\twire [p_sz-1:0] switch_right_'+str(iteration)+'_'+str(index)+';\n'

        # build rand switch
        if iteration == 0 :
            for order in range(num_switch_3) :
                str_return += t_switch_rand_level0(order)
        else :
            for order in range(num_switch_3 * (2**iteration)) :
                str_return += t_switch_rand(iteration, order)

    # t_switch layers

    num_switch_1_to_2 = int(num_switch_1 // num_switch_2)
    
    for iteration in range(num_switch_2_to_3, num_switch_1_to_2 + num_switch_2_to_3) :
        str_return += '\t//---------------sub-level='+str(iteration)+'---------------\n'
        iterate_num = num_switch_2 // num_switch_3
        for index in range(num_switch_2) :
            str_return += '\twire [p_sz-1:0] left_switch_'+str(iteration)+'_'+str(index)+';\n'
            str_return += '\twire [p_sz-1:0] right_switch_'+str(iteration)+'_'+str(index)+';\n'
            str_return += '\twire [p_sz-1:0] switch_left_'+str(iteration)+'_'+str(index)+';\n'
            str_return += '\twire [p_sz-1:0] switch_right_'+str(iteration)+'_'+str(index)+';\n'

        # build switch
        if iteration == num_switch_2_to_3 :
            for order in range(num_switch_2) :
                str_return += t_switch_after_rand(iteration, order)
        else :
            for order in range(num_switch_2) :
                str_return += t_switch(iteration, order)

    str_return += '\tassign up_switch_0_0 = u_bus_i;\n'
    str_return += '\tassign u_bus_o = switch_up_0_0;\n'

    ending_level = num_switch_1_to_2 + num_switch_2_to_3 - 1
    str_return += '\n\t// '+str(num_switch_2)+' right inouts\n'
    for iteration in range(num_switch_2) :
        str_return += '\t// ts_'+str(ending_level)+'_'+str(iteration)+'\n'
        str_return += '\tassign right_switch_'+str(ending_level)+'_'+str(iteration)+' = r_bus_i['+str(iteration)+'*p_sz+:p_sz];\n'
        str_return += '\tassign r_bus_o['+str(iteration)+'*p_sz+:p_sz] = switch_right_'+str(ending_level)+'_'+str(iteration)+';\n'

    str_return += '\n\t// '+str(num_switch_1)+' left inouts\n'
    switch_cnt = 0
    for level in range(num_switch_2_to_3, ending_level+1) :
        for iteration in range(num_switch_2) :
            str_return += '\t// ts_'+str(level)+'_'+str(iteration)+'\n'
            str_return += '\tassign left_switch_'+str(level)+'_'+str(iteration)+' = l_bus_i['+str(switch_cnt)+'*p_sz+:p_sz];\n'
            str_return += '\tassign l_bus_o['+str(switch_cnt)+'*p_sz+:p_sz] = switch_left_'+str(level)+'_'+str(iteration)+';\n'
            switch_cnt += 1

    str_return += '\nendmodule\n\n'

    return str_return

def build_end() :

    # uncomment for simulation
    f = open("bft_asym_fixed_sim.txt", "r")
    
    # uncomment for impl
    # f = open("bft_asym_fixed_impl.txt", "r")
    str_list = f.readlines()
    str_return = ''
    for line in str_list :
        str_return += line
    f.close()

    return str_return

if __name__ == '__main__':
    build_bft_asym()
