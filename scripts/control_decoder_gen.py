import numpy as np
import math
import random
import os

#MAKE SURE TO MAKE AN OUTPUTS FOLDER BEFOREHAND

#change this for different .txt output
FILE_NAME = os.getcwd().replace("\\", "/") + "/outputs/" "control_decoder" + ".txt"
f = None
case_num = 0



#assuming signal is string of name, width is length in bits, value is integer
def write_assignment(signal, width, value):
    global f
    out = "        " + signal + " <= "
    #different syntax between std_logic and std_logic_vector
    if width == 1:
        out += "'"
    else:
        out += '"'

    # Use binary notation
    binary_str = np.binary_repr(value, width=width)
    out += binary_str

    #pad off 
    if width == 1:
        
        out += "';\n"
    else:
        out += '";\n'
        out += "        wait for cCLK_PER;\n"
    f.write(out)

#assuming signal is string of name, width is length in bits, value is integer
def write_assertion(signal, width, value, message = "Case failed"):
    global f
    out = "        assert (" + signal + " = "
    #different syntax between std_logic and std_logic_vector
    if width == 1:
        out += "'"
    else:
        out += '"'

    # Use binary notation
    binary_str = np.binary_repr(value, width=width)
    out += binary_str

    #pad off 
    if width == 1:
        
        out += "')"
    else:
        out += '")'

    out += " report " + '"' + message  + '"' + " severity error;\n"

    f.write(out)

def increment_case():
    global case_num
    out = f"        s_case_number <= {case_num};\n" + "        wait for cCLK_PER;\n\n" 
    case_num += 1
    f.write(out)

def make_instruction(opcode, funct3, funct7):
    """Return a 32-bit integer where fields are placed as:
    - funct7 at bits [31:25]
    - funct3 at bits [14:12]
    - opcode at bits [6:0]
    All other bits are zero. Inputs are masked to their widths.
    """
    return ((funct7 & 0x7F) << 25) | ((funct3 & 0x7) << 12) | (opcode & 0x7F)

def gen_function(func_sel):
    opcode = 0b0010011 #default to nop
    funct3 = 0b000
    funct7 = 0b0000000
    function_vals = [#opcode, funct3, funct7, ALUSrc, ALUControl, ImmType, ResultSrc, MemWrite, RegWrite, RegRead, PC_Source, MEM_Slice, Comparison
        [0b0000011, 0b010, 0b0000000, 0b1, 0b000, 0b001, 0b01, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#lw
        [0b0000011, 0b000, 0b0000000, 0b1, 0b000, 0b000, 0b01, 0b0, 0b1, 0b1, 0b00, 0b001, 0b000],#lb
        [0b0000011, 0b001, 0b0000000, 0b1, 0b000, 0b001, 0b01, 0b0, 0b1, 0b1, 0b00, 0b010, 0b000],#lh
        [0b0000011, 0b100, 0b0000000, 0b1, 0b000, 0b001, 0b01, 0b0, 0b1, 0b1, 0b00, 0b011, 0b000],#lbu
        [0b0000011, 0b101, 0b0000000, 0b1, 0b000, 0b001, 0b01, 0b0, 0b1, 0b1, 0b00, 0b100, 0b000],#lhu
        [0b0010011, 0b000, 0b0000000, 0b1, 0b000, 0b001, 0b00, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#addi
        [0b0010011, 0b111, 0b0000000, 0b1, 0b010, 0b000, 0b00, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#andi
        [0b0010011, 0b100, 0b0000000, 0b1, 0b100, 0b000, 0b00, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#xori
        [0b0010011, 0b110, 0b0000000, 0b1, 0b011, 0b000, 0b00, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#ori
        [0b0010011, 0b010, 0b0000000, 0b1, 0b001, 0b001, 0b00, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#slti
        [0b0010011, 0b001, 0b0000000, 0b1, 0b101, 0b000, 0b00, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#slli
        [0b0010011, 0b101, 0b0000000, 0b1, 0b110, 0b000, 0b00, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#srli
        [0b0010011, 0b101, 0b0100000, 0b1, 0b111, 0b000, 0b00, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#srai
        [0b0010111, 0b000, 0b0000000, 0b0, 0b000, 0b010, 0b00, 0b0, 0b0, 0b1, 0b01, 0b000, 0b000],#auipc
        [0b0100011, 0b010, 0b0000000, 0b1, 0b000, 0b001, 0b00, 0b1, 0b0, 0b1, 0b00, 0b000, 0b000],#sw
        [0b0110011, 0b000, 0b0000000, 0b0, 0b000, 0b000, 0b00, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#add
        [0b0110011, 0b111, 0b0000000, 0b0, 0b010, 0b000, 0b00, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#and
        [0b0110011, 0b100, 0b0000000, 0b0, 0b100, 0b000, 0b00, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#xor
        [0b0110011, 0b110, 0b0000000, 0b0, 0b011, 0b000, 0b00, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#or
        [0b0110011, 0b010, 0b0000000, 0b0, 0b001, 0b000, 0b00, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#slt
        [0b0110011, 0b011, 0b0000000, 0b0, 0b001, 0b000, 0b00, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#sltu
        [0b0110011, 0b001, 0b0000000, 0b0, 0b101, 0b000, 0b00, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#sll
        [0b0110011, 0b101, 0b0000000, 0b0, 0b110, 0b000, 0b00, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#srl
        [0b0110011, 0b101, 0b0100000, 0b0, 0b111, 0b000, 0b00, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#sra
        [0b0110011, 0b000, 0b0100000, 0b0, 0b001, 0b000, 0b00, 0b0, 0b1, 0b1, 0b00, 0b000, 0b000],#sub
        [0b0110111, 0b000, 0b0000000, 0b1, 0b000, 0b010, 0b00, 0b0, 0b1, 0b0, 0b00, 0b000, 0b000],#lui
        [0b1100011, 0b000, 0b0000000, 0b0, 0b001, 0b011, 0b00, 0b0, 0b0, 0b1, 0b01, 0b000, 0b000],#beq
        [0b1100011, 0b001, 0b0000000, 0b0, 0b001, 0b011, 0b00, 0b0, 0b0, 0b1, 0b01, 0b000, 0b001],#bne
        [0b1100011, 0b100, 0b0000000, 0b0, 0b001, 0b000, 0b00, 0b0, 0b0, 0b1, 0b01, 0b000, 0b010],#blt
        [0b1100011, 0b101, 0b0000000, 0b0, 0b001, 0b000, 0b00, 0b0, 0b0, 0b1, 0b01, 0b000, 0b110],#bge
        [0b1100011, 0b110, 0b0000000, 0b0, 0b001, 0b000, 0b00, 0b0, 0b0, 0b1, 0b01, 0b000, 0b100],#bltu
        [0b1100011, 0b111, 0b0000000, 0b0, 0b001, 0b000, 0b00, 0b0, 0b0, 0b1, 0b01, 0b000, 0b101],#bgeu
        [0b1100111, 0b000, 0b0000000, 0b0, 0b000, 0b100, 0b10, 0b0, 0b1, 0b1, 0b10, 0b000, 0b110],#jalr
        [0b1101111, 0b000, 0b0000000, 0b0, 0b000, 0b000, 0b10, 0b0, 0b1, 0b1, 0b01, 0b000, 0b110],#jal
    ]
    opcode     = function_vals[func_sel][0]
    funct3     = function_vals[func_sel][1]
    funct7     = function_vals[func_sel][2]
    ALUSrc     = function_vals[func_sel][3]
    ALUControl = function_vals[func_sel][4]
    ImmType    = function_vals[func_sel][5]
    ResultSrc  = function_vals[func_sel][6]
    MemWrite   = function_vals[func_sel][7]
    RegWrite   = function_vals[func_sel][8]
    RegRead    = function_vals[func_sel][9]
    PC_Source  = function_vals[func_sel][10]
    MEM_Slice  = function_vals[func_sel][11]
    Comparison = function_vals[func_sel][12]
    return (make_instruction(opcode, funct3, funct7), ALUSrc, ALUControl, ImmType, ResultSrc, MemWrite, RegWrite, RegRead, PC_Source, MEM_Slice, Comparison)




def edge_cases():

    write_assignment("s_instruction", 32, 0x00000000)
    write_assertion("s_ALU_src", 1, 0b0, message=f"Case {case_num} failed")
    write_assertion("s_ALU_control", 3, 0b000, message=f"Case {case_num} failed")
    write_assertion("s_imm_type", 3, 0b000, message=f"Case {case_num} failed")
    write_assertion("s_result_src", 2, 0b00, message=f"Case {case_num} failed")
    write_assertion("s_mem_write", 1, 0b0, message=f"Case {case_num} failed")
    write_assertion("s_reg_write", 1, 0b0, message=f"Case {case_num} failed")
    write_assertion("s_reg_read", 1, 0b0, message=f"Case {case_num} failed")
    write_assertion("s_PC_source", 2, 0b00, message=f"Case {case_num} failed")
    write_assertion("s_mem_slice", 3, 0b000, message=f"Case {case_num} failed")
    write_assertion("s_comparison", 3, 0b000, message=f"Case {case_num} failed")
    increment_case()

def example_case():
    global f
    for i in range(1,34):
        a = gen_function(i-1)
        f.write(f"        --Test Case {i}:\n")
        write_assignment("s_instruction", 32, a[0])
        write_assertion("s_ALU_src", 1, a[1], message=f"Case {case_num}: s_ALU_src failed")
        write_assertion("s_ALU_control", 3, a[2], message=f"Case {case_num}: s_ALU_control failed")
        write_assertion("s_imm_type", 3, a[3], message=f"Case {case_num}: s_imm_type failed")
        write_assertion("s_result_src", 2, a[4], message=f"Case {case_num}: s_result_src failed")
        write_assertion("s_mem_write", 1, a[5], message=f"Case {case_num}: s_mem_write failed")
        write_assertion("s_reg_write", 1, a[6], message=f"Case {case_num}: s_reg_write failed")
        write_assertion("s_reg_read", 1, a[7], message=f"Case {case_num}: s_reg_read failed")
        write_assertion("s_PC_source", 2, a[8], message=f"Case {case_num}: s_PC_source failed")
        write_assertion("s_mem_slice", 3, a[9], message=f"Case {case_num}: s_mem_slice failed")
        write_assertion("s_comparison", 3, a[10], message=f"Case {case_num}: s_comparison failed")
        increment_case()
        f.write('\n')
    




def main():
    global f
    # Create outputs folder if it doesn't exist
    output_dir = os.path.dirname(FILE_NAME)
    if output_dir and not os.path.exists(output_dir):
        os.makedirs(output_dir)
    
    with open(FILE_NAME, 'w', encoding='utf-8') as f1:
        f = f1
        edge_cases()
        example_case()

    f.close()

main()