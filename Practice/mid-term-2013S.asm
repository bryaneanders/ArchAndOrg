# cscd260 test No.1
#
# There are 3 problems.
#
# Follow the direction CAREFULLY!
#

# (1) 
# Upload your file under LastnameFirstnameInitialE1 titile

# For example, kosuke Imamura, it will be "imamurakE1"

# Your filename be "imamurakE1.asm".

#

# (2)
# If you want to skip a question, do not write anycode for that section.
#
# (3)
# Your code must be in between BEGIN and END
# 



#
# There are 4 problmes.
#
# The problems would look like below if written in a high level.
#
#  int nnum;
#  int nums[] = {-1,4,-1,-9,-56,78,4,-9,-56,-77,78,98,98,78};
#  main()
#  { print myname;                              // problem 1
#    ennum = read_integer_from_keyboad;         // problem 2 
#    sum = 0;   
#    for(i=0; i<ennum; i++) sum = sum + num[i];
#    print sum;                                 // problem 3
#    n = read_integer_from_keyboad;
#    for(i=0; i<nnum; i++)
#     if( num[i]==n ) print n;                  // problem 4
#  }



# Coding starts HERE:

.data                             ################################   
myname: .asciiz "Bryan Anders"  # Change this to your real name 
#space: .asciiz "    "
#enterInt: .asciiz "Enter an integer:   "

                                  ################################
.align 2
nnum: .word 14   # number of numbers of array below 
nums: .word -1, 4, -1, -9, -56, 78, 4, -9, -56, -77, 78, 98, 98, 78

.align 2
ennum: .word 999
enums: .space 56

###################################################
# If you need any data/storage, allocate them here!
###################################################

# BEGIN



# END


.globl main
.text
main:

########### problem 1 (10% ) ############################################
# Change "Kosuke Imamura" in the above .data section to your own name.
# Use syscall (service no. 4) to print 'myname'
#########################################################################

# BEGIN

la $a0, myname
addi $v0, $0, 4
syscall

# END


########### problem 2 ( 10% ) ################################
# Get an integer from the keyboard. And, store that integer 
# into ennum in the .data section above, overwriting 999. 
#############################################################

# BEGIN

#addi $v0, $0,  4
#la $a0, enterInt
#syscall

addi $v0, $0, 5
syscall
la $t0, ennum
sw $v0, 0($t0)


# END

   la $a0, ennum
   lw $a0, 0($a0)
   addi $v0, $0, 1
   syscall

########### problem 3 (40%) #################################
# Add the first N words in nums[ ],N being the number in ennum.
# And display the sum.
# For example, if I entered 3 in problem 2, then 
# you would add 3 words; -1, 4, -1. And, the display would be 4.
#############################################################


# BEGIN

addi $t0, $0, 0 		# sum
addi $t1, $0, 0		# counter
lw $t2, ennum		# number to count to 
lw $t3, nnum			# number of elements in the array
la $t4, nums			# address of the array 

adding:
beq $t1, $t3, finished	# check if the we have read all the numbers out of the array
beq $t1, $t2, finished

lw $t5, 0($t4)				# load the current number into a temp registry
add $t0, $t0, $t5		# add to the sum

addi $t1, $t1, 1			# increment the counter
addi $t4, $t4, 4			# move to the next integer in the array

j adding 

finished:

la $a0, 0($t0)
addi $v0, $0, 1
syscall

# END

########### problem 4 ( 40% ) ################################
# Get an integer from the keyboard.
# Go through the array, nums[], and if a word in nums[i] is the 
# same as the integer typed in then print that number.
# For example, if I entered 78 in problem 3, then 
# you would display 787878.
#############################################################


# BEGIN



addi $v0, $0, 5
syscall
la $t7, 0($v0)		# the number to check against the current element

addi $t1, $0, 0		# counter
lw $t2, ennum		# number to count to 
lw $t3, nnum			# number of elements in the array
la $t4, nums			# address of the array 

check_equal_values:
beq $t1, $t3, ending
lw $t5, 0($t4)					# load the current array element into a temp register
addi $t1, $t1, 1				# increment the counter
addi $t4, $t4, 4				# increment the array 

bne $t7, $t5, check_equal_values

la $a0,  0($t7)
addi $v0, $0, 1
syscall

j check_equal_values

ending:

# END





####  exit code     ####

addi $v0, $0, 10

syscall

########################
