//
//  SecondViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/4.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "DeliverValueSecondViewController.h"


@interface DeliverValueSecondViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@end

@implementation DeliverValueSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"第二个页面";
}
- (IBAction)goBack:(id)sender {
    [self goBack];
}

-(void)goBack{
    [self.delegate deliverValue:self.textField.text];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
