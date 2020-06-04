//
//  ABTableViewCell.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/4.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ABTableViewCell.h"
#import "ABContacts.h"

@interface ABTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;

@end

@implementation ABTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setAbContacts:(ABContacts *)abContacts{
    _abContacts = abContacts;
    self.name.text = abContacts.name;
    self.phone.text = abContacts.phone;
}
@end
