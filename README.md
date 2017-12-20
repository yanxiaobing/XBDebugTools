# XBDebugTools

XBDebugTools目前主要是用于收集Crash信息和API接口相关信息。

  日常工作中常常遇到领导、测试人员、以及用iPhone的同事拿着手机跑来反馈问题，除了一些UI的问题对于他们来说比较好描述，其他的问题通常被他们描述为：app挂了啦，奔溃了啦，没有数据啦，更进一步的描述他们基本就说不清，听完真是一脸懵逼，平时赶新功能的话，对于那些不能很快追踪或者重现的问题可能就被忽略了。虽然可以接入友盟等第三方崩溃日志检测工具，但是相关日志的提交的及时性不受自己的控制，对于领导等测试人员遇到并反馈问题，特别是领导，你不及时告诉他问题的原因还真不行。

  本工具会持续维护，如果有通用需求会尽快加入进去。
  第一次制作开源工具库，难免有不足之处，还请大家不吝指教。

## 安装方式
目前可以通过两种方式将XBDebugTools集成到您的项目中。
- [下载 XBDebugTools](https://github.com/yanxiaobing/XBDebugTools/archive/master.zip) 然后将XBDebugTools文件夹拖入您的工程即可。
- 通过CocoaPods集成

### 通过 CocoaPods 安装

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like XBDebugTools in your projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 0.39.0+ is required to build AFNetworking 3.0.0+.

#### Podfile

To integrate XBDebugTools into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
pod 'XBDebugTools'
end
```

Then, run the following command:

```bash
$ pod install
```

## 工程结构

### XBDebugTools

- `XBDebugTools`

### DebugInfoModel

- `XBApiDebugInfo`
- `XBExceptionInfo`

### DebugView

- `XBDebugInfoListViewController`
- `XBDebugDetailsViewController`
- `XBDebugInfoListTableViewCell`

## Usage

`XBDebugTools` 包含了所有功能接口，目前主要包含Crash收集、添加API相关信息、展示这些Crash和Api信息的接口.

### Crash信息收集
在```AppDelegate.m```的```- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions```方法1```return```前执行```[XBDebugTools sharedInstance];```即可。具体如下：
```objective-c
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
#if DEBUG
[XBDebugTools sharedInstance]; //一定放在return前，紧贴return语句，否则可能被第三方收集工具重写相关方法导致收集不到Crash信息
#endif
return YES;
}
```
### API信息收集
在API集中处理的地方调用```-(void)addApiDebugInfoWithDomain:(NSString *)domain url:(NSString *)url params:(NSDictionary *)params response:(NSDictionary *)response succeed:(BOOL)succeed```方法，即```[[XBDebugTools sharedInstance] addApiDebugInfoWithDomain:@"" url:URLString params:params response:dict succeed:YES];```。现在使用[AFNetworking](https://github.com/AFNetworking/AFNetworking) 项目比较多，这里则用该库举例子了。具体如下：
```objective-c
NSURLSessionConfiguration * configuration = [ NSURLSessionConfiguration  defaultSessionConfiguration ];
AFURLSessionManager * sessionManager = [[AFURLSessionManager alloc ] initWithSessionConfiguration： configuration];
[sessionManager POST:URLString parameters:params progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//解析字典
NSData *data = [self unzipData:responseObject];
NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
#if DEBUG
[[XBDebugTools sharedInstance] addApiDebugInfoWithDomain:@"" url:URLString params:params response:dict succeed:YES];
#endif
} failure:^(NSURLSessionDataTask *task, NSError *error) {
#if DEBUG
[[XBDebugTools sharedInstance] addApiDebugInfoWithDomain:@"" url:URLString params:params response:@{@"errorDes":error.localizedDescription} succeed:NO];
#endif
}];
```

### 展示收集的信息
在APP中提供一个展示收集的debug信息的入口，比如创建一个按钮，在响应方法中调用```[[XBDebugTools sharedInstance] showExceptionTools];```即可。

## License

XBDebugTools is released under the MIT license. See LICENSE for details.



