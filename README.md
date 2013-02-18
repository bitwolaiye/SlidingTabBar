SlidingTabBar
=============

support IOS tab bar can switch view with scroll horizontally.

让IOS的tabbar也可以像android中的ViewPager一样滑动的切换view。具体来说就是左右拖动来切换tabbar的各个view（点击tabbar后view之间的切换也是滑动）。

###思路
在view中增加一个专门用于横向滚动的scrollview，然后在这个scrollview中增加其他view的截图的UIImageView，当滚动到其他的view的截图时，通知tabbar controller，将选中的tabbar index改变。

当点击tabbar的时候，同样是将需要显示的几个view（包括需要滑过的view，所以可能不止一个）进行截图，然后排列好置于顶部，做一个滚动动画然后消失（消失时下面的view已准备好显示，所以视觉上会觉得view是滑动过来的）。

###如何使用
1. 在项目中添加QuartzCore.framework引用
2. 如果你使用的是xcode4.6,请在storyboard中关闭auto-layout。（在storyboard界面按option+command+1，然后你可以在右边看见一个选择框“Use Autolayout”,不要选中它）
3. 把 SlidingTabBarItemInterface.h, SlidingTabBarController.h, SlidingTabBarController.m, SlidingViewController.h, SlidingViewController.m 加入到你的项目中
4. 在storyboard中指定tabbar controller的自定义类为SlidingTabBarController。
5. 你可以添加你自己的viewcontroller，然后继承于SlidingViewController。在storyboard中，你在一个空白的viewcontroller中添加一个UIScrollView，设置"Bounce Horizontally"选中，并于你的viewcontroller类里的scrollView链接上。
6. ok。运行。

###已知问题
1. 滑动切换时，必须要等滚动动画完成时，tabbar才会切换。更合理的应该是手指离开屏幕，如果此时滑动的距离已会切换view则tabbar就开始切换，而非等动画走完。
2. 第一次进入程序时，由于其他view还没真正加载，所以截图是空白。
3. 快速的切换tabbar会导致界面卡住假死。我想应该是滑动动画还没完就开始另一个动画了，累积多了就像假死了。
4. 快速的连续滑动最后一个界面有点卡顿。没想好为什么，猜测是view加载需要点时间，还没加载完？
 
###我
email：bitwolaiye@gmail.com

刚学习ios开发半年时间，有很多东西不太了解，忘指点。

###How to use
1. add QuartzCore.framework to framework
2. if you use xcode 4.6, please check your storyboard use auto-layout.(select storyboard file and press option+command+1, you will see an checkbox named 'Use Autolayout', turn it off)
3. add SlidingTabBarItemInterface.h, SlidingTabBarController.h, SlidingTabBarController.m, SlidingViewController.h, SlidingViewController.m to your project.

not translate yet…