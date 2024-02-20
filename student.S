##############################################################################
#
# File: student.S
#
# Description:
#   This file contains skeleton source code that students should complete so
#   that it performs the computations required in the Machine Problem handout.
#
##############################################################################

.text

/*
 * Function: findHypSq
 *
 * Description:
 *  Given the two sides of a right triangle, compute the square of the
 *  hypotenuse.
 *
 * Inputs:
 *  %rdi - Integer length of the first side of the right triangle.
 *  %rsi - Integer length of the second side of the right triangle.
 *
 * Return value:
 *  %rax - The square of the length of the hypotenuse as an integer.
 *
 * Notes:
 *  This function does not check for integer overflow.  Therefore, the return
 *  value may be less than either input.
 */

.global findHypSq
.type findHypSq, @function
findHypSq:
  //calculate a^2
  movq %rdi,%rax
  imulq %rax,%rax

  //calculate b^2
  movq %rsi,%rdx
  imulq %rdx,%rdx

  //calculate a^2 + b^2
  addq %rdx, %rax
  ret

/*
 * Function: ratio
 *
 * Description:
 *  Given integers a, b, and c in the ratio a/b = c/d, compute the value of
 *  the integer d.
 *
 * Inputs:
 *  %rdi - The value of a.
 *  %rsi - The value of b.
 *  %rdx - The value of c.
 *
 * 
 * Return value:
 *  %rax - the value of d from the ratio function as an integer. (d = b*c/a)
 *
 * Notes:
 *  This function does not check for integer overflow or underflow.  Therefore,
 *  the return value may be incorrect.
 */
.global ratio
.type ratio, @function
ratio:
  movq %rsi, %rax
  //calculate b*c
  mulq %rdx
  //calculate b*c/a
  divq %rdi
  ret

/*
 * Function: changeCard
 *
 * Description:
 *  Given a 64-bit input that which each 8-bit represents a card. This function  *  increment the number and suite of all 8 cards. If the value is at the        *  maximum value, it should wrap around to the minimum value.
 *
 * Inputs:
 *  %rdi - A 64-bit integer representing a set of eight cards.  Each byte
 *         represents one card: the first nibble represent the suite, and the
 *         second nibble represents the value of the card.
 *
 * Return value:
 *  %rax - The set of eight cards in which the suite and card value of each
 *         card is incremented.
 */
.global changeCard
.type changeCard, @function
changeCard:
 
  //increment all cards' suite and number by 1 
  movq %rdi, %rax
  movq $0x1111111111111111, %rsi
  addq %rsi, %rax

  //set the iteration number
  movq $8, %rcx

loop_start:
  //check if the loop needs to continue
  cmpq $0, %rcx
  jle end_of_loop

  //extract last byte from the input
  movq %rax, %rdx
  andq $0xFF, %rdx
  //store number and suite separately
  //r8 for number
  movq %rdx, %r8
  //r9 for suite
  movq %rdx, %r9
  //get value
  andq $0x0F, %r8
  //get suite
  shrq $4, %r9
 
  //check if number needs wrap around
  cmpq $0x0D, %r8
  jae number_wrap
  jmp compare_suite

compare_suite:
  //checks if suite needs wrap around
  cmpq $0x04, %r9
  jae suite_wrap
  jmp done

number_wrap:
  //number wrap around
  subq $0x0D, %r8
  jmp compare_suite

suite_wrap:
  //suite wrap around
  subq $0x04, %r9
  jmp done

done:
  //put suite and number of extracted card to the head of the input
  shrq $8, %rax
  shlq $56, %r8
  orq %r8, %rax
  shlq $60, %r9
  orq %r9, %rax

  //loop finishes
  decq %rcx
  jmp loop_start

end_of_loop:
 ret

