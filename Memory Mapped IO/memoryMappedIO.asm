#Bryan Anders
#Arch & Org
#Fall 2014

 .data	
 
 .align 2
 string: .space 100
 
# Main body
.globl main
.text
main:

    li $s0, '\n'
    la $s1, string
    
	li $t0, 0xffff0000
	
key_wait:
	
    lw      $t1, 0($t0)
	andi    $t1, $t1, 1  
    beqz   $t1,  key_wait

	lb     $a0, 4($t0)
	sb     $a0, 0($s1)    
	
    addi $s1, $s1, 1
    bne $a0, $s0, key_wait 
	sw $s3, 0($s1)
	
	addi $s3, $0, 0

	li $t0, 0xffff0008
    la $s1, string
	
printChar:

    lw      $t1, 0($t0)
	andi    $t1, $t1, 1 
    beqz   $t1,  printChar
	
	lb $s2, 0($s1)
	sb $s2, 4($t0)
   
    addi $s1, $s1, 1
    bne $s2, $zero, printChar

    jr      $ra