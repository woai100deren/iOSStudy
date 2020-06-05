//
//  LocalValueCoreDataViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/4.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "LocalValueCoreDataViewController.h"
#import "Student+CoreDataProperties.h"
#import "LVCoreDataManager.h"

@interface LocalValueCoreDataViewController ()

@end

@implementation LocalValueCoreDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"CoreData方式";
    [self saveData];
}
-(void)saveData{
    Student *student = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:kLVCoreDataManager.managedObjectContext];
    student.name = @"2222aievan";
    student.age = INT32_C(20);

    [kLVCoreDataManager save];
    
    NSFetchRequest *fetchRequest =  [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    //查询数据count：NSCountResultType
    //查询数据对象：NSManagedObjectResultType，默认就是这个
    fetchRequest.resultType = NSCountResultType;
    
    //查询age>5的数据
//    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"age > 5"];
    //按age排序
//    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
//    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    NSArray *result = [kLVCoreDataManager.managedObjectContext executeFetchRequest:fetchRequest error:nil];
    //这里数组的元素为 NSNumber ，一般数组只有一个元素
    if ([result count] > 0){
        Student *student2 = [result objectAtIndex:0];
        NSLog(@"姓名：%@",student2.name);
    }
    
    
    //上面是同步查询，下面是异步查询
//    NSFetchRequest *fetchRequest =  [NSFetchRequest fetchRequestWithEntityName:@"Doge"];
//    NSAsynchronousFetchRequest *asyncFetchRequest = [[NSAsynchronousFetchRequest alloc] initWithFetchRequest:fetchRequest completionBlock:^(NSAsynchronousFetchResult * _Nonnull results) {
//        NSLog(@"%@",results);
//    }];
//    [_context executeRequest:asyncFetchRequest error:nil];
}
@end
