#  创建CocoaPods私有库

## 前期准备工作
* 在[github](https://github.com)创建一个账号。
* 分别创建两个 repository。 我创建的一个是 [ZBJPoplar](https://github.com/zoubenjun/ZBJPoplar.git) 用于存放具体代码，一个 [ZBJPoplarRepo](https://github.com/zoubenjun/ZBJPoplarRepo.git) 用于存放 podspec
* 安装 CocoaPods ，在终端执行下面命令：
```
gem install cocoapods

```
## 开始制作自有库

*   ZBJPoplar 是我自己创建的项目名称，下面看到 ZBJPoplar 请换位你自己创建项目的名称，在这里提前说明。

1、在终端切换到工作目录下，执行下面命令。ZBJPoplar 是我的项目名称，这里改为你自己的
```
pod lib create ZBJPoplar
```
* What platform do you want to use?? [ iOS / macOS ] 输入 iOS 
* What language do you want to use?? [ Swift / ObjC ] 输入 ObjC  选择语言，我使用 Objective-C ，所以选择ObjC
* Would you like to include a demo application with your library? [ Yes / No ]  输入 Yes 这里是是否需要一个demo工程，方便测试，我选择 Yes
* Which testing frameworks will you use? [ Specta / Kiwi / None ] 输入 None   测试框架，我不需要所以选择 None
* Would you like to do view based testing? [ Yes / No ] 输入 No   是否需要测试，我选择 No
* What is your class prefix? 输入 ZBJ  这里是类的前缀，我的前缀 ZBJ ，这里建议至少3个字符（大写）

```
What platform do you want to use?? [ iOS / macOS ]
 > ios

What language do you want to use?? [ Swift / ObjC ]
 > objc

Would you like to include a demo application with your library? [ Yes / No ]
 > yes

Which testing frameworks will you use? [ Specta / Kiwi / None ]
 > none

Would you like to do view based testing? [ Yes / No ]
 > no

What is your class prefix?
 > ZBJ
```

2、提交代码到 ZBJPoplar 仓库，注意换成你自己的仓库地址哈
```
git add .
git commit -m "Initial Commit"
git remote add origin https://github.com/zoubenjun/ZBJPoplar.git //替换 zoubenjun 为你自己的 github.com username
git push -u origin master
```

3、添加具体代码
> 在 'ZBJPoplar/Classes/' 下面创建自己的代码文件，打开 Example/ZBJPoplar.xcworkspace 工程，然后在 Pods/Development Pods/ZBJPoplar 下添加刚才的代码文件。这里一定要把代码放在 'ZBJPoplar/Classes/' 下面，不然可能会找不到添加的代码，如果放在其他地方应改是需要修改 .podspec 文件的s.source_files 路径。 （ZBJPoplar 是我的项目名称）

4、测试添加的代码能否正常使用
> 1、cd 到Example文件下，然后pod install下，更新Example项目的pod。
> 2、在Example 里面使用自己添加的代码，看看是否能正常使用。

5、修改 ZBJPoplar.podspec 配置信息

* 修改 s.summary
* 修改 s.description 这里内容最好比 s.summary 更多
* 修改 s.homepage 里面的 url 为之前创建的仓库 url 
* 修改 s.source url 同上
* 其他配置信息看自己需要修改，不懂得可以网站找下。

下面是我修改后的信息：
```
#
# Be sure to run `pod lib lint ZBJPoplar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZBJPoplar'
  s.version          = '0.1.1'
  s.summary          = 'Personal Category, Utils.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                       Personal Category, Utils. ZBJPoplar named by my son, a lovely boy.
                       DESC

  s.homepage         = 'https://github.com/zoubenjun/ZBJPoplar'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zoubenjun' => '502153525@qq.com' }
  s.source           = { :git => 'https://github.com/zoubenjun/ZBJPoplar.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  
  s.frameworks = 'UIKit'
  # s.public_header_files = 'ZBJPoplar/Classes/**/*.h'
  s.source_files = 'ZBJPoplar/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZBJPoplar' => ['ZBJPoplar/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

```

6、检验  .podspec 配置信息是否正确
* 首先切换到 ZBJPoplar.podspec 的目录，然后执行
```
pod lib lint --allow-warnings ZBJPoplar.podspec
```

7、第六步没有错误的话，提交代码到git仓库，有错误就解决后提交代码
```
git add .
git commit -m "add code"
git push origin master
```

8、打标签,注意这里的版本号和 ZBJPoplar.podspec 保持一致
```
git tag -a 0.1.1 -m 'release version 0.1.1'
git push origin 0.1.1
```

9、添加远程索引库，注意改为自己的仓库地址，验证远程仓库
```
pod repo add ZBJPoplarRepo https://github.com/zoubenjun/ZBJPoplarRepo.git

pod spec lint --allow-warnings

```

10、第九步验证通过就可以发布，如果有错就修改后再发布
```
pod repo push ZBJPoplarRepo ZBJPoplar.podspec --allow-warnings
```

11、创建一个新的工程，验证一下刚才提交的库是否可用
```
1、创建一个Test工程
2、终端 touch Podfile, 在新建的 Podfile 添加下面代码

platform :ios, '9.0'

source 'https://github.com/zoubenjun/ZBJPoplarRepo.git'

target 'Test' do
  pod 'ZBJPoplar', '0.1.1'
end
```

12、更新提交
```
git commit -a -m "xxx"
git push origin master
git tag -a x.x.x -m 'release version x.x.x'
git push origin x.x.x
pod spec lint --allow-warnings
pod repo push ZBJPoplarRepo ZBJPoplar.podspec --allow-warnings
```

* 删除tag
```
//删除本地tag 
git tag -d x.x.x
//删除远程tag 
git push origin -d tag x.x.x
```


