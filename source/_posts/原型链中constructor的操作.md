---
title: 原型链中constructor的操作
date: 2016-10-16 21:10:13
tags: javascript
---

**在读公司大神写的一个框架的时候，读到此句的时候，颇是费解，感觉无意义，后几经测试和朋友的讨论，通过下面的例子能很好的解释这句话的原因。**

![当时读到的源码！！](http://upload-images.jianshu.io/upload_images/3104888-d04c1f1e7aae4748.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

<hr/>

![这个例子讲的就是B继承A](http://upload-images.jianshu.io/upload_images/3104888-9ed70cf9950d9724.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

第7行类继承：A.call(this.x);实现原型继承的是第12行：B.prototype=newA();  就是说把B的原型指向了A的1个实例对象，这个实例对象具有x属性，为undefined，还具有a属性，值为"a"。所以B原型也具有了这2个属性（或者说，B和A建立了原型链，B是A的下级）。而因为方才的类继承，B的实例对象也具有了x属性，也就是说obj对象有2个同名的x属性，此时原型属性x要让位于实例对象属性x，所以obj.x是1，而非undefined。第13行又定义了原型方法b2，所以B原型也具有了b2。虽然第9~11行设置了原型方法b1，但是你会发现第12行执行后，B原型不再具有b1方法，也就是obj.b1是undefined。因为第12行使得B原型指向改变，原来具有b1的原型对象被抛弃，自然就没有b1了。

 第12行执行完后，B原型（B.prototype）指向了A的实例对象，而A的实例对象的构造器是构造函数A，所以B.prototype.constructor就是构造对象A了（换句话说，A构造了B的原型）。

 alert(B.prototype.constructor)出来后就是"function A(x){...}" 。同样地，obj.constructor也是A构造对象，alert(obj.constructor)出来后就是"function A(x){...}" ，也就是说B.prototype.constructor===obj.constructor（true），但是B.prototype===obj.constructor.prototype（false），因为前者是B的原型，具有成员：x,a,b2，后者是A的原型，具有成员：a。如何修正这个问题呢，就在第16行，将B原型的构造器重新指向了B构造函数，那么B.prototype===obj.constructor.prototype（true），都具有成员：x,a,b2。

 如果没有第16行，那是不是obj = new B(1,3)会去调用A构造函数实例化呢？答案是否定的，你会发现obj.y=3，所以仍然是调用的B构造函数实例化的。虽然obj.constructor===A(true)，但是对于new B()的行为来说，执行了上面所说的通过构造函数创建实例对象的3个步骤，第一步，创建空对象；第二步，obj.__proto__ === B.prototype，B.prototype是具有x,a,b2成员的，obj.constructor指向了B.prototype.constructor，即构造函数A；第三步，调用的构造函数B去设置和初始化成员，具有了属性x,y。虽然不加16行不影响obj的属性，但如上一段说，却影响obj.constructor和obj.constructor.prototype。所以在使用了原型继承后，要进行修正的操作。

 关于第12、16行，总言之，第12行使得B原型继承了A的原型对象的所有成员，但是也使得B的实例对象的构造器的原型指向了A原型，所以要通过第16行修正这个缺陷。

 *如果有什么不对的地方，请提出来，大家一块探讨!*

 >注：以上内容版权所有，作者：K丶Aionro，如有转载，请注明出处！谢谢！

