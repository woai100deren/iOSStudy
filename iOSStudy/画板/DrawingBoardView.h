//
//  DrawingBoardView.h
//  iOSStudy
//
//  Created by dodoca on 2020/6/11.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DrawingBoardView : UIView
@property (nonatomic,assign)UIColor *penColor;
@property (nonatomic,assign)CGFloat penStroke;
/**清屏*/
-(void)clearAll;
/**撤销*/
-(void)repeal;
/**橡皮擦*/
-(void)eraser;
@end

NS_ASSUME_NONNULL_END
