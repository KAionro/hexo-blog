---
title: JavaScript - 捕获错误----使用try...catch语句
date: 2016-10-17 21:29:01
tags: javascript
---

## JavaScript - 捕获错误
当我们在网上冲浪时，总会看到带有 runtime 错误的 Javascript 警告框，同时会询问我们“是否进行 debug？”。像这样的错误信息或许对开发人员有用，对用户则未必。当错误发生时，他们往往会选择离开这个站点。

## 有两种在网页中捕获错误的方法：
使用try...catch语句。(在 IE5+、Mozilla 1.0、和 Netscape 6 中可用)

使用onerror事件。这是用于捕获错误的老式方法。(Netscape 3 以后的版本可用)

*注意：chrome、opera 和 safari 浏览器不支持 onerror 事件。*
### 在JavaScript可以使用try...catch来进行异常处理。例如：
#### 语法：
```
try{
    //运行代码
} catch(error) {
    //捕获错误
}
```
#### 系统异常
目前我们可能得到的系统异常主要包含以下6种:

1、EvalError: raised when an error occurs executing code in eval()

2、RangeError: raised when a numeric variable or parameter is outside of its valid range

3、ReferenceError: raised when de-referencing an invalid reference

4、SyntaxError: raised when a syntax error occurs while parsing code in eval()

5、TypeError: raised when a variable or parameter is not a valid type

6、URIError: raised when encodeURI() or decodeURI() are passed invalid parameters

上面的六种异常对象都继承自Error对象。他们都支持以下两种构造方法:

```
new Error();

new Error("异常信息");

手工抛出异常的方法如下：

try {

    throw new Error("Whoops!");

} catch (e) {

    alert(e.name + ": " + e.message);

}
```

如要判断异常信息的类型，可在catch中进行判断：

```
try {

    foo.bar();

} catch (e) {

    if (e instanceof EvalError) {

        alert(e.name + ":" + e.message);

    } else if (e instanceof RangeError) {

        alert(e.name + ": " + e.message);

    }

    //........

}
```

#### Error具有下面一些主要属性：

description: 错误描述 (仅IE可用).

fileName: 出错的文件名 (仅Mozilla可用).

lineNumber: 出错的行数 (仅Mozilla可用).

message: 错误信息 (在IE下同description)

name: 错误类型.

number: 错误代码 (仅IE可用).

stack: 像Java中的Stack Trace一样的错误堆栈信息 (仅Mozilla可用).

因此为了更好的了解错误信息我们可以将catch部分改为如下形式：

```
try {

    foo.bar();

} catch (e) {

    if (browserType != BROWSER_IE) {

        alert("name: " + e.name +

            "message: " + e.message +

            "lineNumber: " + e.lineNumber +

            "fileName: " + e.fileName +

            "stack: " + e.stack);

    } else {

        alert("name: " + e.name +

            "errorNumber: " + (e.number & 0xFFFF ) +

            "message: " + e.message");

    }

}
```

JavaScript中的throw命令事实上可以抛出任何对象，并且我们可以在catch接受到此对象。例如：

```
try {

    throw new Date(); // 抛出当前时间对象

} catch (e) {

    alert(e.toLocaleString()); // 使用本地格式显示当前时间

}
```

## 实例1
原本用在用户点击按钮时显示 "Welcome guest!" 这个消息。不过 message() 函数中的 alert() 被误写为 adddlert()。这时错误发生了
![](http://upload-images.jianshu.io/upload_images/3104888-e5e9d4bab264de46.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
用 try...catch 语句重新修改了脚本。由于误写了 alert()，所以错误发生了。不过这一次，catch 部分捕获到了错误，并用一段准备好的代码来处理这个错误。这段代码会显示一个自定义的出错信息来告知用户所发生的事情。
![](http://upload-images.jianshu.io/upload_images/3104888-3ee25c2ba84e7a77.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 实例2
会显示一个确认框，让用户来选择在发生错误时点击确定按钮来继续浏览网页，还是点击取消按钮来回到首页。如果 confirm 方法的返回值为 false，代码会把用户重定向到其他的页面。如果 confirm 方法的返回值为 true，那么代码什么也不会做。
![](http://upload-images.jianshu.io/upload_images/3104888-0db88b5eba3bf6fe.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

 >注：以上内容版权所有，作者：K丶Aionro，如有转载，请注明出处！谢谢！

