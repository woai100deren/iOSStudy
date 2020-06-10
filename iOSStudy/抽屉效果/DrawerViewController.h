//
//  DrawerViewController.h
//  iOSStudy
//
//  Created by dodoca on 2020/6/9.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawerViewController : UIViewController
//框架对外公开，不允许修改这三个view，所以加上readonly
@property(weak,nonatomic,readonly)UIView *mainView;
@property(weak,nonatomic,readonly)UIView *leftView;
@property(weak,nonatomic,readonly)UIView *rightView;
@end

NS_ASSUME_NONNULL_END
