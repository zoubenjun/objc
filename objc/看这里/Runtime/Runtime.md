#  Runtime

## KVO
KVOController
### 常用方法
```
- (void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context;
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
```
KVO的本质是利用Runtime在实例对象添加监听后生成一个NSKVONotifying_XXX的类对象，然后把实例对象的isa指针指向该类对象。
NSKVONotifying_XXX是XXX类的子类，重写了父类的set、class、dealloc方法，且新增了一个_isKVOA方法。

#### 如果同时实现系统的KVO和自定义KVO会遇到自定义KVO失效和系统KVO崩溃问题。具体原因和解决办法可以查看这篇文章：https://juejin.cn/post/6855129007928082446
- 系统KVO实现的时候会额外分配 0x68 字节的空间，用来存储一些额外信息。并且会持有一个全局字典_NSKeyValueContainerClassForIsa.NSKeyValueContainerClassPerOriginalClass 以 KVO 操作的原类为 key 和 NSKeyValueContainerClass 实例为 value 存储 KVO 类信息。


## KVC

http://www.mamicode.com/info-detail-2952349.html

### 常用方法
// - 将键字符串key所对应的属性的值设置为value。不能设定属性值时，将会引起接收器调用方法2
- (void)setValue:(nullable id)value forKey:(NSString *)key

// - 当属性值设置失败，调用此方法
- (void)setValue:(nullable id)value forUndefinedKey:(NSString *)key

// - 返回标识属性的键字符串所对应的值。如果获取失败，将会引起接收器调用方法4
- (nullable id)valueForKey:(NSString *)key

// - 取值失败，调用此方法
- (nullable id)valueForUndefinedKey:(NSString *)key

// - 在键字符串key所对应的"标量"型属性值设为nil，调用此方法，并抛出NSInvalidArgumentException异常(可demo测试)
- (void)setNilValueForKey:(NSString *)key

// - 默认返回值YES，代表如果没有找到Set方法的话，会按照_key，_iskey，key，iskey的顺序搜索成员，设置成NO就不这样搜索
+ (BOOL)accessInstanceVariablesDirectly

### 赋值实现原理
- 查找是否实现setter方法，依次匹配`set<Key>` 和`_set<Key>`, 如果有，优先调用setter方法完成赋值(注意：set后面的键的第一字字母必须是大写！！)

- 当没找到setter方法，调用accessInstanceVariablesDirectly询问。
   如果返回YES，顺序匹配变量名与 _<key>，_is<Key>,<key>,is<Key>,匹配到则设定其值
   如果返回NO,结束查找。并调用  setValue：forUndefinedKey：报异常

- 如果既没有setter也没有实例变量时，调用 setValue：forUndefinedKey：

### 取值实现原理
- 查找是否实现getter方法，依次匹配`_get<Key>` 和 `_<key>` 和 `is<Key>`和`_<Key>`，如果找到，直接返回。
   如果返回的是对象指针类型，则返回结果。
   如果返回的是NSNumber转换所支持的标量类型之一，则返回一个NSNumber
   否则，将返回一个NSValue

   - 当没有找到getter方法，调用accessInstanceVariablesDirectly询问
   如果返回YES， _<key>，_is<Key>,<key>,is<Key>，找到了返回对应的值
   如果返回NO，结束查找。并调用 valueForUndefinedKey: 报异常

  - 如果没找到getter方法和属性值，调用 valueForUndefinedKey: 报异常

## Runtime使用场景
- 做用户埋点统计,自定义一个方法替换uicontrol的sendAction:to:forEvent
- 处理异常崩溃（NSDictionary, NSMutableDictionary,  NSArray, NSMutableArray 的处理）
- 按钮最小点击区设置
- json转model

## 消息传递流程

## 消息转发流程
+ (BOOL)resolveInstanceMethod:(SEL)sel;
+ (BOOL)resolveClassMethod:(SEL)sel;
- (id)forwardingTargetForSelector:(SEL)aSelector;
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector;
- (void)forwardInvocation:(NSInvocation *)anInvocation;
- (void)doesNotRecognizeSelector:(SEL)aSelector;

1. Runtime 会发送 +resolveInstanceMethod: 或者 +resolveClassMethod: 尝试去 resolve(重启) 这个消息；
2. 如果 resolve 方法返回 NO，Runtime 就发送 -forwardingTargetForSelector: 允许你把这个消息转发给另一个对象；
3. 如果没有新的目标对象返回， Runtime 就会发送 -methodSignatureForSelector: 和 -forwardInvocation: 消息。你可以发送 -invokeWithTarget: 消息来手动转发消息或者发送 -doesNotRecognizeSelector: 抛出异常。

