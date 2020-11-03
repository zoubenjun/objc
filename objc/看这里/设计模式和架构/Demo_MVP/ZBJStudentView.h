//
//  ZBJStudentView.h
//  objc
//
//  Created by zbj on 2020/11/3.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZBJStudentView;

@protocol ZBJStudentViewDelegate <NSObject>

@optional
- (void)viewDidClick:(ZBJStudentView *)studentView;
@end

@interface ZBJStudentView : UIView

@property(nonatomic, weak, readonly) UILabel *nameLabel;
@property(nonatomic, weak, readonly) UILabel *ageLabel;
@property(nonatomic, weak, readonly) UILabel *noLabel;

@property(nonatomic, weak) id<ZBJStudentViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
