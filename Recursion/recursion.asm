.data

num: .word 6
enterNum: .asciiz "Enter an integer: "
numIs: .asciiz "The number is " 
sumIs: .asciiz " and the sum is "

.text
.globl main
main:

lw $t0, num
addi $t3, $t0, 0 			# register to perform sigma on
addi $sp, $sp, -4
sw $t0, 0($sp)
jal recurse
jal print

addi $v0, $0, 10
syscall
jr $ra

recurse:
lw $t0, 0($sp)
bne $t0, $0, recurse2
jr $ra

recurse2:
addi $sp, $sp, -4		# decrement the stack pointer
sw $ra, 0($sp)			
addi $sp, $sp, -4		# decrement the stack pointer
addi $t0, $t0, -1			# decrement the number
sw $t0, 0($sp)

jal recurse

lw $t2, 0($sp)
addi $sp, $sp, 4
lw $ra, 0($sp)
addi $sp, $sp, 4

add $t3, $t3, $t2
jr $ra

print:

la $a0, numIs
addi $v0, $0, 4
syscall

lw $a0, num
addi $v0, $0, 1
syscall

la $a0, sumIs
addi $v0, $0, 4
syscall

la $a0, 0($t3)
addi $v0, $0, 1
syscall
jr $ra