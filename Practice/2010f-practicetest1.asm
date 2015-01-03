# cscd260 test No.1
#
# There are 3 problems.
#
# Total X points
#
# Follow the direction CAREFULLY!
#
# Upload your file under LastnameFirstnameInitialE1 titile

# For example, kosuke Imamura, it will be "imamurakE1"

# Your filename be "imamurakE1.asm".

#
# You can skip questions, jump instructions will take you to 

# the next question. Your code must be in between problem description

# and jump instruction





.data
myname: .asciiz "Bryan Anders"  #Change this to your name
space: .asciiz " "
newline: .asciiz "\n"

.align 2         # this is for word boundary
nnum: .word 14   # number of numbers in an array below 
nums: .word -1, 4, 8, 9, -566, 78, 94, -9 -56, -77, 77, 89, 98, 1000
cpnm: .space 14*4

.globl main
.text
main:

########### problem 1 (1 point) ###########
# Change "FirstName LastName" in the above .data section to 
# print your own name.

la $a0, myname
addi $v0, $0, 4
syscall

la $a0, newline
addi $v0, $0, 4
syscall

   j p21   # your code for problem 1 ends here with this jump

########### problem 2.1 (7 point) ###########
# Add all the odd numbers in the array, and display the sum.
p21:

addi $t0, $0, 0		# the sum 
addi $t1, $0, 0 		# the counter 
lw $t2, nnum 		# the size of the array
la $t3, nums 			# the array 

add_odds:
beq $t1,  $t2, display_sum
lw $t4, 0($t3)
andi $t5, $t4,  1		# bitwise and the current value to see if it is odd


addi $t1, $t1, 1		# increment the counter
addi $t3, $t3, 4		# increment the array

beq $t5, $0, add_odds		
add $t0, $t0, $t4


j add_odds

display_sum:

la $a0, 0($t0)
addi $v0, $0, 1
syscall

la $a0, newline
addi $v0, $0, 4
syscall


   j p22   # your code for problem 2.1 ends here with this jump

########### problem 2.2 (7 point) ###########
# Copy the array "nums" into the array "cpnm", and print cpnm.
p22:

la $t0, nums
la $t1, cpnm
addi $t2, $0, 0		# the counter
lw $t3, nnum


copy_array:
beq $t2, $t3,  print

lw $t4, 0($t0)					# load the current word into a temp register
sw $t4, 0($t1)				# load the word from the temp register into the second array 

addi $t0, $t0, 4				# increment the arrays and counter 
addi $t1, $t1, 4
addi $t2, $t2, 1

j copy_array

print: 
la $t0, cpnm
addi $t1, $0, 0
lw $t2, nnum

print_loop:
beq $t1, $t2, exit

lw $a0, 0($t0)
addi $v0, $0, 1
syscall

la $a0, space
addi $v0, $0, 4
syscall

addi $t0, $t0, 4			# increment the array and counter
addi $t1, $t1, 1

j print_loop

exit: 

# your code for ends here






########
###  exit code     ####

addi $v0, $0, 10

syscall


