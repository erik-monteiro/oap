 .text
	.globl main

main:
	# --- Printa Strings ---
	la $a0, string1 
	li $v0, 4 
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
	
	la $a0, resultPrint # carrega endereço da string
	li $v0, 4 # load immediate print_string
	syscall
	li $v0, 1 # print int
	move $a0, $s2 # argumento da função = result
	syscall	# printa resultado ackermann(m, n)
	j lerValoresEPrintarResultado # repete o looping até serem digitados 'm' ou 'n' negativos
	
ackermann:
	addi $sp, $sp, -12 # aloca 12 bytes na pilha
	sw $ra, 0($sp) # salva $ra na pilha
	sw $s0, 4($sp) # coloca variável 'm' na pilha
	sw $s1, 8($sp) # coloca variável 'n' na pilha
	
	move $s0, $a0 # $s0 = m
	move $s1, $a1 # $s1 = n
	move $s2, $zero # result = 0

	beq $s0, $zero, recursao1 # se m == 0 go to recursao1
	bgt $s0, $zero, mMaiorQueZero # se m > 0 go to mMaiorQueZero
	
recursao1:
	addi $s2, $s1, 1 # result = n + 1
	j gerenciaPilha

mMaiorQueZero:
	beq $s1, $zero, recursao2 # se n == 0 go to recursao2
	bgt $s1, $zero, recursao3 # se n > 0 go to recursao3

recursao2:
	addi $a0, $s0, -1 # a0 : M = (m-1)
	addi $a1, $0, 1	# a1 : N = 1
        jal ackermann # recursão
        move $s2, $v0 # s2 = A(m-1,1)
	j gerenciaPilha
	
recursao3:
	move $a0, $s0 # a0 : M = m
	addi $a1, $s1, -1 # a1 : N = (n-1) zfhgk5gw3v
        jal ackermann
        move $a1, $v0 # a1 : N = A(m,n-1)
        addi $a0, $s0, -1 # a0 : M = (m-1)
        jal ackermann # recursão
        move $s2, $v0 # s2 = A(m-1, A(m,n-1))
        j gerenciaPilha
        
gerenciaPilha:	
	move $v0, $s2
	lw $ra, 0($sp)
        lw $s0, 4($sp)
        lw $s1, 8($sp)    
       
        addi $sp, $sp, 12 # desaloca pilha
        jr $ra
        
exit:
	li $v0, 10 # exit
  	syscall
  	
.data
	string1: .asciiz "Programa Ackermann​\n"
	string2: .asciiz "Componentes: <Gabriel Verdi, Erik Monteiro>​\n"
	string3: .asciiz "\nDigite os parâmetros m e n para calcular A(m, n) ou -1 para abortar a execução\n"
	result: .space 4 # int result;
	resultPrint: .asciiz "A(m , n) = "
	.align 2
