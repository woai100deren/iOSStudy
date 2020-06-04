//
//  SecondViewController.h
//  iOSStudy
//
//  Created by dodoca on 2020/6/4.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DeliverValueSecondViewDelegate <NSObject>

-(void)deliverValue:(NSString*)value;

@end

@interface DeliverValueSecondViewController : UIViewController
//声明代理属性
@property (nonatomic, weak) id<DeliverValueSecondViewDelegate> delegate;
@end
