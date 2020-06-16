//
//  ThreadDownloadImagesTableViewCell.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/16.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ThreadDownloadImagesTableViewCell.h"
#import "ThreadDownloadImageModel.h"

@interface ThreadDownloadImagesTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

@implementation ThreadDownloadImagesTableViewCell

- (void)setImageModel:(ThreadDownloadImageModel *)imageModel{
    _imageModel = imageModel;
    self.nameLabel.text = imageModel.name;
    self.numLabel.text = imageModel.download;
}

- (void)setIconImage:(UIImage *)iconImage{
    _iconImage = iconImage;
    self.iconImageView.image = iconImage;
}
@end
