
 .text
	.globl main

main:
	la $a0, string1 # carrega endereço da string1
	li $v0, 4 # load immediate print_string
	syscall
	la $a0, string2
	li $v0, 4
	syscall
	j lerValoresEPrintarResultado # go to lerValoresEPrintarResultado func
	
lerValoresEPrintarResultado:
	la $a0, string3 # carrega endereço da string3
	li $v0, 4 # load immediate print_string
	syscall
	
	li $v0, 5 #​ le inteiro 
	syscall 
	move $t0, $v0 # int m = getchar();
	blt $t0, $zero, exit # se m < 0 go to exit
	
	li $v0, 5
	syscall
	move $t1, $v0 # int n = getchar();
	blt $t1, $zero, exit # se n < 0 go to exit
	
	subi $sp, $sp, 12 # aloca 12 bytes na pilha
	sw $t0, 4($sp) # coloca variável 'm' na pilha
	sw $t1, 8($sp) # coloca variável 'n' na pilha
	sw $ra, 0($sp) # salva $ra na pilha
	jal ackermann # go to ackermann
	
ackermann:
	lw $a0, 4($sp) # $a0 = m
	lw $a1, 8($sp) # $a1 = n
	
	beq $a0, $zero, recursao1 # se m == 0, go to recursao1

recursao1:
	addi $a1, $a1, 1 # result = n + 1
	subi $sp, $sp, 8 # aloca 8b na pilha

exit:
	li $v0, 10 # exit
  	syscall
  	
.data
	string1: .asciiz "Programa Ackermann​\n"
	string2: .asciiz "Componentes: <Gabriel Verdi, Erik Monteiro, Henrique>​\n"
	string3: .asciiz "Digite os parâmetros m e n para calcular A(m, n) ou -1 para abortar a execução\n"
	result: .space 4 # int result;
	resultPrint: .asciiz "A(%d, %d) = %d\n"
	.align 2    