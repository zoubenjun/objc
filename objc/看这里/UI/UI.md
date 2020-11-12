#  UI

## 事件传递
```
1、产生触摸事件->UIApplication事件队列->[UIWindow hitTest:withEvent:]->返回更合适的view->[子控件 hitTest:withEvent:]->返回最合适的view
2、想让谁成为最合适的view就重写谁自己的父控件的hitTest:withEvent:方法返回指定的子控件

// 此方法返回的View是本次点击事件需要的最佳View
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
// 判断一个点是否落在范围内
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    // 1.判断下窗口能否接收事件
    if (self.userInteractionEnabled == NO || self.hidden == YES ||  self.alpha <= 0.01) return nil;
    // 2.判断下点在不在窗口上
    // 不在窗口上
    if ([self pointInside:point withEvent:event] == NO) return nil;
    // 3.从后往前遍历子控件数组
    int count = (int)self.subviews.count;
    for (int i = count - 1; i >= 0; i--)     {
        // 获取子控件
        UIView *childView = self.subviews[i];
        // 坐标系的转换,把窗口上的点转换为子控件上的点
        // 把自己控件上的点转换成子控件上的点
        CGPoint childP = [self convertPoint:point toView:childView];
        UIView *fitView = [childView hitTest:childP withEvent:event];
        if (fitView) {
            // 如果能找到最合适的view
            return fitView;
        }
    }
    // 4.没有找到更合适的view，也就是没有比自己更合适的view
    return self;
}
// 作用:判断下传入过来的点在不在方法调用者的坐标系上
// point:是方法调用者坐标系上的点
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
//{
// return NO;
//}

```

## 响应链
```
判断当前view是否为控制器的view，不是传递到父view是传递到控制器
1>如果当前view是控制器的view，那么控制器就是上一个响应者，事件就传递给控制器；如果当前view不是控制器的view，那么父视图就是当前view的上一个响应者，事件就传递给它的父视图
2>在视图层次结构的最顶级视图，如果也不能处理收到的事件或消息，则其将事件或消息传递给window对象进行处理
3>如果window对象也不处理，则其将事件或消息传递给UIApplication对象
4>如果UIApplication也不能处理该事件或消息，则将其丢弃


只需要实现touches就能响应事件，如果在里面调用super touches方法，就会把时间继续传递下去
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
```

## UIView 和CALayer UIResponder
UIView继承UIResponder有一个属性是CALayer

### UIView的frame，bounds，center的区别、
- frame只针对父坐标系的，修改一个view的frame是修改了他对父view的位置。
- bounds的参考坐标系是自身，修改bounds。本身默认(0,0)假如修改为（-50，50）那么原来的0，0
位置就是现在的（-50，50），他的子视图的位置（0，0）就会显示在50，-50的位置
- 修改bounds的sizeframe的size也会修改为同样的值
- center是frame.origin.x+(frame.size.width/2),frame.origin.y+(frame.size.height/2)

```
1、frame和bounds都是CGRect类型有x,y坐标的width，height
2、center是CGPoint只有x,y

UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
redView.backgroundColor = [UIColor redColor];
[self.view addSubview:redView];

UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(50, 50, 100, 100)];
greenView.backgroundColor = [UIColor greenColor];
[redView addSubview:greenView];

UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(25, 25, 50, 50)];
blueView.backgroundColor = [UIColor blueColor];
[greenView addSubview:blueView];

```
## CALayer的属性 后面补充，这里我自己也没弄清楚
```
frame
bounds
position //position是不是就是anchorPoint在superLayer中的位置
position.x = frame.origin.x + anchorPoint.x * bounds.size.width；  
position.y = frame.origin.y + anchorPoint.y * bounds.size.height

zPosition
anchorPoint //以自己的左上角为原点(0, 0)。它的x、y取值范围都是0~1，默认值为（0.5, 0.5）
anchorPointZ

```
## UIResponder

UIResponder : NSObject

- 主要方法
```
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
```


## UIControl
主要封装了addTarget，UIControlEvents等事件相关的东西

## UIButton
UIButton->UIControl->UIView->UIResponder->NSObject

## UIViewController
UIViewController->UIResponder->NSObject

## UILabel
UILabel->UIView->UIResponder->NSObject

## UITableView
UITableView->UIScrollView->UIView->UIResponder->NSObject

## UICollectionView
UICollectionView->UIScrollView->UIView->UIResponder->NSObject
