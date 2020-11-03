//
//  ZBJPersonView.h
//  objc
//
//  Created by zbj on 2020/11/3.
//  Copyright © 2020 zoubenjun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZBJPersonView;

@protocol ZBJPersonViewDelegate <NSObject>

@optional
- (void)viewDidClick:(ZBJPersonView *)personView;
@end

@interface ZBJPersonView : UIView

@property(nonatomic, weak, readonly) UILabel *nameLabel;
@property(nonatomic, weak, readonly) UILabel *ageLabel;
@property(nonatomic, weak) id<ZBJPersonViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
