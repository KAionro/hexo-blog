---
title: Git Stash用法
date: 2016-07-16 14:23:54
tags: Git
---

## Git stash
最近在使用Git管理项目工程的时候，遇到了很多问题，也学习到了很多关于Git常见使用的技巧，下面就其中关于Git Stash的用法和大家分享下。

首先，简单介绍下Git Stash命令的用法，详细的用法在man文档中有相关介绍，下面我来说明常见的使用。

## 用法
### git stash
备份当前的工作区的内容，从最近的一次提交中读取相关内容，让工作区保证和上次提交的内容一致。同时，将当前的工作区内容保存到Git栈中。

### git stash pop
从Git栈中读取最近一次保存的内容，恢复工作区的相关内容。由于可能存在多个Stash的内容，所以用栈来管理，pop会从最近的一个stash中读取内容并恢复。

### git stash list
显示Git栈内的所有备份，可以利用这个列表来决定从那个地方恢复。

### git stash clear
清空Git栈。此时使用gitg等图形化工具会发现，原来stash的哪些节点都消失了。

## 适用场景
关于Git Stash的详细解释，适用场合，这里做一个说明：

使用git的时候，我们往往使用branch解决任务切换问题，例如，我们往往会建一个自己的分支去修改和调试代码, 如果别人或者自己发现原有的分支上有个不得不修改的bug，我们往往会把完成一半的代码 commit提交到本地仓库，然后切换分支去修改bug，改好之后再切换回来。这样的话往往log上会有大量不必要的记录。其实如果我们不想提交完成一半或者不完善的代码，但是却不得不去修改一个紧急Bug，那么使用'git stash'就可以将你当前未提交到本地（和服务器）的代码推入到Git的栈中，这时候你的工作区间和上一次提交的内容是完全一样的，所以你可以放心的修 Bug，等到修完Bug，提交到服务器上后，再使用`git stash apply`将以前一半的工作应用回来。也许有的人会说，那我可不可以多次将未提交的代码压入到栈中？答案是可以的。当你多次使用`git stash`命令后，你的栈里将充满了未提交的代码，这时候你会对将哪个版本应用回来有些困惑，`git stash list`命令可以将当前的Git栈信息打印出来，你只需要将找到对应的版本号，例如使用`git stash apply stash@{1}`就可以将你指定版本号为stash@{1}的工作取出来，当你将所有的栈都应用回来的时候，可以使用`git stash clear`来将栈清空。

在这里顺便提下`git format-patch-n` , n是具体某个数字， 例如`git format-patch -1`这时便会根据log生成一个对应的补丁，如果`git format-patch -2`那么便会生成2个补丁，当然前提是你的log上有至少有两个记录。

看过上面的信息，就可以知道使用场合了：当前工作区内容已被修改，但是并未完成。这时Boss来了，说前面的分支上面有一个Bug，需要立即修复。可是我又不想提交目前的修改，因为修改没有完成。但是，不提交的话，又没有办法checkout到前面的分支。此时用Git Stash就相当于备份工作区了。然后在Checkout过去修改，就能够达到保存当前工作区，并及时恢复的作用。

下面，将我使用过程中遇到的一个问题和大家分享：

首先，在Git Stash之后，提交图如下所示：

![](http://upload-images.jianshu.io/upload_images/3104888-ef461bfddddafc07.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
从图中可以看到，develop和newdevelop是在同一个分支上，因为分支newdevelop是在develop分支的基础上开发的。想加入一个新的特性，所以就开了newdevelop分支，然后就在上面加东西，加特性，该代码。这个时候工作的内容已经变化了，但是develop和newdevelop都是指向同一个提交的，因为newdevelop上面还木有提交。

这个时候，Boss来了，说develop上面有个Bug，赶快改一下，手头的工作先放放，稳定版本不能有缺陷。没办法，当前正在newdevelop上搞的high呢，就Git Stash一下。所以会看到上面有两个节点，红色以及上面一个。就是stash之后的结果，注意是在newdevelop上面进行的stash。

正如前面所说，stash会暂存当前的工作区内容，然后将工作区内容保持和上次提交相同，此时内容都是上面8a32那个提交的内容。从终端中查看相应的信息内容，如下：

![](http://upload-images.jianshu.io/upload_images/3104888-3a080f2fd77859e1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

印证了签名的说法，newdevelop是有修改，modified，然后stash之后，工作区是最近一次提交，此时newdevelop和develop都是相同的，所以再git status查看发现，都一样，nothing to commit.

然后Stash完成之后，就要Fix Bug了。为此，回到develop分支上进行修复，然后提交，完成后的提交图如下所示：

![](http://upload-images.jianshu.io/upload_images/3104888-fb83c63d524be10a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

从图中可以看到，newdevelop还是在下面，因为指向的是老的那个8a32的commit。新的develop由于修复了Bug，所以产生一个新提交。

![](http://upload-images.jianshu.io/upload_images/3104888-3d5440a6aa6542d0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

然后在develop上面修复了Bug之后，在回到newdevelop上面进行一个新的特性的继续编码，此时checkout回去的时候，没有神马内容可以提交，因为都存在Stash中了，没有任何修改。如上图。

那么，恢复工作区内容吧。于是git stash pop（注意这里由于只Stash了一次所以使用pop，具体你存放了多少，要恢复哪一个要自己清楚，否则会出错！）

![](http://upload-images.jianshu.io/upload_images/3104888-739ef9503a1dc0bb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

恢复之后，从上图中可以看到，此时再git status就会发现文件有修改，说明恢复过来了。然后就继续编码，提交一个稳定的新特性版本，如下图，产生的新提交为0906.

然后再查看提交图，会发现，stash pop之后，对应的存放的stash被清空掉了，提交图中，newdevelop上面对应一个新的提交。并且在develop上面。分支的develop那个红色，即为前面修复Bug的那个提交。

![](http://upload-images.jianshu.io/upload_images/3104888-924b2c00a85bdd93.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 总结

操作很简单，但是头脑要清楚。要在哪个分支上修复Bug，要暂存哪个地方的内容，之后修复完了在那个地方提交，然后要到哪个分支上面恢复工作区，都是需要注意的，否则，很容易造成提交图混乱。只有弄清楚了工作流程，才不容易出错，才能保证很高的工作效率。

 >注：以上内容版权所有，作者：K丶Aionro，如有转载，请注明出处！谢谢！
