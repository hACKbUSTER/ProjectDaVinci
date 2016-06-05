//
//  GuideViewController.m
//  DaVinci
//
//  Created by 叔 陈 on 16/6/5.
//  Copyright © 2016年 hackbuster. All rights reserved.
//

#import "GuideViewController.h"
#import "ABCIntroView.h"
#import "DVViewController.h"

@interface GuideViewController () <ABCIntroViewDelegate>

@property ABCIntroView *introView;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.introView = [[ABCIntroView alloc] initWithFrame:self.view.frame];
    
    self.introView.delegate = self;
    self.introView.backgroundColor = [UIColor colorWithWhite:0.149 alpha:1.000];
    [self.view addSubview:self.introView];

    
    // Do any additional setup after loading the view.
}

-(void)onDoneButtonPressed{
    
    //    Uncomment so that the IntroView does not show after the user clicks "DONE"
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    [defaults setObject:@"YES"forKey:@"intro_screen_viewed"];
    //    [defaults synchronize];
    DVViewController *vc = [[DVViewController alloc] init];
    [self presentViewController:vc animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
