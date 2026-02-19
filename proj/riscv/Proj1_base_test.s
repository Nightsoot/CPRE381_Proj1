.data

a: .word 1 2 15 7 8 12

.text

addi s0, x0 1
addi s1, x0 2
sll t0, s0, s1 # t0 should be 4
slli t1, s1, 2 # t1 should be 8
addi s2, x0, -2
addi s3, x0, -6
sra t2, s2, s0 # t2 should be -1
srai t3, s3, 1 # t3 should be -3
srl t4, s2, s0
srli t5, s3, 2
li s4 0x10010000
sw t0, 0(s4)
lw s5, 0(s4)
add t0, s5, s1
lw t1, 4(s4)
sub t2, t1, t0
lui t3, 0xFFFFF
addi t3 t3 -1
lui t4, 0xAAAAA
addi t4 t4 -556
and t5 t3, t4
li t0 0x543
li t1 0xA18
or t2, t0, t1
xor t3, t5, t2
li t0, 5
andi t1, t0, 1
ori  t2, t1, 2
xori t3, t2, 6
auipc t5, 14


wfi