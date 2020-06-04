//
//  ABContactsDetailViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/4.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ABContactsDetailViewController.h"
#import "ABContacts.h"

@interface ABContactsDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property(nonatomic,strong)ABContacts *abContacts;
@property(nonatomic,assign)long index;
@end

@implementation ABContactsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self action:@selector(edit)];
    
    //由于setData会在viewDidLoad之前执行，所以设置数据不能放到setData中。
    self.nameTF.text = self.abContacts.name;
    self.phoneTF.text = self.abContacts.phone;
}

-(void)setData:(ABContacts *)abContacts inIndex:(long)index{
    self.abContacts = abContacts;
    self.index = index;
}

-(void)edit{
    if(self.saveButton.isHidden){
        self.navigationItem.rightBarButtonItem.title = @"取消编辑";
        self.saveButton.hidden = NO;
        self.deleteButton.hidden = NO;
        self.nameTF.enabled = YES;
        self.phoneTF.enabled = YES;
    }else{
        self.navigationItem.rightBarButtonItem.title = @"编辑";
        self.saveButton.hidden = YES;
        self.deleteButton.hidden = YES;
        self.nameTF.enabled = NO;
        self.phoneTF.enabled = NO;
    }
}
- (IBAction)saveContacts:(id)sender {
    [self writeDataToPlist:NO];
}
- (IBAction)deleteContacts:(id)sender {
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"确定删除%@？",self.nameTF.text] preferredStyle:UIAlertControllerStyleActionSheet];

     UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
         [self writeDataToPlist:YES];
     }];
    
     UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
     [alertController addAction:confirmAction];
     [alertController addAction:cancelAction];
     [self presentViewController:alertController animated:YES completion:nil];
}

- (void)writeDataToPlist:(BOOL)isDelete {
     //获取沙盒Document路径
    NSString *currentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [currentPath stringByAppendingPathComponent:@"addressBook.plist"];
    
    NSMutableArray *contactsArray = [self getdataFromPlist];
    [contactsArray removeObjectAtIndex:self.index];
    
    if(!isDelete){
        NSMutableDictionary *contactsDic = [[NSMutableDictionary alloc]init];
        [contactsDic setValue:self.nameTF.text forKey:@"name"];
        [contactsDic setValue:self.phoneTF.text forKey:@"phone"];
        [contactsArray addObject:contactsDic];
    }
    
    //若之前没有该文件，会自动创建该文件
    if ([contactsArray writeToFile:filePath atomically:YES]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"操作失败" preferredStyle:UIAlertControllerStyleAlert];
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
