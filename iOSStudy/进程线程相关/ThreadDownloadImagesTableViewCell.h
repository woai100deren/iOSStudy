//
//  ThreadDownloadImagesTableViewCell.h
//  iOSStudy
//
//  Created by dodoca on 2020/6/16.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ThreadDownloadImageModel;
@interface ThreadDownloadImagesTableViewCell : UITableViewCell
@property(copy,nonatomic) ThreadDownloadImageModel *imageModel;
/**nullable允许传空*/
@property(copy,nonatomic,nullable) UIImage *iconImage;
@end

NS_ASSUME_NONNULL_END
