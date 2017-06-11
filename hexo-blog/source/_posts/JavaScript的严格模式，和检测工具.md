---
title: JavaScript的严格模式，和检测工具
date: 2017-02-15 14:34:29
tags: javascript
---
# 严格模式 #
###1、设立严格模式的目的
- 消除JavaScript语法的一些不合理、不严谨之处，减少一些怪异行为；(会将JavaScript陷阱直接变成明显错误，静默失败)
- 消除代码运行的一些不安全之处，保证代码运行的安全；（修正了一些引擎难以优化的错误）
- 提高编译器的效率，增加运行速度；
- 为未来新版本的JavaScript做好铺垫。

###2、浏览器支持情况

IE10+、Firefox4+、Safari5.1+、Chrome
###3、严格模式标志
"use strict";

注：老版本的浏览器，如不支持严格模式，会将其当做一行普通字符串忽略。
###4、严格模式的使用
1. 如果'use strict'放在js文件首行，则整个js文件都将以"严格模式"运行；（如果该句不在首行，则无效），需要特别注意：多个文件合并成一个文件的情况，此情况下，提供一个方法，每个文件使用匿名函数自执行，将'use strict'放在函数首行；
2. 将'use strict'放在函数第一行，表示整个函数为'严格模式'，函数以外在为正常模式；
###5、严格模式的一些改变
#####变量的声明---严格模式下，如果变量没有声明就赋值会报错；
<pre>
    'use strict';
    v = 1; //报错，v未声明
    for(i = 0; i < 2; i++){} //报错，i未声明
</pre>

#####禁止使用with语句：因为with语句无法再编译时就确定，属性到底归属哪个对象
>首先，严格模式禁用with，with所引起的问题是快内的任何名称可以映射（map）到with传进来的对象的属性，也可以映射到包围这个块的作用域内的变量（甚至是全局变量），这一切都是在运行时决定的；在代码运行之前是无法得知的，严格模式下，使用with会引起语法错误，所以就不会存在with块内的变量在运行时才决定引用到哪里的情况了。

<pre>
	'use strict';
	var x = 17;
	with(obj){ // 语法错误 Uncaught SyntaxError: Strict mode code may not include a with statement
		v; //如果没有开启严格模式，with中的这个this指向上面的那个x，还是obj.x？
		   //如果不运行代码，我们无法知道，因此，这种代码让引擎无法进行优化，速度也就会变慢。
	}
</pre>
#####创设eval作用域
正常模式下，JavaScript语言有两种变量作用域（scope）：全局作用域和函数作用域。严格模式创设了第三种作用域：eval作用域。

正常模式下，eval语句的作用域，取决于他处于全局作用域，还是处于函数作用域。严格模式下，eval语句本身就是一个作用域，不再能够生成全局变量了，他所生成的变量只能用于eval内部。
<pre>
	'use strcit';
	var x = 2;
	console.info(eval("var x = 1; x"));  // 1
	console.info(x);  // 2  正常模式下此值为 1
</pre>
#####this关键字指向
<pre>
	function f(){
		console.log(this)  //window
	}
	function f(){
		'use strict';
		console.log(this)  //undefined
	}
	//因此在使用构造函数时，如果没有实例化new，this不再指向全局对象，而是报错
</pre>
######在严格模式下，如果使用call()改变this指针的上下文，如果传入一个原始值，则会转换为一个对象；在严格模式下，则直接返回原始值；
<pre>
	console.log(function(){
		return this;  //Number {[[PrimitiveValue]]: 1}
	}.call(1))
	console.log(function(){
		'use strict';
		return this;  // 1	
	}.call(1))
</pre>
#####禁止在函数内部遍历调用栈
<pre>
	function f(){
		'use strict';
		f.caller;  //报错；
		f.arguments;  //报错；
		//Uncaught TypeError: 'caller' and 'arguments' are restricted function properties and cannot be accessed in this context.
	}
</pre>
#####禁止随意删除变量
<pre>
	'use strict';
	var x;
	delete x;  // 语法报错
	eval('var y; delete y;') //语法报错
	// 正常模式下：delete是无法删除va声明出的变量的，不过通过eval声明的变量，可以被正常删除
	var o = Object.create(null,{'x':{
		value : 1,
		configurable : true
	}});
	delete o.x; //删除成功
</pre>
#####对一个对象的只读属性赋值会报错
<pre>
	// 正常模式下不会报错
	'use strict';
	var o = {};
	Object.defineProperty(o,'v',{
		value : 1,
		writable : false
	});
	o.v = 2; // 报错；useStrict.html:50 Uncaught TypeError: Cannot assign to read only property "v" of object 
</pre>
#####对一个使用getter方法读取的属性赋值会报错
<pre>
	'use strict';
	var o = {
		get v() {return 1;}
	};
	o.v = 2; // 报错；
</pre>
#####对禁止扩展的对象添加新属性，会报错
<pre>
	'use strict';
	var o = {};
	Object.preventExtensions(o);
	o.v = 1; // 报错
</pre>
#####删除一个不可删除的属性，报错
<pre>
	'use strict';
	delete Object.pretotype;  //报错；
</pre>
####对象不能有重名的属性（正常模式是覆盖，严格模式报错）（此问题测试无结果，据说已经修正）
####函数不能有重名的参数（正常模式下可以通过arguments可以读取，严格模式报错）
####禁止八进制表示法
- 正常模式下，整数的第一位为0表示这是八进制数
- 但是在严格模式下这种写法会报错
- ps: parseInt(010) 正常模式下是8，但是严格模式不允许使用0开头的数字，所以此处如果改成 parseInt('010'),结果就不对了
#####arguments对象的限制
<pre>
	'use strict';
	arguments++; //报错
	var obj = {set p(arguments){}}; //报错
	try {} catch(arguments){}; //报错
	function arguments(){}; //报错
	var f = new Function('arguments',"'use strcit'; return 1;");//报错
</pre>
#####arguments不再追踪参数的变化
<pre>
	function f(a){
		'use strict';
		a = 2;
		return [a,arguments[0]];
	}
	f(1); // [2,1]    正常模式下为[2,2]
</pre>
#####禁止使用arguments.callee,arguments.caller
无法通过arguments.callee匿名函数自调用,也不能通过arguments.caller来获取调用函数
##函数必须声明在顶层（暂时未测试出来结果）
<pre>
//以下代码，是MDN实例，但是自测未发现报错
"use strict";
if (true){
  function f() { } // !!! 语法错误
  f();
}

for (var i = 0; i < 5; i++){
  function f2() { } // !!! 语法错误
  f2();
}

function baz() { // 合法
  function eit() { } // 同样合法
}
</pre>
#####保留字
严格模式新智能了一些保留字，使用这些词作为变量名将会报错
implements,interface,let,package,private,protected,public,static,yield,class,enum,export,extends,import,super,const

## JavaScript语法检测工具jshint ##

####1、安装
在node环境下，全局安装jshint

`npm install jshint -g`
####2、使用方法
1. 单独对js文件进行检测:在该文件目录下`jshint xxx.js`
2. 检测当前目录及其子目录所有js文件的语法`jshint ./`
####3、配置文件
1. 使用-config选项制定配置文件：jshint -config ./xxx ./	表示检测当前目录内所有的js文件，并指定配置文件为当前目录下的xxx文件。
2. 使用.jshintrc文件，如果在运行jshint时，没有-config选项，则会以当前目录的.jshintrc文件为配置文件，如果当前目录没有这个文件，则以其父目录.jshintrc文件为配置文件，仍没有的话，则继续找其父目录，直至根目录。
3. 在nodejs项目的package.json文件的jshintConfig字段中设置配置文件。
4. 还可以在需检测的js文件内配置选项`/* jshint undef:true,unused:true /*
/* global Global */
`或者 `//jshint undef:true,unused:true`这两种方式都可以，如果只把这些注释写在某个函数内，则改配置只在函数内起作用。
5. 有时候我们不希望检查一些文件（比如一些库），可以建一个.jshintignore文件，把需要忽略的文件名写在里面，支持通配符。
####4、配置选项
- asi  ----- 如果是真，JSHint会无视没有加分号的行尾
- bitwise  -----如果为真，JSHint会禁用位运算符  （ps：Javascript允许位运算，但是他却没有整型，位运算符要把参与运算的数字从浮点数变为整数，并在运算后再转换回来。这样他们的效率就不如在别的语言中那么高）
- boss  -----如果为真，那么JSHint会允许在if，for，while里面编写赋值语句  (ps：一般来说，我们会在循环、判断等语句中加入值的比较来做语句的运行条件，有时候会把==错写成赋值的=，通常，JSHint会把这个认定为一个错误，但是开启这个选项的化，JSHint就不会检查判断条件中的赋值 )
- curly  ----- 如果为真，JSHint会要求你在使用if和while等结构语句时加上{}来明确代码块
- debug  ----- 如果为真，JSHint会允许代码中出现debugger的语句。不过建议你最好在检测代码前去掉debug的语句
- eqeqeq  ----- 如果为真，JSHint会看你在代码中是否都用了===或者是!==，而不是使用==和!=(ps：我们建议你在比较0，”(空字符)，undefined，null，false和true的时候使用===和!===)
- eqnull  ----- 如果为真，JSHint会允许使用”== null”作比较（ps：== null 通常用来判断一个变量是undefined或者是null（当时用==，null和undefined都会转化为false）
- evil  ----- 如果为真，JSHint会允许使用eval（ps：eval提供了访问Javascript编译器的途径，这有时很有用，但是同时也对你的代码形成了注入攻击的危险，并且会对debug造成一些困难，Function构造函数也是另一个‘eval’，另外，当传入的参数是字符串的时候，setTimeout和setInterval也会类似于eval）
- forin  -----如果为真，那么，JSHint允许在for in 循环里面不出现hasOwnProperty（ps：for in循环一般用来遍历一个对象的属性，这其中也包括他继承自原型链的属性，而hasOwnProperty可以来判断一个属性是否是对象本身的属性而不是继承得来的）
- immed  -----如果为真，JSHint要求匿名函数的调用如下（ps：`(function(){
//
}());
而不是
(function(){
//bla bla
})();`）
- laxbreak  -----如果为真，JSHint则不会检查换行（ps：Javascript会通过自动补充分号来修正一些错误，因此这个选项可以检查一些潜在的问题）
- maxerr  ----- 设定错误的阈值，超过这个阈值jshint不再向下检查，提示错误太多
- newcap  -----如果为真，JSHint会要求每一个构造函数名都要大写字母开头
- noarg  -----如果为真，JSHint会禁止arguments.caller和arguments.callee的使用
- noempty  -----如果为真，JSHint会禁止出现空的代码块，即没有语句的代码块
- nomen  -----如果为真，JSHint会禁用下划线的变量名
- onevar  -----如果为真，JSHint期望函数只被var的形式声明一遍
- passfail  -----如果为真，JSHint会在发现首个错误后停止检查
- plusplus  -----如果为真，JSHint会禁用自增运算和自减运算（ps：++和--可能会带来一些代码的阅读困惑）
- regexp  -----如果为真，JSHint会不允许使用.和[^…]的正则（ps：因为这样的正则往往会匹配到你不期望的内容，并可能会应用造成一些危害）
- undef  -----如果为真，JSHint会要求所有的非全局变量，在使用前都被声明（ps：如果你不在一个本地作用域内使用var的方式来声明变量，Javascript会把它放到全局作用域下面。这样会很容易引起错误）
- sub  -----如果为真，JSHint会允许各种形式的下标来访问对象（ps：通常，JSHint希望你只是用点运算符来读取对象的属性（除非这个属性名是一个保留字），如果你不希望这样可以关闭这个选项）
- strict  -----如果为真，JSHint会要求你使用use strict;语法
- white  -----如果为true，JSHint会依据严格的空白规范检查你的代码
- Environments  -----你的代码所在的环境

 [jshint官网](http://jshint.com/ "jshint")

>如需转载，请注明出处！