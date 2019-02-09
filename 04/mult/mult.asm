// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

	@sum 
	M=0      //sum = 0
	@R1
	D=M
	@counter //RAM[0]
	M=D

(LOOP)
	@counter
	D=M
	@END
	D;JEQ    // If count is 0 -> goto END
	@R0
	D=M
	@sum
	M=M+D    // adding sum to prev. sum
	@counter
	M=M-1    // deincrementing counter
	@LOOP
	0;JMP    // Loop over again

(END)
	@sum
	D=M      // final sum amount
	@R2
	M=D      // after all loops done, write sum to RAM[2]