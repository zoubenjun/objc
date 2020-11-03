//
//  ZBJTeacherView.h
//  objc
//
//  Created by zbj on 2020/11/3.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZBJTeacherView, ZBJTeacherViewModel;

@protocol ZBJTeacherViewDelegate <NSObject>

@optional
- (void)viewDidClick:(ZBJTeacherView *)teacherView;
@end

@interface ZBJTeacherView : UIView

@property(nonatomic, weak, readonly) UILabel *nameLabel;
@property(nonatomic, weak, readonly) UILabel *ageLabel;
@property(nonatomic, weak, readonly) UILabel *courseLabel;

@property(nonatomic, weak) id<ZBJTeacherViewDelegate> delegate;
@property(nonatomic, weak) ZBJTeacherViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
