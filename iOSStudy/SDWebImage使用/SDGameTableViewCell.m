//
//  SDGameTableViewCell.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/16.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "SDGameTableViewCell.h"
#import <SDWebImage/SDWebImage.h>
#import "SDGameModel.h"

@interface SDGameTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *downloadNumLabel;

@end

@implementation SDGameTableViewCell

- (void)setGameModel:(SDGameModel *)gameModel{
    _gameModel = gameModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.gameModel.icon]];
    self.nameLabel.text = self.gameModel.name;
    self.downloadNumLabel.text = self.gameModel.download;
}

@end
