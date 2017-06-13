---
title: git merge 合并遇到的坑
date: 2016-12-02 20:54:29
tags: Git
---

**说一个关于Git的天坑，git merge 合并遇到的坑**

## git merge

*先说一下吧，做前端那么久了，其实在合并代码上并没有出现过什么要紧的事，无非就是合并代码有冲突，根据合并后的提示修改一下而已，但是前些日子遇到一个很烦的bug ，刚好下班，闲来无事，记录一下，并提供自己摸索的解决方案。*

## 问题点： git merge后，push提示没有change-id

这就很烦了，我们都知道，每次我们用git提交代码，都会生成一个唯一的change-id供我们使用，但是偏偏这次合并代码并提交代码没有chang-id，瞬间无语。。然后就是各种百度找方法吧，然并卵啊，百度、google、bing都搜遍了，也没找到合格的解决方案。

最后问了几个同事，同事也都遇见过这种情况，都说重新拉一遍代码，但是个人觉得这种方法很挫，而且有点不靠谱，因为我重新拉了一遍代码，合并后依然没有chang-id，不过同事都说可行，也说明这是一种解决方法吧，有句话说的好，无论好用不好用都不如初始化是吧。

最后迫于无奈和工作压力，都等着合并呢，自己凑合着摸索，想到一些方法，通过实验，总结靠谱方案如下。

### 方案如下：

在合并的时候也就是 git merge 的时候

#### 方案一
`git merge <branch1> --no-commit`
`<branch1>` 是你要合并的分支名称。

`--no-commit` 就是不提交，合并以后再重新提交一次，如果你用小乌龟那就更方便
*cmd*
![](http://upload-images.jianshu.io/upload_images/3104888-793b09e1cdbcd51b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

*tortoise*
![](http://upload-images.jianshu.io/upload_images/3104888-5e759769061b76be.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 方案二：amend

如果没有使用方案一的形式，就是说已经提交了，但是没有chang-id，可以使用此方案。勾选Amend last commit

这种方案就可以用上次合并的提交，重新获得chang-id,在push就可以了。

命令行的方式我就不用多讲了，都是一样的

![](http://upload-images.jianshu.io/upload_images/3104888-229d0076a6fb9ef8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 方案三
重新拉一遍代码

*不过个人更建议前两种方案！*

可能会有更好的方案，如果你知道，麻烦请在留言里告诉我，独乐乐不如众乐乐！谢谢！

 >注：以上内容版权所有，作者：K丶Aionro，如有转载，请注明出处！谢谢！
