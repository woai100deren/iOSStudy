//
//  LocalValuePlistViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/4.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "LocalValuePlistViewController.h"
#import "MBProgressHUD.h"

@interface LocalValuePlistViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation LocalValuePlistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Plist方式";
    
    [self saveNSData];
    [self saveNSArray];
    [self saveNSString];
    [self saveNSDictionary];
    
    self.label.text = [NSString stringWithFormat:@"数据已持久化到本地目录：%@",NSHomeDirectory()];
    
    //下面这种方式，可以给label设置点击事件
    //开启交互事件响应开关
    self.label.userInteractionEnabled=YES;
    //手势响应
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
    //添加手势响应
    [self.label addGestureRecognizer:labelTapGestureRecognizer];
}

/**
 label的点击事件
 */
-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    //复制文字
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    pab.string = [self.label.text substringFromIndex:12];
}

-(NSString*)getDocumentsPath:(NSString*)fileName{
    //沙盒获取路径
    //第一个参数：搜索的目录，NSDocumentDirectory搜索的是沙盒中的Documents目录。
    //                   NSCachesDirectory搜索的是沙盒中的Library/Caches目录。
    //第二个参数：搜索的范围，当前用户下
    //第三个参数：是否展开路径(在ios当中识别~)
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //第0个就是Documents文件夹
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径（拼接一个文件名）
    return [path stringByAppendingPathComponent:fileName];//没有会自动创建
}

-(void)saveNSArray{
    NSArray *dataArray = @[@"李四",@"王五"];
    //atomically:在writeToFile方法中atomically，参数值为BOOL类型，用于通知是否应该首先将文件内容保存在临时文件夹中，当文件成功保存后，再将该临时文件和原始文件交换。这是一种安全机制，如果在保存过程中出现意外，不会破坏原始文件，但这种安全机制会付出一定的代价，在保存过程中，由于原始文件仍然保存在磁盘中，所以需要使用双倍的空间。除非保存的文件非常大，将会占用用户硬盘的空间，否则应该自动保存文件。
    [dataArray writeToFile:[self getDocumentsPath:@"lvPlist1.plist"] atomically:YES];
    
    //读取数据
    NSArray *dict = [NSArray arrayWithContentsOfFile:[self getDocumentsPath:@"lvPlist1.plist"]];
    NSLog(@"NSArray读取数据：%@",dict);
}

-(void)saveNSDictionary{
    NSDictionary *dic = @{@"name":@"李四",@"age":@10};
    //存储数据
    [dic writeToFile:[self getDocumentsPath:@"lvPlist2.plist"] atomically:YES];
    //读取数据
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[self getDocumentsPath:@"lvPlist2.plist"]];
    NSLog(@"NSDictionary读取数据：%@", dict);
}

-(void)saveNSData{
    //png的图片转成NSData
    NSData *dic = UIImagePNGRepresentation([UIImage imageNamed:@"car"]);
    //存储数据
    [dic writeToFile:[self getDocumentsPath:@"lvPlist3.plist"] atomically:YES];
    //读取数据
    NSData *dict = [NSData dataWithContentsOfFile:[self getDocumentsPath:@"lvPlist3.plist"]];
    NSLog(@"图片数据：%@",[UIImage imageWithData: dict]);
}

-(void)saveNSString{
    NSString *string = @"111222333";
    //存储数据
    [string writeToFile:[self getDocumentsPath:@"lvPlist4.plist"] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    //读取数据
    NSString *dict = [NSString stringWithContentsOfFile:[self getDocumentsPath:@"lvPlist4.plist"] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"NSString读取数据：%@",dict);
}
@end
