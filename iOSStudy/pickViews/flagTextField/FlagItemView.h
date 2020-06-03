//
//  FlagItemView.h
//  iOSStudy
//
//  Created by dodoca on 2020/6/2.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlagItem.h"

@interface FlagItemView : UIView
@property (nonatomic,strong) FlagItem *data;

+(instancetype)flagItemView;

@end
