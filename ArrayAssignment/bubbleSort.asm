# By Bryan Anders
#   Architecture And Organization
#   Fall 2014

.data

arrLength: .word 10 
array: .word 9, 3, 12, -1, -2, -3, 10, 20, 15, 7 

betweenPrints: .asciiz " : "
newline: .asciiz "\n"

.text
.globl main
main:

addi $t7, $t7, 0
addi $t4, $0, 4
lw $s0, arrLength
add $s0, $s0, $s0
add $s0, $s0, $s0
sub $t6, $s0, $t4

addi $s2, $0, 0


bubbleloop:
la $a1, array
addi $s3, $0, 0
addi $s2, $s2, 4
beq $s2, $s0, printInit
j bubbleloop2

bubbleloopUnsigned:
la $a1, array
addi $s3, $0, 0
addi $s2, $s2, 4
beq $s2, $s0, printInit
j bubbleloop2Unsigned

bubbleloop2:
j swapSigned

bubbleloop2Unsigned:
j swapUnsigned

swapSigned:
lw $t0, 0($a1)
lw $t1, 4($a1)
bge $t1, $t0, loop2increment
sw $t0, 4($a1)
sw $t1, 0($a1)
j loop2increment

swapUnsigned:
lw $t0, 0($a1)
lw $t1, 4($a1)
bgeu $t1, $t0, loop2incrementUnsigned
sw $t0, 4($a1)
sw $t1, 0($a1)
j loop2incrementUnsigned

loop2increment:
addi $a1, $a1, 4
addi $s3, $s3, 4
beq $s3, $t6, bubbleloop
j bubbleloop2

loop2incrementUnsigned:
addi $a1, $a1, 4
addi $s3, $s3, 4
beq $s3, $t6, bubbleloopUnsigned
j bubbleloop2Unsigned
 
printInit:
la $a1, array
addi $s2, $0, 0
j print
 
print:
beq $s2, $s0, prepareUnsigned

lw $a0, ($a1)
addi $v0, $0, 1
syscall

addi $a1, $a1, 4
beq $s2, $s0, prepareUnsigned
addi $s2, $s2, 4

la $a0, betweenPrints
addi $v0, $0, 4
syscall
j print

prepareUnsigned:
bne $t7, $0, quit
addi $t7, $0, 1

addi $s2, $0, 0

la $a1, array
la $a0, newline
addi $v0, $0, 4
syscall
 
j bubbleloopUnsigned
 
quit:
jr $ra 	# eof
