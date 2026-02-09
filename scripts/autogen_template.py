import numpy as np
import math
import random
import os

#MAKE SURE TO MAKE AN OUTPUTS FOLDER BEFOREHAND

#change this for different .txt output
FILE_NAME = os.getcwd().replace("\\", "/") + "/outputs/" "example" + ".txt"
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



def example_case():
    global f
    for i in range(1,101):
        a = random.randint(-2**31, 2**31-1)
        b = random.randint(-2**31, 2**31-1)
        f.write(f"--Test Case {i}:\n")
        write_assignment("i_A", 32, a)
        write_assignment("i_B", 32, b)
        write_assertion("i_S", 32, (a+b) & 0xFFFFFFFF, message=f"Case {i} failed")
        f.write('\n')
    




def main():
    global f 
    with open(FILE_NAME, 'w', encoding='utf-8') as f1:
        f = f1
        example_case()

    f.close()

main()