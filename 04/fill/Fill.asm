// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

(BLKSCREEN)    // fills every pxl when key pressed
	@KBD       // keyboard register
	D=M        // keyboard register set to D
	@WHTSCREEN // white loop if spec met
	D;JEQ      // jump to white if key entry == 0
	@24575	   // screens last pxl
	D=M        // screens last pxl set to D
	@WHTSCREEN // white loop if spec met
	D;JLT      // jump to white loop if last pxl filled
	@i         // register i
	D=M        // i set to D
	@16384	   // screens first pxl
	D=A+D	   // register = screen + i
	A=D		   // register set
	M=-1	   // fills all pxl in register
	@i         // register i
	M=M+1	   // increment i
	@BLKSCREEN // 
	0;JMP      // null, back to black loop

(WHTSCREEN)    // Removes every pxl if key not pressed
	@KBD       // keyboard register
	D=M        // keyboard register set to D
	@BLKSCREEN // to black loop if spec met
	D;JGT      // jump to black loop if keyboard == 1
	@i         // register i
	D=M        // register i is set to D
	@16384     // screens first pxl
	D=A+D      // register set to screen + i
	A=D        // register set
	M=0        // register set to 0, remove all filled pxl
	@i         // register i
	M=M-1      // deinc i memory
	@WHTSCREEN // goes to beginning of loop
	0;JMP      // null , back to white loop