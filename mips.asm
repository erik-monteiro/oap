
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
	move $s0, $v0 # int m = getchar();
	blt $s0, $zero, exit # se m < 0 go to exit
	
	li $v0, 5
	syscall
	move $s1, $v0 # int n = getchar();
	blt $s1, $zero, exit # se n < 0 go to exit
	
	move $a0, $s0 # $a0 = m
	move $a1, $s1 # $a1 = n
	jal ackermann # go to ackermann
	move $s2, $v0 # result guarda em $s2
	
	li $v0, 1 # print int
	move $a0, $s2 # argumento da função = result
	syscall	
	
ackermann:
	addi $sp, $sp, -12 # aloca 12 bytes na pilha
	sw $ra, 0($sp) # salva $ra na pilha
	sw $s0, 4($sp) # coloca variável 'm' na pilha
	sw $s1, 8($sp) # coloca variável 'n' na pilha
	
	move $s0, $a0 # $s0 = m
	move $s1, $a1 # $s1 = n
	move $s2, $zero

	beq $s0, $zero, recursao1 # se m == 0 go to recursao1
	
	
recursao1:
	addi $s2, $s1, 1 # result = n + 1
	li $v0, 1
	move $a0, $s2
	syscall

exit:
	li $v0, 10 # exit
  	syscall
  	
.data
	string1: .asciiz "Programa Ackermann​\n"
	string2: .asciiz "Componentes: <Gabriel Verdi, Erik Monteiro>​\n"
	string3: .asciiz "Digite os parâmetros m e n para calcular A(m, n) ou -1 para abortar a execução\n"
	result: .space 4 # int result;
	resultPrint: .asciiz "A(%d, %d) = %d\n"
	.align 2    
