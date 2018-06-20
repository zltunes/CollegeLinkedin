# CollegeLinkedin

> 大学生职场社交平台。类似[赤兔](http://www.chitu.com/)。

# 项目简介
这是一款由东南大学创梦空间（DreamSpace）开发的联接大学生群体与真实职场的社交应用。可以帮助即将步入或已经步入职场的大学生展示身份、拓展人脉、高效在线沟通。它会让大学生迅速融入职场，感受到职场社交也可以温暖、鲜活而有趣。

登 录|注册信息|我的圈子|人脉资源
------------ | ------------- | ------------| ------------
![图片1][1]|![图片2][2]|![图片3][3]|![图片4][4]

个人设置|基本资料|行业职能|二 维 码
------------ | ------------- | ------------| ------------
![图片5][5]|![图片6][6]|![图片7][7]|![图片8][8]

# 开发语言
    Objective-C
# 编译环境
    OS X 10.11.1
    Xcode-Version 7.1.1
# 支持平台
	iOS 7.1 以上
# 测试机型
	iPhone 4S
	iPhone 5
	iPhone 5S
	iPhone 6
	iPhone 6 Plus
	iPhone 6S
	iPhone 6S Plus

# 文件目录
    .
    ├── CollegeLinkedin
    |   ├── LoginAndRegister：登录注册(RAC+MVVM)
    |   |   ├── Request：网络请求
    |   |   ├── Controller：视图模型绑定 
    |   |   ├── ViewModel：登录注册业务逻辑
    |   |   └── Model：数据类 
    |   ├── Model：数据类
    |   |   ├── Circle：圈子
    |   |   ├── Contacts：人脉
    |   |   └── Me：我
    │   ├── View：视图类
    |   |   ├── Circle：圈子
    |   |   ├── Contacts：人脉
    |   |   └── Me：我
    │   ├── Controller：控制器，对应app中的各个页面
    |   |   ├── Circle：圈子
    |   |   ├── Contacts：人脉
    |   |   └── Me：我
    │   ├── Request：网络请求（未完）
    │   ├── Resource：资源文件
    │   ├── Util：常用工具类
    │   ├── Vendor：用到的一些第三方类库，部分有改动
    │   |   ├── HYActivityView
    │   |   ├── SDPhotoBrowser
    │   |   ├── CustomViewFromXib
    │   |   ├── PickerView
    │   |   └── TextFieldValidator
    │   └── Main.storyboard：全部VC及跳转关系
    └── Pods：项目使用了 CocoaPods

# CocoaPods库
 - [SDWebImage](https://github.com/rs/SDWebImage)：图片加载
 - [AFNetworking](https://github.com/AFNetworking/AFNetworking)：著名 iOS 网络框架
 - [CustomIOSAlertView](https://github.com/wimagguc/ios-custom-alertview)：自定义 UIAlertView
 - [FXBlurView](https://github.com/nicklockwood/FXBlurView)：毛玻璃效果
 - [IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager)：键盘管理
 - [MJExtension](https://github.com/CoderMJLee/MJExtension)：JSON模型转换
 - [MJRefresh](https://github.com/CoderMJLee/MJRefresh)：刷新
 - [Reachability](https://github.com/tonymillion/Reachability)：判断网络连接情况
 - [Realm](https://realm.io/)：著名移动端数据库，可替代 sqlite/coreData
 - [ReactiveCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa)：基于响应式编程思想的oc实践
 - [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD): 优美轻量的 HUD 
 - [UITableView+FDTemplateLayoutCell](https://github.com/forkingdog/UITableView-FDTemplateLayoutCell)自动计算Cell高度，配合 AutoLayout 使用
 
  [1]:http://ww3.sinaimg.cn/large/005tGCqhjw1f1o974fswjj30ku112q68.jpg
  [2]:http://ww1.sinaimg.cn/large/005tGCqhjw1f1o99si15aj30ku112myv.jpg
  [3]:http://ww2.sinaimg.cn/large/005tGCqhjw1f1o97t3gxcj30ku1120xj.jpg
  [4]:http://ww2.sinaimg.cn/large/005tGCqhjw1f1o98dejq4j30ku11241l.jpg
  [5]:http://ww3.sinaimg.cn/large/005tGCqhjw1f1o98qqlv4j30ku112wgu.jpg
  [6]:http://ww1.sinaimg.cn/large/005tGCqhjw1f1o98z3x9ij30ku11276o.jpg
  [7]:http://ww2.sinaimg.cn/large/005tGCqhjw1f1o998nck2j30ku112goh.jpg
  [8]:http://ww2.sinaimg.cn/large/005tGCqhjw1f1o99j9c5jj30ku112787.jpg

# 项目中的技术亮点

- [借鉴 MVVM 设计思想瘦身 ViewController](http://zltunes.com/ios-jia-gou-pian-yi/)
- RAC + MVVM 处理注册登录模块
- Model 层使用 Ream 做数据持久化处理
- [View Controller 容器](child view controller)优化VC，delegate解决通信问题
- 重写 ```UIView initWithFrame:(CGRect)frame``` 与 ```initWithCoder:(NSCoder *)aDecoder```方法使得任意View可从xib加载（不再限于 ViewController 和 UITableViewCell）
