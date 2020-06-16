//
//  ThreadDownloadImagesViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/16.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "ThreadDownloadImagesViewController.h"
#import "MJExtension.h"
#import "ThreadDownloadImageModel.h"
#import "ThreadDownloadImagesTableViewCell.h"

@interface ThreadDownloadImagesViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSArray *imageModelArray;
//内存缓存图片
@property(nonatomic,strong)NSMutableDictionary *imageCacheDic;
//队列
@property(strong,nonatomic)NSOperationQueue *queue;
//操作缓存
@property(nonatomic,strong)NSMutableDictionary *downOperationDic;
@end

@implementation ThreadDownloadImagesViewController
- (NSOperationQueue *)queue{
    if(_queue == nil){
        _queue = [[NSOperationQueue alloc] init];
        //最大并发数一般3~5
        _queue.maxConcurrentOperationCount = 5;
    }
    return _queue;
}

- (NSMutableDictionary *)imageCacheDic{
    if(_imageCacheDic == nil){
        _imageCacheDic = [NSMutableDictionary dictionary];
    }
    return _imageCacheDic;
}

- (NSMutableDictionary *)downOperationDic{
    if(_downOperationDic == nil){
        _downOperationDic = [NSMutableDictionary dictionary];
    }
    return _downOperationDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"多图下载";
    
    [self loadData];
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(void)loadData{
    self.imageModelArray = [ThreadDownloadImageModel mj_objectArrayWithFilename:@"images.plist" ];
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    static NSString *ID = @"tag";
    
    ThreadDownloadImagesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(cell == nil){
        //二、通过xib的方式，需要加载xib来处理
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([ThreadDownloadImagesTableViewCell class]) owner:self options:nil] lastObject];
    }
    ThreadDownloadImageModel *model = self.imageModelArray[indexPath.row];
    cell.imageModel = model;
    
    UIImage *image = [self.imageCacheDic objectForKey:model.icon];
    if(image){
        cell.iconImage = image;
    }else{
        NSURL *url = [NSURL URLWithString:model.icon];
        //获取沙盒目录下的Caches缓存文件夹路径
        NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        //通过url获得图片名称
        NSString *fileName = [model.icon lastPathComponent];
        //拼接全路径
        NSString *fullPath = [caches stringByAppendingPathComponent:fileName];
        //检查磁盘缓存
        __block NSData *imageData = [NSData dataWithContentsOfFile:fullPath];
        if(imageData){
            UIImage *cacheImage = [UIImage imageWithData:imageData];
            cell.iconImage = cacheImage;
            [self.imageCacheDic setValue:cacheImage forKey:model.icon];
        }else{
            NSBlockOperation *operation = [self.downOperationDic objectForKey:model.icon];
            if(operation){
                
            }else{
                cell.iconImage = nil;
                operation = [NSBlockOperation blockOperationWithBlock:^{
                    imageData = [NSData dataWithContentsOfURL:url];
                    UIImage *downloadImage = [UIImage imageWithData:imageData];
                    
                    //容错处理
                    if(downloadImage == nil){
                        [self.downOperationDic removeObjectForKey:model.icon];
                        return;
                    }
                    
                    [self.imageCacheDic setValue:downloadImage forKey:model.icon];
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        //防止图片还没下载完，用户刷新很快，导致的问题
                        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                    }];
                    
                    //写数据到沙盒
                    [imageData writeToFile:fullPath atomically:YES];
                    
                    //下载完成之后，移除缓存的操作
                    [self.downOperationDic removeObjectForKey:model.icon];
                }];
                [self.downOperationDic setValue:operation forKey:model.icon];
                [self.queue addOperation:operation];
            }
        }
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.imageModelArray.count;
}

@end
