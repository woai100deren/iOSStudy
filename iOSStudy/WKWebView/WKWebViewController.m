//
//  WKWebViewController.m
//  iOSStudy
//
//  Created by dodoca on 2020/6/4.
//  Copyright © 2020 dodoca. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import "MyWKWebView.h"

@interface WKWebViewController ()<WKNavigationDelegate>
@property (weak, nonatomic) IBOutlet MyWKWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *goFrontBtn;
@property (weak, nonatomic) IBOutlet UIButton *goBackBtn;

@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.navigationDelegate = self;
    [self test1];
}

- (IBAction)goFront:(id)sender {
    [self.webView goForward];
}
- (IBAction)goBack:(id)sender {
    [self.webView goBack];
}
- (IBAction)refresh:(id)sender {
    [self.webView reload];
}


/**
 加载网络地址
 */
-(void)test1{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[[NSURL alloc] initWithString:@"http://www.baidu.com/"]]];
}
//加载工程中本地html页面
-(void)test2{
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test.html" withExtension:nil];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
}


#pragma mark - WKNavigationDelegate
// 页面开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"页面开始加载时调用");
}
// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
 
}
// 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"页面加载完成之后调用");
    self.goBackBtn.enabled = self.webView.canGoBack;
    self.goFrontBtn.enabled = self.webView.canGoForward;
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
 
}
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{
 
}
// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
 
//    NSLog(@"在收到响应后，决定是否跳转：%@",navigationResponse.response.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationResponsePolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationResponsePolicyCancel);
}
// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
 
//     NSLog(@"在发送请求之前，决定是否跳转：%@",navigationAction.request.URL.absoluteString);
    //允许跳转
    decisionHandler(WKNavigationActionPolicyAllow);
    //不允许跳转
    //decisionHandler(WKNavigationActionPolicyCancel);
}

@end
