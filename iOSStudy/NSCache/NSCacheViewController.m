//
//  NSCacheViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/17.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "NSCacheViewController.h"

@interface NSCacheViewController ()
@property(strong,nonatomic)NSCache *cache;
@end

@implementation NSCacheViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"NSCache使用";
}

- (NSCache *)cache{
    if(!_cache){
        _cache = [[NSCache alloc] init];
        //总成本数，如果发现存储的数据超过了总成本，那么会自动回收之前的对象
        _cache.countLimit = 5;
    }
    return _cache;
}

- (IBAction)addCache:(id)sender {
    for(int i=0;i<10;i++){
//        [self.cache setObject:[NSString stringWithFormat:@"存储的数据：%d",i] forKey:@(i)];
        //成本：cost
        [self.cache setObject:[NSString stringWithFormat:@"存储的数据：%d",i] forKey:@(i) cost:1];
    }
}

- (IBAction)checkCache:(id)sender {
    for(int i=0;i<10;i++){
        NSLog(@"取出的缓存：%@",[self.cache objectForKey:@(i)]);
    }
}

- (IBAction)clearCache:(id)sender {
    [self.cache removeAllObjects];
}
@end
