//
//  ABAddContactsViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/3.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ABAddContactsViewController.h"
#import "MJExtension.h"
#import "ABContacts.h"

@interface ABAddContactsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@end

@implementation ABAddContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)addContacts:(id)sender {
    [self writeDataToPlist];
}

- (void)writeDataToPlist {
    //这里使用位于沙盒的plist（程序会自动新建的那一个）
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [cachePath stringByAppendingPathComponent:@"addressBook.plist"];
    
    NSMutableArray *contactsArray = [self getdataFromPlist];
    ABContacts *contacts = [ABContacts contactsWithName:self.nameTF.text AndPhone:self.phoneTF.text];
    [contactsArray addObject:contacts];
    
    [contactsArray writeToFile:filePath atomically:YES];
}

-(NSMutableArray*)getdataFromPlist{
    NSMutableArray *contactsArray = [ABContacts mj_objectArrayWithFilename:@"addressBook.plist"];
    return contactsArray;
}

@end
