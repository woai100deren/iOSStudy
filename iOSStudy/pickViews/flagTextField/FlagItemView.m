//
//  FlagItemView.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/2.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "FlagItemView.h"

@interface FlagItemView()
@property (weak, nonatomic) IBOutlet UILabel *flagNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *flagImageView;
@end

@implementation FlagItemView

- (void)setData:(FlagItem *)data{
    _data = data;
    self.flagNameLabel.text = data.flagName;
    self.flagImageView.image = [UIImage imageNamed:data.flagImage];
}

+(instancetype)flagItemView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([FlagItemView class]) owner:nil options:nil] lastObject];
}
@end
