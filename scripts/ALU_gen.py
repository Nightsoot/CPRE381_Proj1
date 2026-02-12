import numpy as np
import math
import random
import os

#MAKE SURE TO MAKE AN OUTPUTS FOLDER BEFOREHAND

#change this for different .txt output
FILE_NAME = os.getcwd().replace("\\", "/") + "/outputs/" "ALU_tb" + ".txt"
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
def write_assertion(signal, width, value, message = "Case failed", add_waits=False):
    global f

    out = ""
    if add_waits:
        out += "wait for cCLK_PER/2;\n"

    out += "assert (" + signal + " = "
    #different syntax between std_logic and std_logic_vector
    if width == 1 and value != None:
        out += "'"
    elif value != None:
        out += 'X"'
    elif width == 1 and value == None:
        out += "'"
    else:
        out += '"'

    #allow don't cares
    if value != None:
        out += f'{int(np.binary_repr(value, width=width), base=2):X}'.zfill(math.ceil(width/4))
    else:
        out += width * "X"
    
    #pad off 
    if width == 1:
        
        out += "')"
    else:
        out += '")'

    out += " report " + '"' + message  + '"' + " severity error;\n"

    if add_waits:
        out += "wait for cCLK_PER/2;\n\n"

    f.write(out)

def increment_case():
    global case_num
    
    out = f"s_case_number <= {case_num};\n"
    
    case_num += 1
    f.write(out)

def write_wait():
    f.write("wait for cCLK_PER/2;\n")


def srl(a, b):
    return (a>>b) & 0xFFFFFFFF if a >= 0 else ((a+0x800000000)>>b) & 0xFFFFFFFF


def to_signed(a):
    return -(a & 0x80000000) + (a & 0x7FFFFFFF)

def sra(a, b):
    arr = np.int32(to_signed(a))
    return np.right_shift(arr, b)


def sll(a,b):
    return (a << b) & 0xFFFFFFFF

def twos_complement(a):
    return (-a) & 0xFFFFFFFF

def add(a,b):
    MASK_32 = 0xFFFFFFFF
    SIGN_BIT = 0x80000000

    full_sum = a + b
    result = full_sum & MASK_32

    carry_out = 1 if full_sum > MASK_32 else 0
    zero_flag = 1 if result == 0 else 0


    a_sign = (a & SIGN_BIT) != 0
    b_sign = (b & SIGN_BIT) != 0
    r_sign = (result & SIGN_BIT) != 0

    overflow_flag = 1 if (a_sign == b_sign) and (a_sign != r_sign) else 0
    
    return result, zero_flag, (result & SIGN_BIT) >> 31, carry_out, overflow_flag

def and32(a,b):
    return a & b & 0xFFFFFFFF

def xor32(a,b):
    return (a ^ b) & 0xFFFFFFFF

def or32(a,b):
    return (a | b) & 0xFFFFFFFF




def edge_cases():
    global f

    a = 0xFFFFFFFF
    b = 0x1
    write_assignment("s_a", 32, a)
    write_assignment("s_b", 32, b)
    write_assignment("s_ALU_operation", 32, 0b000)
    write_wait()
    write_assertion("s_result", 32, add(a,b)[0], message=f"Case {case_num} result failed")
    write_assertion("s_zero", 1, add(a,b)[1], message=f"Case {case_num} zero flag failed")
    write_assertion("s_negative", 1, add(a,b)[2], message=f"Case {case_num} negative flag failed")
    write_assertion("s_carry_out", 1, add(a,b)[3], message=f"Case {case_num} carry flag failed")
    write_assertion("s_overflow", 1, add(a,b)[4], message=f"Case {case_num} overflow flag failed")
    write_wait()
    increment_case()
    f.write('\n')

    

    write_assignment("s_a", 32, a)
    write_assignment("s_b", 32, b)
    b = twos_complement(b)
    write_assignment("s_ALU_operation", 32, 0b001)
    write_wait()
    write_assertion("s_result", 32, add(a,b)[0], message=f"Case {case_num} result failed")
    write_assertion("s_zero", 1, add(a,b)[1], message=f"Case {case_num} zero flag failed")
    write_assertion("s_negative", 1, add(a,b)[2], message=f"Case {case_num} negative flag failed")
    write_assertion("s_carry_out", 1, add(a,b)[3], message=f"Case {case_num} carry flag failed")
    write_assertion("s_overflow", 1, add(a,b)[4], message=f"Case {case_num} overflow flag failed")
    write_wait()
    increment_case()
    f.write('\n')

    a = 0xFFFFFFFF
    b = 0x00000000

    write_assignment("s_a", 32, a)
    write_assignment("s_b", 32, b)
    write_assignment("s_ALU_operation", 32, 0b010)
    write_wait()
    write_assertion("s_result", 32, and32(a,b), message=f"Case {case_num} result failed")
    write_assertion("s_zero", 1, None, message=f"Case {case_num} zero flag failed")
    write_assertion("s_negative", 1, None, message=f"Case {case_num} negative flag failed")
    write_assertion("s_carry_out", 1, None, message=f"Case {case_num} carry flag failed")
    write_assertion("s_overflow", 1, None, message=f"Case {case_num} overflow flag failed")
    write_wait()
    increment_case()
    f.write('\n')

    a = 0xFFFFFFFF
    b = 0x00000000

    write_assignment("s_a", 32, a)
    write_assignment("s_b", 32, b)
    write_assignment("s_ALU_operation", 32, 0b011)
    write_wait()
    write_assertion("s_result", 32, or32(a,b), message=f"Case {case_num} result failed")
    write_assertion("s_zero", 1, None, message=f"Case {case_num} zero flag failed")
    write_assertion("s_negative", 1, None, message=f"Case {case_num} negative flag failed")
    write_assertion("s_carry_out", 1, None, message=f"Case {case_num} carry flag failed")
    write_assertion("s_overflow", 1, None, message=f"Case {case_num} overflow flag failed")
    write_wait()
    increment_case()
    f.write('\n')

    a = 0xFFFFFFFF
    b = 0xFFFFFFFF

    write_assignment("s_a", 32, a)
    write_assignment("s_b", 32, b)
    write_assignment("s_ALU_operation", 32, 0b100)
    write_wait()
    write_assertion("s_result", 32, xor32(a,b), message=f"Case {case_num} result failed")
    write_assertion("s_zero", 1, None, message=f"Case {case_num} zero flag failed")
    write_assertion("s_negative", 1, None, message=f"Case {case_num} negative flag failed")
    write_assertion("s_carry_out", 1, None, message=f"Case {case_num} carry flag failed")
    write_assertion("s_overflow", 1, None, message=f"Case {case_num} overflow flag failed")
    write_wait()
    increment_case()
    f.write('\n')


    a = 0x80000000
    b = 31

    write_assignment("s_a", 32, a)
    write_assignment("s_b", 32, b)
    write_assignment("s_ALU_operation", 32, 0b101)
    write_wait()
    write_assertion("s_result", 32, sll(a,b), message=f"Case {case_num} result failed")
    write_assertion("s_zero", 1, None, message=f"Case {case_num} zero flag failed")
    write_assertion("s_negative", 1, None, message=f"Case {case_num} negative flag failed")
    write_assertion("s_carry_out", 1, None, message=f"Case {case_num} carry flag failed")
    write_assertion("s_overflow", 1, None, message=f"Case {case_num} overflow flag failed")
    write_wait()
    increment_case()
    f.write('\n')


    a = 0x80000000
    b = 31

    write_assignment("s_a", 32, a)
    write_assignment("s_b", 32, b)
    write_assignment("s_ALU_operation", 32, 0b110)
    write_wait()
    write_assertion("s_result", 32, srl(a,b), message=f"Case {case_num} result failed")
    write_assertion("s_zero", 1, None, message=f"Case {case_num} zero flag failed")
    write_assertion("s_negative", 1, None, message=f"Case {case_num} negative flag failed")
    write_assertion("s_carry_out", 1, None, message=f"Case {case_num} carry flag failed")
    write_assertion("s_overflow", 1, None, message=f"Case {case_num} overflow flag failed")
    write_wait()
    increment_case()
    f.write('\n')


    a = 0x80000000
    b = 31

    write_assignment("s_a", 32, a)
    write_assignment("s_b", 32, b)
    write_assignment("s_ALU_operation", 32, 0b111)
    write_wait()
    write_assertion("s_result", 32, sra(a,b), message=f"Case {case_num} result failed")
    write_assertion("s_zero", 1, None, message=f"Case {case_num} zero flag failed")
    write_assertion("s_negative", 1, None, message=f"Case {case_num} negative flag failed")
    write_assertion("s_carry_out", 1, None, message=f"Case {case_num} carry flag failed")
    write_assertion("s_overflow", 1, None, message=f"Case {case_num} overflow flag failed")
    write_wait()
    increment_case()
    f.write('\n')



def random_cases():
    global f

    for i in range(1,101):
        a = random.randint(0, 2**32  - 1)
        b = random.randint(0, 2**32  - 1)
        write_assignment("s_a", 32, a)
        write_assignment("s_b", 32, b)
        write_assignment("s_ALU_operation", 32, 0b000)
        write_wait()
        write_assertion("s_result", 32, add(a,b)[0], message=f"Case {case_num} result failed")
        write_assertion("s_zero", 1, add(a,b)[1], message=f"Case {case_num} zero flag failed")
        write_assertion("s_negative", 1, add(a,b)[2], message=f"Case {case_num} negative flag failed")
        write_assertion("s_carry_out", 1, add(a,b)[3], message=f"Case {case_num} carry flag failed")
        write_assertion("s_overflow", 1, add(a,b)[4], message=f"Case {case_num} overflow flag failed")
        write_wait()
        increment_case()
        f.write('\n')


    for i in range(1, 101):
        a = random.randint(0, 2**32  - 1)
        b = random.randint(0, 2**32  - 1)
        

        write_assignment("s_a", 32, a)
        write_assignment("s_b", 32, b)
        b = twos_complement(b)
        write_assignment("s_ALU_operation", 32, 0b001)
        write_wait()
        write_assertion("s_result", 32, add(a,b)[0], message=f"Case {case_num} result failed")
        write_assertion("s_zero", 1, add(a,b)[1], message=f"Case {case_num} zero flag failed")
        write_assertion("s_negative", 1, add(a,b)[2], message=f"Case {case_num} negative flag failed")
        write_assertion("s_carry_out", 1, add(a,b)[3], message=f"Case {case_num} carry flag failed")
        write_assertion("s_overflow", 1, add(a,b)[4], message=f"Case {case_num} overflow flag failed")
        write_wait()
        increment_case()
        f.write('\n')

    for i in range(1, 101):
        a = random.randint(0, 2**32  - 1)
        b = random.randint(0, 2**32  - 1)

        write_assignment("s_a", 32, a)
        write_assignment("s_b", 32, b)
        write_assignment("s_ALU_operation", 32, 0b010)
        write_wait()
        write_assertion("s_result", 32, and32(a,b), message=f"Case {case_num} result failed")
        write_assertion("s_zero", 1, None, message=f"Case {case_num} zero flag failed")
        write_assertion("s_negative", 1, None, message=f"Case {case_num} negative flag failed")
        write_assertion("s_carry_out", 1, None, message=f"Case {case_num} carry flag failed")
        write_assertion("s_overflow", 1, None, message=f"Case {case_num} overflow flag failed")
        write_wait()
        increment_case()
        f.write('\n')

    for i in range(1, 101):
        a = random.randint(0, 2**32  - 1)
        b = random.randint(0, 2**32  - 1)

        write_assignment("s_a", 32, a)
        write_assignment("s_b", 32, b)
        write_assignment("s_ALU_operation", 32, 0b011)
        write_wait()
        write_assertion("s_result", 32, or32(a,b), message=f"Case {case_num} result failed")
        write_assertion("s_zero", 1, None, message=f"Case {case_num} zero flag failed")
        write_assertion("s_negative", 1, None, message=f"Case {case_num} negative flag failed")
        write_assertion("s_carry_out", 1, None, message=f"Case {case_num} carry flag failed")
        write_assertion("s_overflow", 1, None, message=f"Case {case_num} overflow flag failed")
        write_wait()
        increment_case()
        f.write('\n')

    for i in range(1, 101):
        a = random.randint(0, 2**32  - 1)
        b = random.randint(0, 2**32  - 1)

        write_assignment("s_a", 32, a)
        write_assignment("s_b", 32, b)
        write_assignment("s_ALU_operation", 32, 0b100)
        write_wait()
        write_assertion("s_result", 32, xor32(a,b), message=f"Case {case_num} result failed")
        write_assertion("s_zero", 1, None, message=f"Case {case_num} zero flag failed")
        write_assertion("s_negative", 1, None, message=f"Case {case_num} negative flag failed")
        write_assertion("s_carry_out", 1, None, message=f"Case {case_num} carry flag failed")
        write_assertion("s_overflow", 1, None, message=f"Case {case_num} overflow flag failed")
        write_wait()
        increment_case()
        f.write('\n')


    for i in range(1, 101):
        a = random.randint(0, 2**32  - 1)
        b = random.randint(0, 31)
        write_assignment("s_a", 32, a)
        write_assignment("s_b", 32, b)
        write_assignment("s_ALU_operation", 32, 0b101)
        write_wait()
        write_assertion("s_result", 32, sll(a,b), message=f"Case {case_num} result failed")
        write_assertion("s_zero", 1, None, message=f"Case {case_num} zero flag failed")
        write_assertion("s_negative", 1, None, message=f"Case {case_num} negative flag failed")
        write_assertion("s_carry_out", 1, None, message=f"Case {case_num} carry flag failed")
        write_assertion("s_overflow", 1, None, message=f"Case {case_num} overflow flag failed")
        write_wait()
        increment_case()
        f.write('\n')


    for i in range(1, 101):
        a = random.randint(0, 2**32  - 1)
        b = random.randint(0, 31)
        write_assignment("s_a", 32, a)
        write_assignment("s_b", 32, b)
        write_assignment("s_ALU_operation", 32, 0b110)
        write_wait()
        write_assertion("s_result", 32, srl(a,b), message=f"Case {case_num} result failed")
        write_assertion("s_zero", 1, None, message=f"Case {case_num} zero flag failed")
        write_assertion("s_negative", 1, None, message=f"Case {case_num} negative flag failed")
        write_assertion("s_carry_out", 1, None, message=f"Case {case_num} carry flag failed")
        write_assertion("s_overflow", 1, None, message=f"Case {case_num} overflow flag failed")
        write_wait()
        increment_case()
        f.write('\n')

    for i in range(1, 101):
        a = random.randint(0, 2**32  - 1)
        b = random.randint(0, 31)
        write_assignment("s_a", 32, a)
        write_assignment("s_b", 32, b)
        write_assignment("s_ALU_operation", 32, 0b111)
        write_wait()
        write_assertion("s_result", 32, sra(a,b), message=f"Case {case_num} result failed")
        write_assertion("s_zero", 1, None, message=f"Case {case_num} zero flag failed")
        write_assertion("s_negative", 1, None, message=f"Case {case_num} negative flag failed")
        write_assertion("s_carry_out", 1, None, message=f"Case {case_num} carry flag failed")
        write_assertion("s_overflow", 1, None, message=f"Case {case_num} overflow flag failed")
        write_wait()
        increment_case()
        f.write('\n')




def main():
    global f 
    with open(FILE_NAME, 'w', encoding='utf-8') as f1:
        f = f1
        edge_cases()
        random_cases()

    f.close()

main()