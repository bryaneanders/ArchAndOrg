# By Bryan Anders
#   Architecture And Organization
#   Fall 2014

.data
#using $s0-$s3 for the 2 numbers and their sum and difference, respectively

askForInput : .asciiz  "Enter an Integer: "
sumResult: .asciiz "\nThe sum is: "
differenceResult: .asciiz "\nThe difference is: "
space: .asciiz " space "

.text
.globl main
main:

la $a0, askForInput
addi $v0, $0,  4
syscall 	# asking user for an integer

addi $v0, $0, 5
syscall 		# read an int

# copy int to variable
la $s0,  ($v0)



#repeat for a second variable 
la $a0, askForInput
addi $v0,  $0, 4
syscall 	# asking user for an integer

addi $v0, $0, 5
syscall 		# read an int

# copy int to variable
la $s1, ($v0)


add $s2, $s0, $s1 		# the sum
sub $s3, $s0, $s1 		# the difference

# print out the sum and difference
la $a0, sumResult
addi $v0, $0, 4
syscall

la $a0,  ($s2)
addi $v0, $0, 1
syscall

la $a0, differenceResult
addi $v0, $0, 4
syscall

la $a0,  ($s3)
addi $v0, $0, 1
syscall

jr $ra 	# eof
