# asm-rewrite-c-functions

+ 写本项目的初衷主要是中文社区的 x64 汇编资料少之又少，希望通过本项目让各位对汇编语言感兴趣的同学加深对汇编的理解。
+ 初学汇编的同学建议先学习王爽老师的《汇编语言》教材，建立对汇编的基础框架。B站有许多相关的视频资料。
+ 使用 nasm 的64位汇编语法，重写了 C 语言中的一些函数，如 printf、scanf 等。   
+ 目前可以实现把字符串中的 %d 与 %c %s 准确转换成对应的整数与字符，会陆续更新如 %f 之类的。   
+ 支持 3 个参数同时在一个字符串中，详细请参考测试代码。 
+ 下一阶段准备重写 scanf。   
+ 并没有参考源码，自己也没有看过源码，都是自己手搓，代码粗糙，但思想清晰易懂，方便阅读学习，有好的优化方法欢迎留言。
+ 目前 %c 的转换中存在问题，只能转换字符变量，无法转换字符常量，暂时没有解决办法    

在命令行中运行这个测试代码即可测试函数
```bash
nasm -f elf64 -g -F dwarf test.asm -l main.lst && nasm -f elf64 -g -F dwarf print.asm -l myfun.lst && gcc test.o print.o -o main -no-pie && ./main
```

Using NASM's 64-bit assembly syntax, some C language functions, such as printf and scanf, have been rewritten. Currently, it can accurately convert %d and %c in strings into their corresponding integers and characters. Updates for %f, %s, and others will follow. The next phase will focus on rewriting scanf.