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
 *  %rdi - Length of the first side of the right triangle.  It must be
 *         non-zero.
 *  %rsi - Length of the second side of the right triangle.  It must be
 *         non-zero.
 *
 * Return value:
 *  %rax - The square of the length of the hypotenuse.  If there is overflow,
 *         the code should return the value 0.
 */
.global findHypSq
.type findHypSq, @function
findHypSq:
  /*
   *Question:  Can we assume our inputs are integers?
   */

  //calculate a^2 and checks if overflow
  movq %rdi, %rax
  imulq %rax,  %rax
  jc overflow

  //calculate b^2 and checks if overflow
  movq %rsi, %rdx
  imulq %rdx, %rdx
  jc overflow

  //add a^2 and b^2 and checks if overflow
  addq %rdx, %rax
  jc overflow

  retq

overflow:
  //return 0 if overflow
  movq $0, %rax

  retq

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
 * Return value:
 *  %rax - the value of d calculated by multiplying b and c and then divided by  *  a. Return -1 if overflow and return -2 if the divisor is 0.
 */
.global ratio
.type ratio, @function
ratio:
  //multiply b and c and checks if overflow
  movq %rsi, %rax
  mulq %rdx
  //use jc for unsigned numbers and jo for signed number overflow
  jc overflow_ratio

  //check if the divisor is 0. If not, divided previous result by a.
  cmpq $0, %rdi
  je zero_division

  retq
  
overflow_ratio:
  //return -1 if overflow
  movq $-1, %rax

  retq
zero_division:
  //return -2 if divosor is 0
  movq $-2, %rax

  retq

/*
 * Function: fib
 *
 * Description:
 *  Given value n, calculate the F(n) which F is Fibonacci sequence.
 *
 * Inputs:
 *  %rdi - integer n to indicate which place of the sequence to calculate for.
 *
 * Return value:
 *  %rax - the nth element in Fibonacci sequence.
 */
.global fib
.type fib, @function
fib:
  //store first two elements in rax and rbx, store n in rcx
  movq $0, %rax
  movq $1, %rbx
  movq %rdi, %rcx

  //if n=0, return 0
  cmpq $0, %rcx
  je return

  //if n=1, return 1
  cmpq $1, %rcx
  je return

loop:
  //store previous n-1 in antoher register
  movq %rbx, %rdx
  //update n-1
  addq %rax, %rbx
  //update n-2 (copy previous n-1 from rdx)
  movq %rdx, %rax
  //decrement loop count n
  decq %rcx
  //end loop when n reqches 0
  cmpq $0, %rcx
  jne loop

  retq

return:
  //return rax
  movq %rcx, %rax
  retq


