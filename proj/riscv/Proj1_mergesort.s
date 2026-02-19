.data
arr: .word 1, 5, 2, 10, 1, 3, 2, 8, 0, 1
.text

#get arr in
la a2 arr
#left and right bounds of the arr
li a3 0
li a5 9

jal ra, merge_sort 

j die

#a3, a4, a5 left, mid, right respectively, a2 is arr
#this is a leaf function so ra doesn't need to be stored
merge:

#allocate room for local variables
sub t0 a5 a3 
addi t0 t0 1 #num elements
slli t0 t0 2 #num bytes in array
sub sp sp t0 #allocate a subarray worth of bytes on the stack

sub t0 a4, a3
addi t0 t0 1 #n1 = mid - left + 1
sub t1 a5 a4 #n2 = right - mid
lui t2 0 #i = 0
lui t3 0 #j = 0
mv t4, a3 # k = left
slli t4, t4, 2 #k * 4 to ptr math

mem_copy_L: bge t2 t0 end_copy_L #copy arr[left:mid] to L
slli t5 t2 2 # *4 for word-aligned
sub t5 sp t5
add t6, t2, a3 #add on left_index 
slli t6 t6 2 # *4 for word-aligned
add t6 t6 a2
lw t3 0(t6)
sw t3 0(t5) #t0 = L[i]
addi t2 t2 1
j mem_copy_L
end_copy_L: 

li t3 0

mem_copy_R: bge t3 t1 end_copy_R #copy arr[mid+1:right] to R
add t5 t3 t0 #add j and n1 offset

slli t5 t5 2 #*4 for word index
sub t5 sp t5 #offset the stackpointer
add t6, t3, a4 #move j + mid + 1 into t6
addi t6, t6, 1
slli t6 t6 2
add t6 t6 a2
lw t2 0(t6)
sw t2 0(t5)
addi t3 t3 1 #j++
j mem_copy_R
end_copy_R: 

li t2 0
li t3 0


merge_loop: 


bge t2, t0 end_merge_loop
bge t3, t1 end_merge_loop #jump if i >= n1 or j >= n2

#get index of L[i]
slli t5 t2 2 # *4 for word-aligned
sub t5 sp t5
lw t5 0(t5) #address no longer needed
#get index of R[j]
add t6 t3 t0 #add j and n1 offset
slli t6 t6 2 #*4 for word index
sub t6 sp t6 #offset the stackpointer
lw  t6 0(t6)

blt t6 t5 else1 #R[j] >= L[i] 
add t6 t4 a2 #get index of arr[k] t6 is no longer needed
sw t5 0(t6)
addi t2 t2 1 #i++
j end_cond1
else1:
add t5 t4 a2 #get index of arr[k] t5 is no longer needed
sw t6 0(t5)
addi t3 t3 1 #j++
end_cond1:
addi t4 t4 4 #k++ (ptr math)


j merge_loop

end_merge_loop:

left_cleanup_loop: bge t2 t0 end_left_cleanup_loop #i < n1

#get index of L[i]
slli t5 t2 2 # *4 for word-aligned
sub t5 sp t5
lw t5 0(t5) #address no longer needed

add t6 t4 a2 #get index of arr[k] t6 is no longer needed
sw t5 0(t6)
addi t2 t2 1 #i++
addi t4 t4 4 #k++

j left_cleanup_loop

end_left_cleanup_loop:

right_cleanup_loop: bge t3 t1 end_right_cleanup_loop #j < n2
#get index of R[j]
add t5 t3 t0 #add j and n1 offset
slli t5 t5 2 #*4 for word index
sub t5 sp t5 #offset the stackpointer
lw  t5 0(t5)

add t6 t4 a2 #get index of arr[k] t6 is no longer needed
sw t5 0(t6)
addi t3 t3 1 #j++
addi t4 t4 4 #k++
j right_cleanup_loop

end_right_cleanup_loop:
#deallocate room for local variables
sub t0 a5 a3 
addi t0 t0 1 #num elements
slli t0 t0 2 #num bytes in array
add sp sp t0 #deallocate a subarray worth of bytes on the stack


jalr zero, ra, 0


#a2 is arr, a3 and a5 are right
#a2 will not change
merge_sort:

blt a3, a5 skip # left < right
jalr zero, ra, 0 #if left >= right merge sort has hit its base case
skip:

addi sp sp -16

sub t0 a5 a3 # right - left
srli t0 t0 1 # (right - left)/2
add a4 t0 a3 #mid = left + (right - left)/2

#store left 
sw a3 0(sp)
sw a4 4(sp)
sw a5 8(sp)
sw ra 12(sp)

mv a5 a4 #right = mid
jal ra, merge_sort
lw a3 4(sp) # left = mid
addi a3 a3 1 # left = mid + 1
lw a5 8(sp) # right = right
jal ra, merge_sort
#get back all the arguments
lw a3 0(sp)
lw a4 4(sp)
lw a5 8(sp)

jal ra, merge
lw ra 12 (sp) #get back the return address
addi sp sp 16 # deallocate the stack
jalr zero, ra, 0 #return 

die: wfi



