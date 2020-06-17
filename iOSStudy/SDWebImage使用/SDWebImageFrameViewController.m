//
//  SDWebImageFrameViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/17.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "SDWebImageFrameViewController.h"
#import <SDWebImage/SDWebImage.h>

@interface SDWebImageFrameViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation SDWebImageFrameViewController
static NSString *imagUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1592215196058&di=ec5406b9fbfe5bc598d9bc819c5e2c45&imgtype=0&src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn%2Fw660h990%2F20180105%2Fb7df-fyqincu5814712.jpg";
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"SDWebImage基本使用";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self loadImage];
//    [self loadImage2];
//    [self loadImage3];
    [self loadGifImage];
}

/**
 下载图片，且需要获取下载进度
 内存缓存&磁盘缓存
 */
-(void)loadImage{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imagUrl] placeholderImage:[UIImage imageNamed:@"phone_bg"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        switch (cacheType) {
            case SDImageCacheTypeNone:
                NSLog(@"直接下载");
                break;
            case SDImageCacheTypeDisk:
                NSLog(@"磁盘缓存");
                break;
            case SDImageCacheTypeMemory:
                NSLog(@"内存缓存");
                break;
            default:
                break;
        }
    }];
}
/**
 只需要简单获得一张图片，不需要其他设置
 内存缓存&磁盘缓存
 此种方式下，第一次从网络加载图片时，返回值NSData有值，但是如果一旦图片在本地缓存下来，下次从缓存加载时，NSData就是nil
 */
-(void)loadImage2{
    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:imagUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        NSLog(@"进度：%f",1.0 * receivedSize / expectedSize);
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        self.imageView.image = image;
    }];
}
/**
 不需要任务的缓存处理
 没有做缓存处理，每次都会重新下载
 */
-(void)loadImage3{
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:imagUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        //在主线程
        NSLog(@"%@",[NSThread currentThread]);
        self.imageView.image = image;
    }];
}
/**
 下载一张gif图片，并展示gif动画图片
 */
-(void)loadGifImage{
    NSString *gifUrl = @"http://b-ssl.duitang.com/uploads/item/201702/18/20170218161710_wiVcE.gif";
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:gifUrl] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        NSLog(@"进度：%f",1.0 * receivedSize / expectedSize);
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        //展示gif动画图片（内部实际上是一个帧动画）
        UIImage *gifImage = [UIImage sd_imageWithGIFData:data];
        self.imageView.image = gifImage;
    }];
}
@end
