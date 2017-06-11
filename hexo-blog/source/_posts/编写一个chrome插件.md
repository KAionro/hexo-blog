---
title: 编写一个chrome插件
date: 2017-04-06 15:26:52
tags: javascript
---
应公司要求，需要给公司测试写一个chrome插件来实现自动化，经查询与摸索，插件很快就完成了，下面对于chrome插件编写进行简单描述

# 编写chrome插件 #
>##### 引入:
>[chrome开发文档](https://developer.chrome.com/extensions)
>
>[360翻译文档](http://open.chrome.360.cn/extension_dev/overview.html)  ---- 只做为借鉴使用

>[Chrome扩展及应用开发--电子书](http://www.ituring.com.cn/minibook/950)

### 进入扩展程序
1. chrome  ----  chrome://extensions
2. 360  ----  se://extensions

### 查看扩展插件源码
1. chrome  ---- chrome://version
2. 360  ---- se://version

![chrome版本中心](http://upload-images.jianshu.io/upload_images/3104888-489a6dec62c0aee2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


进入红色标注的文档地址，找到extension文件夹并进入，里面就是本机的chrome插件库（360同上）

## 进入正题
### 编写chrom插件 [Getting Started](https://developer.chrome.com/extensions/getstarted)

##### 一、配置入口文件 manifest.json`
正如目前每个前端工具类似，在编写chrome插件之前也需要在根目录下添加一个入口文件，名称必须为manifest.json

	{
		// ------------------------------必须的字段------------------------------
		"name": "My Extension",
		"version": "versionString",
		"manifest_version": 2,
		/*
			用整数表示manifest文件自身格式的版本号，从chrome18开始，开发者指定版本号为2（2014年1月之后不可在用1，关于1和
			
			2的区别，可以参考如下文档 https://developer.chrome.com/extensions/manifestVersion ）
		*/

		// ------------------------------建议提供的字段------------------------------
		"description": "A plain text description",

		"icons": {
			"16": "icon16.png",
			"48": "icon48.png",
			"128": "icon128.png"
		},
		/*
			128x128的图标将在webstore安装时候使用；48x48的图标在扩展管理页面需要这个图标；16x16的图标作为扩页面的fa网页图标

			图标建议是png格式，因为png格式是对透明支持最好的,也可以用其他webkit支持的格式

			注意：请只使用文档说明的图标大小。
		*/

		"default_locale": "en",
		/* 支持国际化，对于我们国语还没说明白的来讲，建议不使用 */

		// ------------------------------多选一，或者都不提供------------------------------
		"browser_action": {
			"default_icon": { // optional
					"16": "images/icon16.png", // optional
					"24": "images/icon24.png", // optional
					"32": "images/icon32.png" // optional
				},
			"default_title": "Google Mail", // optional; shown in tooltip
			"default_popup": "popup.html" // optional
		/*
			用 browser actions 可以在chrome主工具条的地址栏右侧增加一个图标

			如果你想创建一个不总是可见的图标, 可以使用page action来代替browser action

			default_popup当用户点击图标后出现，popup可以包含任意你想要的html内容，并且会自适应大小

			此字段提供了一些API请参考（https://developer.chrome.com/extensions/browserAction）

			例如：chrome.browserAction.onClicked.addListener(function(tab){...}) ,当用户点击图标时候的事件监听

![browser_action_click.png](http://upload-images.jianshu.io/upload_images/3104888-f32aa55c8b568b42.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

			但是当browser action是一个popup的时候，这个事件不会被触发
		*/
		},


![browser_action.png](http://upload-images.jianshu.io/upload_images/3104888-9a7c9d528372a332.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



		"page_action": {
		/*
			使用pack_action把图标放置到地址栏里。定义需要处理的页面的事件，但是它们不是适用于所有页面

			（文档地址https://developer.chrome.com/extensions/pageAction）

			用法和browser_action类似，不过官方建议使用browser_action
		*/
		},

![page_action.png](http://upload-images.jianshu.io/upload_images/3104888-c6c42ed589125218.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

		// ------------------------------根据需要提供------------------------------
		"author": ...,
		"automation": ...,
		"background": {
			// Recommended
			"scripts": ["background.js"]，
			//浏览器的扩展系统会自动根据上面scripts字段指定的所有js文件自动生成背景页
			"page": "background.html"
			//如果您的确需要自己的背景页，可以使用page字段
			"persistent": false
		/*
			扩展常常用一个单独的长时间运行的脚本来管理一些任务或者状态，背景页是一个运行在扩展进程中的html页面。

			(文档https://developer.chrome.com/extensions/background_pages)

			它在你的扩展的整个生命周期都存在，同时，在同一时间只有一个实例处于活动状态
		*/
		},
		"background_page": ...,
		"content_scripts": [{
			"matches": ["http://www.google.com/*"],
			"css": ["mystyles.css"],
			"js": ["jquery.js", "myscript.js"]，
			"run_at": "document_end"
		/*
			在web页面内运行的js脚本，通过使用标准DOM，它们可以获取浏览器所访问页面的详细信息，并可以修改这些

			但是也有一些限制：

			不能使用除chrom://exntension之外的chrome.*的接口

			不能访问它所在扩展中定义的函数和变量

			不能访问web页面或其他content script中定义的函数和变量

			不能做cross-site XMLHttpRequests

			但是： content_scripts可以使用messages机制与它所在的扩展通信，来间接使用chrome:*接口，或访问扩展数据

			（开发文档：https://developer.chrome.com/extensions/content_scripts）
		*/
		}],
		"content_security_policy": "policyString",
		/*
			开启内容安全策略,引入了严格的策略使扩展更安全，同时提供创建和实施策略规则的能力

			禁止使用内嵌inline形式的js脚本，所有js脚本要外部引用
		*/

		"homepage_url": "https://www.baidu.com",
		//用来展示自己的网站

		"import": [{
			"id": "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
			//共享模块是可以在其他扩展程序和应用程序之间共享的无权资源集合
		}],

		"incognito": "spanning, split, or not_allowed",
		//定义扩展在隐身模式下的开启模式 ，使用 "not_allowed"以防止在隐身模式下启用了此扩展

		"minimum_chrome_version": "versionString",
		//声明该扩展需要的最低chrome浏览器版本

		"offline_enabled": true,
		//声明该扩展是否支持脱机模式运行

		"omnibox": {
			"keyword": "aString"
			//当用户在地址栏输入你的扩展关键字，用户开始与你的扩展交互 ---- 自测无用
			//(文档地址：https://developer.chrome.com/extensions/omnibox)
		},

		"optional_permissions": ["tabs"],
		//声明permissions可选权限

		"options_page": "options.html",
		/*
			为了让用户设定你的扩展功能，你可能需要提供一个选项页，如果你提供了选项页

			在扩展管理页面 chrome://extensions上会提供一个链接。点击选项链接就可以打开你的选项页

			(文档地址：https://developer.chrome.com/extensions/options)
		*/

		"options_ui": {
			"chrome_style": true,
			"page": "options.html"
		},
		//同上 (文档地址：https://developer.chrome.com/extensions/optionsV2)

		"permissions": ["tabs"],
		/*
			(文档地址：https://developer.chrome.com/extensions/declare_permissions)

			声明权限：在使用chrome提供的API，扩展程序必须在manifest.json的permissions字段中声明其意图

			如果一个扩展api需要你的声明一个权限在manifest文件，一般的，api的文档将告诉怎么做。例如，Tabs页面告诉你这么声明一个tabs权限
		*/

		"plugins": [...],
		/*
			NPAPI插件，运行在此插件中的代码拥有当前用户的全部权限，鉴于可能会引入风险，甚至在上传web store时，该插件需人工审核
		*/

		"requirements": {
			"3D": {
				"features": ["css3d", "webgl"]
			}
		},
		/*
			指定该扩展所需的特殊功能，目前只支持指定“3D”，也就是GPU加速
		*/

		"sandbox": [...],
		//沙盒，在这里可以使用内联js

		"short_name": "Short Name",

		"update_url": "http://path/to/updateInfo.xml",
		//扩展自动升级检测(文档地址：https://developer.chrome.com/extensions/autoupdate)

		"version_name": "aString",
		//描述性版本字符串

		"web_accessible_resources": [
			"images/*.png",
			"style/double-rainbow.css",
			"script/double-rainbow.js",
			"script/main.js",
			"templates/*"
		]
		/*
			一组字符串，指定扩展在注入的目标页面上所需要使用的资源路径（相对于扩展的安装根目录），可用通配符匹配

			(文档地址：https://developer.chrome.com/extensions/manifest/web_accessible_resources)
		*/
	}


[Chrome Platform APIs]("https://developer.chrome.com/extensions/api_index")


##### 调试
浏览器访问：chrome-extension://<插件ID>/插件入口html文件

#### 注意：
1. 不可使用内联js
2. manifes.json文件为json文件，再打包上传chrome商店时，不可包含注释和中文


#### 写一个chrome插件demo
关于浏览器加载时间的插件
1、创建并配置manifest.json文件
 ```
{ "name": "Test",
  "manifest_version": 2,
  "version": "1.0.0",
  "devtools_page": "devtools.html",
  "background":{"scripts":["background.js"]},
  "browser_action": {
      "default_popup": "popup.html"
   },
   "icons": {
      "128": "images/icon128.png",
      "16": "images/icon16.png",
      "48": "images/icon48.png"
   }
}
```
2、这里既然用到了devtools，编写devtools.js
```
chrome.devtools.panels.create('Test', '/images/icon16.png', '/demo1.html', function(extensionPanel) {
    var _window; // Going to hold the reference to panel.html's `window`

    var data = [];
    var port = chrome.runtime.connect({name: 'devtools'});
    port.lineTime = [];
    chrome.devtools.network.onRequestFinished.addListener(
    // console.log(notifyDevtools);
      function(request) {
          var url = request.request.url,
              time = request.time;
          if(url.substring(0, 9) === "chrome://" || url.substring(0, 19) === "chrome-extension://" || url.substring(0, 7) === "file://") return;
          chrome.runtime.sendMessage({url: url,time: time});
    });
});
```
3、需要用到background.js
```
var ports = [],
    datas = [];
chrome.runtime.onConnect.addListener(function(port) {
    if (port.name !== "devtools") return;
    ports.push(port);
    port.onDisconnect.addListener(function() {
        var i = ports.indexOf(port);
        if (i !== -1) ports.splice(i, 1);
    });
});

chrome.runtime.onMessage.addListener(function(msg) {
    if(localStorage['drawOver'] == 1){
        datas = [];
        localStorage['drawOver'] = null;
    }
    datas.push(msg);
    localStorage["domains"] = JSON.stringify(datas);
});
```
4、写html文件
```
<!DOCTYPE html>
<html>

<head>
    <title>弹出框</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" type="text/css" href="popup.css">
</head>

<body>
    <div id="main"></div>
    <script type="text/javascript" src="echarts.common.min.js"></script>
    <script type="text/javascript" src="theme/macarons.js"></script>
    <script type="text/javascript" src="popup.js"></script>
</body>
</html>
```
这里我们引入了Echarts图标插件
具体不细说了，看效果图：
以百度为例：

![www.baidu.com加载分析图](http://upload-images.jianshu.io/upload_images/3104888-26c1f0f8943e001e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###### 对于该插件我没有优化，只是做了实验性demo，感兴趣的朋友可以深入尝试，例如：印象笔记的剪藏插件，就是一款很好的插件

>注：以上内容版权所有，作者：K丶Aionro，如有转载，请注明出处！谢谢！