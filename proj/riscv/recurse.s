li a0 6
jal ra foo
j end

foo:
bne a0 zero skip
jalr ra
skip:
addi a0 a0 -1
addi sp sp -4
sw ra 0(sp)
jal foo
lw ra 0(sp)
addi sp sp 4
jalr zero, ra, 0

end:
wfi