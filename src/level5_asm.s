# RISC-V Assembly Warmup Recitation
# Joseph Ravichandran
# MIT Secure Hardware Design Spring 2023
#
# MIT License
# Copyright (c) 2022-2023 Joseph Ravichandran
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

.global lab_start
.section .text

lab_start:
	/* Do our usual stack setup */
	add sp, sp, -16
	sw fp, 0(sp)
	sw ra, 4(sp)
	add fp, sp, 16

	/* Welcome to level 5!
	 *
	 * This level asks you to extend the ROP attack at level 4.
   * At Level 4, the victim has the "/bin/sh" string stored
   * in a static memory region that you can conveniently locate.
   * At level 5, this is no longer the case.
	 *
   * You need to prepare the "/bin/sh" string on the stack.
   * And you will need to make sure the string will not be
   * overwritten by other code in the victim.
	 */

	/* Recall the stack:
	 *
	 * +----------------------+
	 * | Saved Frame Pointer  | <- sp
	 * +----------------------+
	 * | Saved Return Address |
	 * +----------------------+
	 * |    4 Bytes Padding   |
	 * +----------------------+
	 * |    4 Bytes Padding   |
	 * +----------------------+
	 */

	/* Tell user where win() is located */
	la a0, win_is_str
	call puts
	la a0, win
	call put_int
	la a0, newline_str
	call puts

	/* Print prompt */
	la a0, prompt_str
	call puts

	/* Read into stack */
	mv a0, sp
	call gets

	la a0, newline_str
	call puts

leave_lab_start:
	/* Print out the address we are jumping to */
	la a0, ra_is_str
	call puts
	lw a0, 4(sp)
	call put_int
	la a0, newline_str
	call puts

	/* Perform the usual stack tear-down */
	lw fp, 0(sp)
	lw ra, 4(sp)
	add sp, sp, 16

	/* If the overflow was successful, ra now points to win! */
	ret

/* Here are some gadgets for you to try! */
/* Get their addresses using objdump! */
/* riscv64-unknown-elf-objdump -d [object.o] */

# a2 <- a1 + 4
gadget_a:
	add a2, a1, 4
	lw ra, 0(sp)
	add sp, sp, 4
	ret

# a1 <- stack.pop()
gadget_b:
	lw a1, 0(sp)
	lw ra, 4(sp)
	add sp, sp, 8
	ret

# a0 <- a2
gadget_c:
	mv a0, a2
	lw ra, 0(sp)
	add sp, sp, 4
	ret

# stack.pop(4)
gadget_d:
  add sp, sp, 16
	lw ra, 0(sp)
	add sp, sp, 4
	ret

win_is_str:
.string "win() is at: "

prompt_str:
.string "Enter some text: "

ra_is_str:
.string "Returning to: "

newline_str:
.string "\r\n"

