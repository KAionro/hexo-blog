---
title: 涨姿势！手机端的META你知道多少？
date: 2016-12-26 11:06:37
tags: html
---
**Web 前端工具分享：**
[《11款超赞的浏览器兼容性测试工具》](http://www.uisdc.com/browser-compatibility-testing-tool)
[《10款让WEB前端开发人员更轻松的实用工具》](http://www.uisdc.com/let-designers-easily-tool-10)

**一、[天猫](http://m.tmall.com/)**
````
<title>天猫触屏版</title>
<meta content="text/html; charset=utf-8" http-equiv="Content-Type">
<meta charset="utf-8">
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta content="telephone=no" name="format-detection">
````

**二、[淘宝](http://m.taobao.com/)**
````
<title>淘宝网触屏版</title>
<meta charset="utf-8">
<meta content="yes" name="apple-mobile-web-app-capable">
<meta content="yes" name="apple-touch-fullscreen">
<meta content="telephone=no" name="format-detection">
<meta content="black" name="apple-mobile-web-app-status-bar-style">
<meta property="wb:webmaster" content="c51923015ca19eb1">
<meta name="author" content="m.taobao.com">
<meta name="copyright" content="Copyright ©m.taobao.com 版权所有">
<meta name="revisit-after" content="1 days">
<meta name="keywords" content="">
<meta name="description" content="">
````

**三、[京东](http://m.jd.com/)**
````
<title> 京东 - 手机版 </title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0;">
<meta name="format-detection" content="telephone=no">
<meta name="Keywords" content="手机购物,WAP商城,日用百货,3C家电,汽车用品"><meta name="description" content="京东手机版提供了包括数码、家电、手机、电脑配件、网络产品、日用百货等数万种商品，手机快捷购物，就上京东手机版。">
````
**四、[网易](http://3g.163.com/)**
````
<title>手机网易网</title>
<meta charset="UTF-8">
<meta content="width=device-width,user-scalable=no" name="viewport">
<meta name="apple-itunes-app" content="app-id=425349261">
<meta name="apple-mobile-web-app-capable" content="yes">
````
**五、[百度](http://m.baidu.com/)**

````
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
<meta name="format-detection" content="telephone=no">
````
meta指元素可提供有关页面的元信息（meta-information），比如针对搜索引擎和更新频度的描述和关键词。 标签位于文档的头部，不包含任何内容。 标签的属性定义了与文档相关联的名称/值对。

手机端特有的有哪些？
````
<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport">     
<meta content="yes" name="apple-mobile-web-app-capable">     
<meta content="black" name="apple-mobile-web-app-status-bar-style">     
<meta content="telephone=no" name="format-detection">
````
第一个meta标签表示：强制让文档的宽度与设备的宽度保持1:1，并且文档最大的宽度比例是1.0，且不允许用户点击屏幕放大浏览；
````
width - viewport的宽度 height - viewport的高度   
initial-scale - 初始的缩放比例  
minimum-scale - 允许用户缩放到的最小比例   
maximum-scale - 允许用户缩放到的最大比例  
user-scalable - 用户是否可以手动缩放
````

第二个meta标签是iphone设备中的safari私有meta标签，它表示：允许全屏模式浏览；第三个meta标签也是iphone的私有标签，它指定的iphone中safari顶端的状态条的样式；
````
在web app应用下状态条（屏幕顶部条）的颜色；
默认值为default（白色），可以定为black（黑色）和black-translucent（灰色半透明）。
注意：若值为“black-translucent”将会占据页面px位置，浮在页面上方（会覆盖页面20px高度–iphone4和itouch4的Retina屏幕为40px）。
````
第四个meta标签表示：告诉设备忽略将页面中的数字识别为电话号码。

**参考：**
1、[百度百科](http://baike.baidu.com/link?url=LTcOyZlI6Mz6LzeVwSjxA5tJjZKxUchfLBm5Rgt2Xg9bKOp0ewAq9VoHxaWPYbG0)[meta](http://baike.baidu.com/link?url=LTcOyZlI6Mz6LzeVwSjxA5tJjZKxUchfLBm5Rgt2Xg9bKOp0ewAq9VoHxaWPYbG0)
2、[手机网站前端设计](http://www.cnblogs.com/xiaoyusmile/archive/2011/11/15/2249818.html)
3、[手机网页制作的认识（有关meta标签）](http://blog.163.com/yin_1989/blog/static/1749132082013071924352/)
4、[手机端的一些标准](http://hi.baidu.com/shuogexiaohehe/item/b6a06648c98c23f0c0a5920e)
5、[HTML <meta> 标签](http://www.w3school.com.cn/tags/tag_meta.asp)
 
**原文地址：**[cnblogs](http://www.cnblogs.com/kuikui/p/3590673.html)