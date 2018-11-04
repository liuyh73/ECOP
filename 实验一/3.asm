#***********************************#
#               作业三              #
#***********************************#

#------------数据 segment-----------#

.data
    listA:
        .space  80
    listB:      
        .space 120
    outList:
        .space 80
    msgA:
        .asciiz "Please input 20 numbers as the listA: \n"
    msgB:
        .asciiz "Please input 30 numbers as the listB: \n"
    msgOutput:
    	.asciiz "The result is as follows: \n"
    msgNoSame:
    	.asciiz "No same!\n"
    str:
        .asciiz " "

#------------代码 segment-----------#

.text
.globl main

storeNum:										#存储相同的数字代码
    addi    $t4,    $t4,    1               	#outList计数器加1
    lw      $s7,    0($t3)
    sw      $s7,    0($t9)                  	#存放相同的数字
    addi    $t9,    $t9,    4               	#outList偏移量加4
    j       queryOutLoop

main:											#主程序入口
    addi    $s1,    $zero,  20              	#ListA总数初始化
    addi    $t1,    $zero,  1               	#ListA计数器
    la      $t2,    listA                   	#listA首地址
    add     $t3,    $t2,    $zero           	#将listA首地址$t2赋值给变量$t3

    addi    $s2,    $zero,  30              	#ListB总数初始化
    addi    $t5,    $zero,  1               	#ListB计数器
    la      $t6,    listB                   	#listB首地址
    add     $t7,    $t6,    $zero           	#将listB首地址$t6赋值给变量$t7

    add     $t4,    $zero,  $zero           	#outList计数器
    la      $t8,    outList                 	#outList首地址
    add     $t9,    $t8,    $zero           	#将outList首地址$t8赋值给变量$t9
    li      $v0,    4                       	#打印提示信息，字符串
    la      $a0,    msgA                    	#读取字符串地址，输出
    syscall

#------------代码 输入-----------#

loopAinput:										#循环输入listA
    li      $v0,    5                       	#接收一个整数
    syscall

    #move   $a0,   $v0                      	#Debug 输出当前输入的数字
    #li     $v0,    1               
    #syscall

    sw      $v0,    0($t3)                  	#存放输入的数字

    beq     $t1,    $s1,    tipsMsg         	#判断输入的数字是否足够
    addi    $t1,    $t1,    1               	#计数器加1

    addi    $t3,    $t3,    4               	#偏移加4
    j       loopAinput

tipsMsg:										#listB输入的提示信息
    li      $v0,    4                       	#打印提示信息，字符串
    la      $a0,    msgB                    	#读取字符串地址，输出
    syscall

loopBinput:
    li      $v0,    5                       	#接收一个整数
    syscall

    sw      $v0,    0($t7)                  	#存放输入的数字

    beq     $t5,    $s2,    queryInit       	#判断输入的数字是否足够
    addi    $t5,    $t5,    1               	#计数器加1

    addi    $t7,    $t7,    4               	#偏移加4
    j       loopBinput

#------------代码 查找相同的数字-----------#

queryInit:                                  	#listA、B输入完成，检索相同数字的循环初始化
    addi    $t1,    $zero,  0               	#listA计数器置0
    addi    $t3,    $t2,    -4              	#listA首地址

queryOutLoop:									#检索外层循环
    addi    $t1,    $t1,    1               	#ListA计数器加1
    addi    $t3,    $t3,    4              		#偏移加4
    addi    $t5,    $zero,  0               	#listB计数器置0
    addi    $t7,    $t6,    -4              	#将listB首地址$t6赋值给变量$t7
    beq     $t1,    21,     outputInit			#判断退出循环的条件

queryInLoop:									#检索内层循环
    addi    $t5,    $t5,    1               	#listB计数器加1
    addi    $t7,    $t7,    4					#listB指针偏移

    lw      $s4,    0($t3)						#取出listA当前的数字
    lw      $s5,    0($t7)						#去除listB当前的数字	
    beq     $s4,    $s5,    storeNum        	#判断两个数字是否相同

    beq     $t5,    $s2,    queryOutLoop		#判断内部循环是否完成
    slt     $s3,    $t5,    $s2
    beq     $s3,    1,      queryInLoop			#未完成继续内部循环

#------------代码 输出-----------#

outputInit:										#输出循环初始化
    li      $v0,    4                       	#打印提示信息，字符串
    la      $a0,    msgOutput               	#读取字符串地址，输出
    syscall
    beq     $t4,    0,      noSame 				#判断是否有相同的数字
    add     $t0,    $zero,  $zero           	#初始化输出列表计数器$t0
    addi    $t1,    $t4,    1					#初始化输出列表总数+1（左闭右开集合）
    addi    $t9,    $t8,    -4              	#将outList首地址$t8向后偏移-4赋值给变量$t9

loopOutput:										#输出循环
    addi    $t0,    $t0,    1               	#listB计数器加1
    addi    $t9,    $t9,    4					#listB指针偏移

    beq     $t0,    $t1,    Quit 				#判断输出循环是否结束

    add     $s7,    $zero,  $zero           	#去重计数器
    addi    $s6,    $t8,    -4              	#去重指针

duplicateRomoveLoop:							#去重循环
    addi    $s7,    $s7,    1               	#去重计数器加1
    beq     $s7,    $t0,    output 				#输出当前数字

    addi    $s6,    $s6,    4              	 	#去重指针偏移
    lw      $s4,    0($t9)						#将当前数字存放在$s4寄存器中
    lw      $s5,    0($s6)						#将输出的数字放在$s5寄存器中备用

    beq     $s4,    $s5,    loopOutput			#判断当前的数字之前是否输出过，如果为假，就尝试输出下一个数字
    slt     $s3,    $s7,    $t0
    beq     $s3,    1,      duplicateRomoveLoop	#如果为真，和下一个数字比较判断是否出现过

output:											#输出去重后的数字
    li      $v0,    1							#调用指令输出一个数字
    lw      $a0,    0($t9)
    syscall

    la      $a0,    str 						#调用指令输出一个空格
    li      $v0,    4
    syscall

    slt     $s3,    $t0,    $t4
    beq     $s3,    1,      loopOutput			#判断所有数字是否输出完毕

Quit:											#退出
    li      $v0,    10
    syscall

noSame:
	li      $v0,    4                       	#打印提示信息，字符串
    la      $a0,    msgNoSame                	#读取字符串地址，输出
    syscall
    j		Quit
