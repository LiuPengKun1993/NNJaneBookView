# NNJaneBookView
#### 仿简书个人主页多页面滑动视图。

##### 思路：
- 导航栏上面的头像会随着视图的上下滑动而变大变小，这里注册了一个通知，用来监听视图的上下滑动，可以根据偏移量的值来改变头像的大小。
- 此 UI 页面分为三部分，第一部分是信息展示，用来显示昵称签名等；第二部分是标签栏，即“动态”，“文章”，“更多”这三个标签；第三部分是主要显示内容；
- 我这里用了这样的思路：页面底部是一个 UIScrollView; 接着 UIScrollView 上面 add 了三个 UITableView ；信息展示以及标签栏放在 UITableView 的 tableHeaderView 中；接着挨个实现其功能即可。
  
##### 效果图

![效果图](https://github.com/liuzhongning/NNJaneBookView/blob/master/GIF/jianshu.gif)


- 博客地址 http://www.jianshu.com/p/c82a83fd400a ,如有疑问或有建议的地方，欢迎讨论。
