//
//  DVViewController.m
//  DaVinci
//
//  Created by 叔 陈 on 16/6/4.
//  Copyright © 2016年 hackbuster. All rights reserved.
//

#import "DVViewController.h"
#import "UIView+ViewFrameGeometry.h"

@interface DVViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation DVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    self.webView.delegate = self;
    [self.view addSubview:self.webView];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    NSString *filePath = [documentpath stringByAppendingString:@"/index.html"] ;
    
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - webView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //    NSLog(@"navigation type %d",navigationType);
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

    NSString *theTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    if (theTitle.length > 10) {
        theTitle = [[theTitle substringToIndex:9] stringByAppendingString:@"…"];
    }
    self.title = theTitle;
    //    [self.progressView setProgress:1 animated:NO];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"fuck? :%@",error.debugDescription);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
