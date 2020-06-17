//
//   Toast 说明
//  1，普通的toast提示，不会锁住UI,用户可自由操作，不影响体验
//  2，toastLoading，会锁住UI，
//   重要数据提交时，不想用户返回界面，使用[self.appWindow toastLoading]
//   非重要数据请求时，如果允许用户返回，使用[self.currentView toastLoading]
//
//  Created by dodoca on 2020/6/17.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView(Toast)
+ (void)toastDefaultSetup;

- (void)toastWithText:(NSString *)text;

- (void)toastWithText:(NSString *)text hideAfterDelay:(NSTimeInterval)delay;

- (void)toastError:(NSString *)text;

- (BOOL)noErrorToast:(NSError *)error;

- (void)toastSucceed:(NSString *)text;

- (void)toastLoading;

- (void)toastLoadingWithText:(NSString *)text;

- (void)toastHide;
@end

NS_ASSUME_NONNULL_END
