//
//  SDGameTableViewCell.h
//  iOSStudy
//
//  Created by dodoca on 2020/6/16.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class SDGameModel;
@interface SDGameTableViewCell : UITableViewCell
@property(copy,nonatomic)SDGameModel *gameModel;
@end

NS_ASSUME_NONNULL_END
