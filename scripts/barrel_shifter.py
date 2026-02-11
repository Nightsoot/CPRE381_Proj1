import numpy as np
import math
import random
import os

#MAKE SURE TO MAKE AN OUTPUTS FOLDER BEFOREHAND

#change this for different .txt output
FILE_NAME = os.getcwd().replace("\\", "/") + "/outputs/" "barrel_shifter" + ".txt"
f = None
case_num = 0



#assuming signal is string of name, width is length in bits, value is integer
def write_assignment(signal, width, value):
    global f
    out = signal + " <= "
    #different syntax between std_logic and std_logic_vector
    if width == 1:
        out += "'"
    else:
        out += 'X"'

    out += f'{int(np.binary_repr(value, width=width), base=2):X}'.zfill(math.ceil(width/4))

    #pad off 
    if width == 1:
        
        out += "';\n"
    else:
        out += '";\n'

    f.write(out)

#assuming signal is string of name, width is length in bits, value is integer
def write_assertion(signal, width, value, message = "Case failed"):
    global f
    out = "assert (" + signal + " = "
    #different syntax between std_logic and std_logic_vector
    if width == 1:
        out += "'"
    else:
        out += 'X"'

    out += f'{int(np.binary_repr(value, width=width), base=2):X}'.zfill(math.ceil(width/4))

    #pad off 
    if width == 1:
        
        out += "')"
    else:
        out += '")'

    out += " report " + '"' + message  + '"' + " severity error;\n"

    f.write(out)

def increment_case():
    global case_num
    out = f"s_case_number <= {case_num};\n" + "wait for cCLK_PER;\n\n" 
    case_num += 1
    f.write(out)




def srl(a, b):
    return (a>>b) & 0xFFFFFFFF if a >= 0 else ((a+0x800000000)>>b) & 0xFFFFFFFF


def to_signed(a):
    return -(a & 0x80000000) + (a & 0x7FFFFFFF)

def sra(a, b):
    arr = np.int32(to_signed(a))
    return np.right_shift(arr, b)



def sll(a,b):
    return (a << b) & 0xFFFFFFFF



def edge_cases():

    write_assignment("s_operand", 32, 0x80000000)
    write_assignment("s_shift", 5, 31)
    write_assignment("s_left", 1, 0)
    write_assignment("s_sign_fill", 1, 1)
    write_assertion("s_result", 32, sra((0x80000000), 31), message=f"Case {case_num} failed")
    increment_case()

    write_assignment("s_operand", 32, 0x80000000)
    write_assignment("s_shift", 5, 31)
    write_assignment("s_left", 1, 0)
    write_assignment("s_sign_fill", 1, 0)
    write_assertion("s_result", 32, srl((0x80000000), 31), message=f"Case {case_num} failed")
    increment_case()

    write_assignment("s_operand", 32, 0x80000000)
    write_assignment("s_shift", 5, 1)
    write_assignment("s_left", 1, 1)
    write_assignment("s_sign_fill", 1, 0)
    write_assertion("s_result", 32, sll((0x80000000), 1), message=f"Case {case_num} failed")
    increment_case()

    write_assignment("s_operand", 32, 0xFFFFFFFF)
    write_assignment("s_shift", 5, 31)
    write_assignment("s_left", 1, 0)
    write_assignment("s_sign_fill", 1, 1)
    write_assertion("s_result", 32, sra((0xFFFFFFFF), 31), message=f"Case {case_num} failed")
    increment_case()

    write_assignment("s_operand", 32, 0x00000000)
    write_assignment("s_shift", 5, 31)
    write_assignment("s_left", 1, 0)
    write_assignment("s_sign_fill", 1, 1)
    write_assertion("s_result", 32, sra((0x00000000), 31), message=f"Case {case_num} failed")
    increment_case()

def example_case():
    global f
    for i in range(1,101):
        a = random.randint(-2**31, 2**31-1)
        b = random.randint(-2**31, 2**31-1)
        f.write(f"--Test Case {i}:\n")
        write_assignment("i_A", 32, a)
        write_assignment("i_B", 32, b)
        write_assertion("i_S", 32, (a+b) & 0xFFFFFFFF, message=f"Case {case_num} failed")
        f.write('\n')
    




def main():
    global f 
    with open(FILE_NAME, 'w', encoding='utf-8') as f1:
        f = f1
        edge_cases()

    f.close()

main()