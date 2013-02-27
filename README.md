SlidingTabBar
=============

support IOS tab bar can switch view with scroll horizontally.

让IOS的tabbar也可以像android中的ViewPager一样滑动的切换view。具体来说就是左右拖动来切换tabbar的各个view（点击tabbar后view之间的切换也是滑动）。

###思路

以前的思路
>在view中增加一个专门用于横向滚动的scrollview，然后在这个scrollview中增加其他view的截图的UIImageView，当滚动到其他的view的截图时，通知tabbar controller，将选中的tabbar index改变。
当点击tabbar的时候，同样是将需要显示的几个view（包括需要滑过的view，所以可能不止一个）进行截图，然后排列好置于顶部，做一个滚动动画然后消失（消失时下面的view已准备好显示，所以视觉上会觉得view是滑动过来的）。

###如何使用
目前是演示项目

###已知问题

 
###我
email：bitwolaiye@gmail.com

刚学习ios开发半年时间，有很多东西不太了解，忘指点。

###How to use
not translate yet…