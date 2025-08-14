data
c: .word 0
 .text
 .globl main
main:
 # initialize c = 0
 la $t2, c
 li $t0, 0
 sw $t0, 0($t2)
 # outer loop: i = 0; i < 1000; i++
 li $t3, 0 # i
outer:
 bge $t3, 1000, done_outer
 # inner loop: j = 0; j < 5; j++
 li $t4, 0 # j
inner:
 bge $t4, 5, done_inner
 # c++
 lw $t0, 0($t2)
 addi $t0, $t0, 1
 sw $t0, 0($t2)
 addi $t4, $t4, 1 # j++
 j inner
done_inner:
 addi $t3, $t3, 1 # i++
 j outer
done_outer:
 # return c in $v0
 lw $v0, 0($t2)
 jr $ra