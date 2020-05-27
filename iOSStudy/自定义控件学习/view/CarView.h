//
//  CarView.h
//  iOSStudy
//
//  Created by dodoca on 2020/5/22.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Car;

@interface CarView : UIView

@property(nonatomic,copy) Car *car;

+(instancetype)carView;
@end
