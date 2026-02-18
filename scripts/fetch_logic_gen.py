import numpy as np
import math
import random
import os

#MAKE SURE TO MAKE AN OUTPUTS FOLDER BEFOREHAND

#change this for different .txt output
FILE_NAME = os.getcwd().replace("\\", "/") + "/outputs/" "fetch_logic" + ".txt"
f = None

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

def wait_clock_cycle():
    global f
    out = "wait for cCLK_PER;\n"
    f.write(out)

def branch(pc_src, alu_res,  comp, zero, negative, carry, overflow, pc, imm):
    if pc_src == 0:
        return pc + 4
    if pc_src == 2:
        return alu_res
    if comp == 0:
        if zero == 1:
            return pc + imm
        else:
            return pc + 4
    elif comp == 1:
        if zero == 0:
            return pc + imm
        else:
            return pc + 4
    elif comp == 2:
        if negative != overflow:
            return pc + imm
        else:
            return pc + 4
    elif comp == 3:
        if negative == overflow:
            return pc + imm
        else:
            return pc + 4
    elif comp == 4:
        if carry == 0:
            return pc + imm
        else:
            return pc + 4
    elif comp == 5:
        if carry == 1:
            return pc + imm
        else:
            return pc + 4
    else:
        return 0




def example_case():
    global f
    for i in range(1,101):
        pc = random.randint(0, 2**32-5)
        imm = random.randint(0, 2**32-1)
        alu_res = random.randint(0, 2**32-1)
        pc_src = random.randint(0, 2)
        comp = random.randint(0, 5)
        zero = random.randint(0, 1)
        negative = random.randint(0, 1)
        carry = random.randint(0, 1)
        overflow = random.randint(0, 1)
        target = branch(pc_src, alu_res, comp, zero, negative, carry, overflow, pc, imm)
        branch_type = ["beq", "bne", "blt", "bge", "bltu", "bgeu"]
        f.write(f"--Test Case {i}:\n")
        write_assignment("s_PC", 32, pc)
        write_assignment("s_imm", 32, imm)
        write_assignment("s_ALU_result", 32, alu_res)
        write_assignment("s_PC_source", 2, pc_src)
        write_assignment("s_comparison", 3, comp)
        write_assignment("s_zero", 1, zero)
        write_assignment("s_negative", 1, negative)
        write_assignment("s_carry", 1, carry)
        write_assignment("s_overflow", 1, overflow)
        wait_clock_cycle()
        write_assertion("s_new_PC", 32, target & 0xFFFFFFFF, message=f"Case {i} {branch_type[comp]} failed")
        f.write('\n')
    




def main():
    global f 
    with open(FILE_NAME, 'w', encoding='utf-8') as f1:
        f = f1
        example_case()

    f.close()

main()