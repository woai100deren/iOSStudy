//
//  ABAddContactsViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/3.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ABAddContactsViewController.h"
#import "ABContacts.h"
#import "NSString+Extensions.h"

@interface ABAddContactsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@end

@implementation ABAddContactsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)addContacts:(id)sender {
    if([NSString isBlankString:self.nameTF.text] || [NSString isBlankString:self.phoneTF.text]){
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"姓名或电话不允许为空" preferredStyle:UIAlertControllerStyleAlert];
                   UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:nil];
                   [alertController addAction:okAction];
                   [self presentViewController:alertController animated:YES completion:nil];
    }else{
        [self writeDataToPlist];
    }
}

- (void)writeDataToPlist {
     //获取沙盒Document路径
    NSString *currentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [currentPath stringByAppendingPathComponent:@"addressBook.plist"];
    
    NSMutableArray *contactsArray = [self getdataFromPlist];
    if(!contactsArray){
        contactsArray = [[NSMutableArray alloc] init];
    }
    
    NSMutableDictionary *contactsDic = [[NSMutableDictionary alloc]init];
    [contactsDic setValue:self.nameTF.text forKey:@"name"];
    [contactsDic setValue:self.phoneTF.text forKey:@"phone"];
    
    [contactsArray addObject:contactsDic];
    //若之前没有该文件，会自动创建该文件
    if ([contactsArray writeToFile:filePath atomically:YES]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"添加失败" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleDefault handler:nil];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

-(NSMutableArray*)getdataFromPlist{
    
    //沙盒获取路径
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePatch = [path stringByAppendingPathComponent:@"addressBook.plist"];//没有会自动创建
    NSMutableArray *sandBoxDataDic = [[NSMutableArray alloc]initWithContentsOfFile:filePatch];
    
    return sandBoxDataDic;
}

@end
