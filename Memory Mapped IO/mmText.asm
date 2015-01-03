.data
    ISO_LF              =   10  # Line feed (newline)
    SYS_PRINT_CHAR      =   11
    
    #########################################################################
    # Receiver control.  1 in bit 0 means new char has arrived.  This bit
    # is read-only, and resets to 0 when CONS_RECEIVER_DATA is read.
    # 1 in bit 1 enables hardware interrupt at interrupt level 1.
    # Interrupts must also be enabled in the coprocessor 0 status register.
    
    CONS_RECEIVER_CONTROL           =   0xffff0000
    CONS_RECEIVER_READY_MASK        =   0x00000001
    CONS_RECEIVER_DATA              =   0xffff0004
    
    # Main body
.globl main
.text
    main:
    
	    # Spin-wait for key to be pressed
    key_wait:
	    lw      $t0, CONS_RECEIVER_CONTROL
	    andi    $t0, $t0, CONS_RECEIVER_READY_MASK  # Isolate ready bit
	    beqz    $t0, key_wait
    
	    # Read in new character from keyboard to low byte of $a0
	    # and clear other 3 bytes of $a0
	    lbu     $a0, CONS_RECEIVER_DATA
	    
	    # Print character and newline
	    li      $v0, SYS_PRINT_CHAR
	    syscall
	    
	    li      $a0, ISO_LF
	    li      $v0, SYS_PRINT_CHAR
	    syscall
	    
	    jr      $ra