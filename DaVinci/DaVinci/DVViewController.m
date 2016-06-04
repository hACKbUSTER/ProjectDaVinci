//
//  DVViewController.m
//  DaVinci
//
//  Created by 叔 陈 on 16/6/4.
//  Copyright © 2016年 hackbuster. All rights reserved.
//

#import "DVViewController.h"
#import "UIView+ViewFrameGeometry.h"
#import "DVVoiceInputManager.h"
#import "DVLoadingView.h"
#import <JavaScriptCore/JavaScriptCore.h>  

@interface DVViewController () <WKUIDelegate,WKNavigationDelegate,UIWebViewDelegate>
{
    BOOL isShowingCustomView;
}

@property (strong, nonatomic) DVVoiceInputManager *inputManager;
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIView *customView;
@property (strong, nonatomic) UILabel *customViewLabel;
@property (strong, nonatomic) DVLoadingView *loadingView;

@end

@implementation DVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.customView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, -50.0f, ScreenWidth, 50.0f)];
    _customView.backgroundColor = self.view.tintColor;
    
    _inputManager = [[DVVoiceInputManager alloc] init];
    
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(customViewTapped:)];
//    [_customView addGestureRecognizer:tap];
    
    [self.view addSubview:_customView];
    
    isShowingCustomView = NO;
    
    self.webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    self.webView.delegate = self;
//    self.webView.navigationDelegate = self;
    self.webView.scrollView.scrollEnabled = NO;
    
    [self.view addSubview:self.webView];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    
    NSString *filePath = [documentpath stringByAppendingString:@"/index.html"] ;
    
    NSURL *url = [NSURL fileURLWithPath:filePath];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
//    [self.webView loadFileURL:url allowingReadAccessToURL:[NSURL fileURLWithPath:documentpath]];
    
    self.customViewLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 25.0f, ScreenWidth, 20.0f)];
    _customViewLabel.font = [UIFont systemFontOfSize:13.0f];
    _customViewLabel.textColor = [UIColor whiteColor];
    _customViewLabel.textAlignment = NSTextAlignmentCenter;
    _customViewLabel.numberOfLines = 0;
    _customViewLabel.userInteractionEnabled = NO;
    [_customView addSubview:_customViewLabel];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(understandText:) name:@"dv_understander_result" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(speakerCompleted:) name:@"dv_speaker_completed" object:nil];
    //dv_understander_result_completed
    // Do any additional setup after loading the view.
}

- (void)speakerCompleted:(NSNotification *)notif
{
    [self performSelector:@selector(showLoadingView) withObject:nil afterDelay:0.0f];
}

- (void)understandText:(NSNotification *)notif
{
    [self hideLoadingView];
    NSDictionary *dict = notif.userInfo;
    // [dict objectForKey:@"ws"]
    NSString *input = [dict objectForKey:@"result"];
    self.customViewLabel.text = input;
    [_inputManager startSpeakText:input];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma WKWebView Navi Delegate
//- (void)webView:(WKWebView *)webView
//didFinishNavigation:(WKNavigation *)navigation
//{
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    [_webView evaluateJavaScript:@"toggleTabbar(true)"
//               completionHandler:^(id object, NSError *error) {
//                   if (error)
//                   {
//                       NSLog(@"ERROR: %@",[error debugDescription]);
//                   }}];
//}
//- (void)webView:(WKWebView *)webView
//didStartProvisionalNavigation:(WKNavigation *)navigation
//{
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//}
//- (void)webView:(WKWebView *)webView
//didFailNavigation:(WKNavigation *)navigation
//      withError:(NSError *)error
//{
//    if (error)
//    {
//        NSLog(@"ERROR: %@",[error debugDescription]);
//    }
//}

#pragma mark - webView delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    //    NSLog(@"navigation type %d",navigationType);
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self showCustomViewAnimated:YES withTitle:@"说句话啊"];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    //    [self.progressView setProgress:1 animated:NO];
    //[self.webView stringByEvaluatingJavaScriptFromString:@"toggleTabbar(true)"];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"didFailLoadWithError? :%@",error.debugDescription);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)reloadWebView
{
    [self.webView reload];
}

- (void)showCustomViewAnimated:(BOOL)animated withTitle:(NSString *)title
{
    if (isShowingCustomView) {
        return;
    }
    
    _customViewLabel.text = title;
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    isShowingCustomView = YES;
    
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.customView.top = 0.0f;
        self.webView.top = 50.0f;
        self.webView.height = self.view.height - 50.0f;
    } completion:^(BOOL finished) {
        [self blinkAnimationForTitleLabel];
        [_inputManager startSpeakText:title];
		
		// [self showLoadingView];
    }];
}

- (void)hideCustomViewAnimated:(BOOL)animated
{
    if (!isShowingCustomView) {
        return;
    }
    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
    
    [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.customView.top = -50.0f;
        self.webView.height = self.view.height;
        self.webView.top = 0.0f;
    } completion:^(BOOL finished) {
        isShowingCustomView = NO;
        [self hideLoadingView];
        [_customViewLabel.layer removeAllAnimations];
    }];
}

- (void)showLoadingView
{
    [_inputManager beginRecording:nil];
	_customViewLabel.hidden = TRUE;
	_loadingView = [[DVLoadingView alloc] initWithMaxHeight:15 minHeight:8 width:4 minAlpha:0.2 spacing:5 color:[UIColor whiteColor]];
	[_loadingView setCenter:CGPointMake(_customView.center.x, _customView.center.y + 8)];
	[_customView addSubview:_loadingView];
}

- (void)hideLoadingView
{
	[_loadingView removeFromSuperview];
	_customViewLabel.hidden = FALSE;
}

- (void)customViewTapped:(UITapGestureRecognizer *)gesture
{
    [self hideCustomViewAnimated:YES];
}

- (void)blinkAnimationForTitleLabel
{
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CGFloat once_duration = 1.0f;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.duration=once_duration;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount=1;
    animation.autoreverses = NO;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    animation.toValue = [NSNumber numberWithFloat:0.0];
    animation.beginTime = 0.0f;
    
    group.animations = [NSArray arrayWithObjects:animation,nil];
    group.duration= once_duration;
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.repeatCount = HUGE_VALF;
    group.autoreverses = YES;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [_customViewLabel.layer addAnimation:group forKey:@"fuck"];
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
