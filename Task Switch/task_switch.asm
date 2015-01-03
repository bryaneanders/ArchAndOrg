.data

.align 2

str0:   .asciiz "123"
str1:   .asciiz "456"

.align 2
qcount: .word 400
tid: .word 0

.align 2
tcb0: .space 112
tcb1: .space  112

.globl main
.text
main:
	#initialize tid
	la $t0, tid
	lw $t0, 0($t0)
	addi $t0, $0, 0
	
	#initialize the tsk0 $ra
	la $a0, tcb0
	la $a1, task0
	sw $a1, 108($a0)
    sw $sp, 100($a0)
	
	#initialize the tsk1 $ra
	la $a0, tcb1
	la $a1, task1
	sw $a1, 108($a0)
    sw $sp, 100($a0)
	
	j	task0 
	
#----------------------------------------------------

task0:
	la   $t7, qcount
	lw   $t6, 0($t7)
	addi $t6, $t6, -1
	sw   $t6, 0($t7)
        beq  $t6, 0, qexit

        add  $t0, $0, $0     # sum = 0
        addi $t1, $0, 10     # multplyr = 10
        la   $s0, str0        # s0 = &str[0]

	jal ts
beg0:
        lb   $t2, ($s0)      # chr = *s0
        beq  $t2, $0, quit0  # bail out on chr==0 
        sub  $t2, $t2, '0'   # chr = chr -'0' make it int
        mult $t0, $t1        # sum = sum*multply
        mflo $t0
        add  $t0, $t0, $t2    # sum = sum + chr
        add  $s0, $s0, 1      # s0++ (advance to next addrs)
        b    beg0
quit0:
	add  $a0, $0, $t0
	addi $v0, $0, 1
	jal ts
	syscall
        j task0
qexit:
	addi $v0, $0, 10
	syscall


task1:
	la   $t7, qcount
	lw   $t6, 0($t7)
	addi $t6, $t6, -1
	sw   $t6, 0($t7)
        beq  $t6, 0, qexit1

        add  $t0, $0, $0     # sum = 0
        addi $t1, $0, 10     # multplyr = 10
        la   $s0, str1        # s0 = &str[0]
beg1:
        lb   $t2, ($s0)      # chr = *s0
        beq  $t2, $0, quit1  # bail out on chr==0 
        sub  $t2, $t2, '0'   # chr = chr -'0' make it int
        mult $t0, $t1        # sum = sum*multply
        mflo $t0
        add  $t0, $t0, $t2    # sum = sum + chr
        add  $s0, $s0, 1      # s0++ (advance to next addrs)
        b    beg1
quit1:
	add  $a0, $0, $t0
	addi $v0, $0, 1
	jal ts
	syscall
        j task1

qexit1:
	addi $v0, $0, 10
	syscall


#----------------------------------------------------
ts:
addi $sp, $sp, -4
sw $t0, 0($sp)
lw  $t0,  tid
bnez $t0, to_task0
j to_task1

to_task1:
	
addi $t0, $0, 1
sw $t0, tid

lw $t0, 0($sp)

# store task 0 register values
sw  $a0,  0($sp)
la $a0,  tcb0

sw $v0, 0($a0)
sw $v1, 4($a0)
sw $a1, 12($a0)
sw $a2, 16($a0)
sw $a3, 20($a0)
sw $t0, 24($a0)
sw $t1, 28($a0)
sw $t2, 32($a0)
sw $t3, 36($a0)
sw $t4, 40($a0)
sw $t5, 44($a0)
sw $t6, 48($a0)
sw $t7, 52($a0)
sw $s0, 56($a0)
sw $s1, 60($a0)
sw $s2, 64($a0)
sw $s3, 68($a0)
sw $s4, 72($a0)
sw $s5, 76($a0)
sw $s6, 80($a0)
sw $s7, 84($a0)
sw $t8, 88($a0)
sw $t9, 92($a0)
sw $gp, 96($a0)
sw $sp, 100($a0)
sw $fp, 104($a0)
sw $ra, 108($a0)

lw $t0, 0($sp)
addi $sp, $sp, 4
sw $t0, 8($a0)

# load in task 1

la $a0, tcb1

lw $v0, 0($a0)
lw $v1, 4($a0)
lw $a1, 12($a0)
lw $a2, 16($a0)
lw $a3, 20($a0)
lw $t0, 24($a0)
lw $t1, 28($a0)
lw $t2, 32($a0)
lw $t3, 36($a0)
lw $t4, 40($a0)
lw $t5, 44($a0)
lw $t6, 48($a0)
lw $t7, 52($a0)
lw $s0, 56($a0)
lw $s1, 60($a0)
lw $s2, 64($a0)
lw $s3, 68($a0)
lw $s4, 72($a0)
lw $s5, 76($a0)
lw $s6, 80($a0)
lw $s7, 84($a0)
lw $t8, 88($a0)
lw $t9, 92($a0)
lw $gp, 96($a0)
lw $sp, 100($a0)
lw $fp, 104($a0)
lw $ra, 108($a0)	

lw $a0, 8($a0)

jr $ra

#--------------------------------------------------------
to_task0:

addi $t0, $0, 0
sw $t0, tid

lw $t0, 0($sp)

# store task 1 register values
sw  $a0,  0($sp)
la $a0,  tcb1

sw $v0, 0($a0)
sw $v1, 4($a0)
sw $a1, 12($a0)
sw $a2, 16($a0)
sw $a3, 20($a0)
sw $t0, 24($a0)
sw $t1, 28($a0)
sw $t2, 32($a0)
sw $t3, 36($a0)
sw $t4, 40($a0)
sw $t5, 44($a0)
sw $t6, 48($a0)
sw $t7, 52($a0)
sw $s0, 56($a0)
sw $s1, 60($a0)
sw $s2, 64($a0)
sw $s3, 68($a0)
sw $s4, 72($a0)
sw $s5, 76($a0)
sw $s6, 80($a0)
sw $s7, 84($a0)
sw $t8, 88($a0)
sw $t9, 92($a0)
sw $gp, 96($a0)
sw $sp, 100($a0)
sw $fp, 104($a0)
sw $ra, 108($a0)

lw $t0, 0($sp)
addi $sp, $sp, 4
sw $t0, 8($a0)

# load in task 0
	
la $a0, tcb0

lw $v0, 0($a0)
lw $v1, 4($a0)
lw $a1, 12($a0)
lw $a2, 16($a0)
lw $a3, 20($a0)
lw $t0, 24($a0)
lw $t1, 28($a0)
lw $t2, 32($a0)
lw $t3, 36($a0)
lw $t4, 40($a0)
lw $t5, 44($a0)
lw $t6, 48($a0)
lw $t7, 52($a0)
lw $s0, 56($a0)
lw $s1, 60($a0)
lw $s2, 64($a0)
lw $s3, 68($a0)
lw $s4, 72($a0)
lw $s5, 76($a0)
lw $s6, 80($a0)
lw $s7, 84($a0)
lw $t8, 88($a0)
lw $t9, 92($a0)
lw $gp, 96($a0)
lw $sp, 100($a0)
lw $fp, 104($a0)
lw $ra, 108($a0)	

lw $a0, 8($a0)

jr $ra

































