//
//  DBImageDealView.h
//  iOSStudy
//
//  Created by 王静 on 2020/6/11.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class DBImageDealView;
@protocol DBImageDealViewDelegate <NSObject>

-(void)dbImageDealView:(DBImageDealView *)dbImageDealView newImage:(UIImage *)newImage;

@end

@interface DBImageDealView : UIView
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,weak) id<DBImageDealViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
