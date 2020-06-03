//
//  PickViewUseViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/2.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "PickViewUseViewController.h"

@interface PickViewUseViewController ()
@property (weak, nonatomic) IBOutlet UITextField *countryTF;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTF;
@property (weak, nonatomic) IBOutlet UITextField *cityTF;

@end

@implementation PickViewUseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"PickView使用";
}
@end
