//
//  UIView+Extensions.h
//  iOSStudy
//
//  Created by dodoca on 2020/6/11.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KFGetController)
//获取当前view所在的控制器
- (UIViewController *)viewController;
@end

NS_ASSUME_NONNULL_END
