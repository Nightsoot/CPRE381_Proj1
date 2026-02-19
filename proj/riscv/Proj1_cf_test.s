
.text
li a3 0xFFFFFFFF
li a2 -1
li a4 0xFFFFFFFF
li a5 0x800
li a1 0
li a6 12

jal ra, foo
#a0 = 20 + 10 + 5 + 40 + a6 = 87
#auipc ra, %pcrel_hi(big_jump)
#jalr ra, ra %pcrel_lo(big_jump)
wfi

foo: 
beq a1, a6, skip  #terminate the deal at a2 = 10
bne a2, a3, skip2  #a2 != -1
addi a2 a2 3 #a2 = a2 + 2
addi a0 a0, 20
beq zero, zero cond
skip2:
bgeu a2, a3, skip3 #a2 >= FFFFFFFF (1)
li a3, 1
addi a0 a0, 10
beq zero, zero cond
skip3:
blt a2, a4, skip4 # a2 < -1 (5) 
li a4 100
addi a0 a0, 5
beq zero, zero cond
skip4:
bltu a5, a2 skip5 # (0xFFFFFFFFF)
li a5, 0x0
addi a0 a0, 40
beq zero, zero cond
skip5:
addi a1 a1 1
addi a0 a0 1
cond:
addi sp, sp -4 #allocate the stack
sw ra 0(sp) #store the return address
jal ra foo #recursive call
lw ra 0(sp) # get back the return address
addi sp, sp 4 #deallocate the stack
skip: jalr zero, ra, 0 #return

wfi #block from programming running off


big_jump:
slli a2 a2 1 # a2 * 2
wfi

