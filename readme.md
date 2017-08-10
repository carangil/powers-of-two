What Is This?
-------------

I recently attended VCF West at the Computer History Museum.  During the medium-iron restoration panel, someone mentioned the single-card powers of two program, which makes use of the variable-sized BCD buffers.  There was also a joke about this not being possible on x86, and I think someone also threw the figure of 10 instructions out there.

Here I have 55 byte x86 executable (for DOS) that computes and prints all the powers of 2 up to 255 decimal digits.  When taken as base64 (which gives 6 bits of data per character), this comes out to 77 columns.  But, it is not 10 instructions, instead 20, and it uses self modifying code.

I also have a 10 instruction version, which uses double-self modifying code to carve the 10 long instructions up into the above 20 instruction routine.  Unfortunaly, the 10 instruction version needs 2 of your punch cards.

List of files:


power2.asm: Straightforward implementation using x86 AAA instruction for working with BCD and ASCII number strings.  Only prints 10 digits, no carriage returns or newlines.  Just a test to see if the basic doubling and carry algorithm was correct.

p2small.asm:  Attempt to make it smaller with self-modifying code.  This version prints to 255 digits, and outputs carriage returns and newlines.  The executable is 55 bytes.  Base-64 encoded, this is 77 'columns.'


p2mov.com:  The final version.   It is 105 bytes, but the .com file contains only 10 instructions:


		org 100h
		section .text

		start:

		  mov dword [0x12d],0xbf0350b9

		  mov dword [0x139],0x37c0109e

		  mov dword [0x145],0xc766ee75

		  mov dword [0x151],0x09b40200

		  mov dword [0x15d],0x09014b06

		  mov dword [eax-0x3fceff01],0x200858a

		  mov dword [eax-0x77cf4f61],0x4f020085

		  mov dword [eax+0x3102ff06],0xba240a0d

		  mov dword [eax+0x6c621cd],0xc60c013e

		  mov dword [eax+0xc3cde2],0x000000000

	No hidden data.  Assemble the above with nasm -fbin -o p2mov.com p2mov.asm, and disassemble it, to get the same listing. The code is double-self-modifying: The first 5 instructions modify the last 5 instructions, which later modify themselves.


To build:

build.bash should work if you have nasm installed.

nasm <filename.asm>  -fbin -o <output.com>



To Run:
DOSBox is my x86 emulator of choice.  If it already installed:

dosbox -noautoexec <filename.com>


It should end at 2^848, which is 938439603600587528746394711938657107663969949193687942084737423845328945327403963493426274822541422606069252398088182827397836333287780407720182613329988145004965865323862822167078543736143176539997470989737828269291292380585577139908076735904949708259328

Hints
--------

In the workflow directory, there are files with ever-increasing-length filenames.  To turn p2small.asm to p2mov.asm, I padded the front with dummy patching code.  Then the file was hex-edited to make dummy long (but perfectly valid, but don't care execute) instructions.  The trick, is these instructions are 12 bytes long, with 8 bytes of programmer-controlled constants.  There are 5 of them, giving me 60 bytes of data.  But 4 of out each 12-byte packet is wrong.  The first 5 instructions then write DWORDS over those, making them the original p2small code.  The p2padded.com.hex.edited.com.disasm.asm.fixed file is the same as p2mov.asm.


Unsolved Problems
-----------------

x86 10 instructions AND <=60 bytes (one card)



