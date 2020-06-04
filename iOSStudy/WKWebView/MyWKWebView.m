//
//  MyWKWebView.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/4.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "MyWKWebView.h"

@interface MyWKWebView()

@end

@implementation MyWKWebView
- (instancetype)initWithCoder:(NSCoder *)coder{
    CGRect frame = [[UIScreen mainScreen] bounds];
    WKWebViewConfiguration *myConfiguration = [[WKWebViewConfiguration alloc] init];
    self = [super initWithFrame:frame configuration:myConfiguration];
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    return self;
}
@end
