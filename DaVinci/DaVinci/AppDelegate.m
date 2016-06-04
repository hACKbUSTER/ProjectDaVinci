//
//  AppDelegate.m
//  DaVinci
//
//  Created by 叔 陈 on 16/6/4.
//  Copyright © 2016年 hackbuster. All rights reserved.
//

#import "AppDelegate.h"
#import "ZipArchive.h"
#import "iflyMSC/IFlyMSC.h"

@interface AppDelegate ()

@property (strong, nonatomic) NSUserDefaults *userDefault;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"t"]) {
    
        // Override point for customization after application launch.
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"resource" ofType:@"zip"];
        
        ZipArchive* zip = [[ZipArchive alloc] init];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentpath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
        
        NSString* unzipto = [documentpath stringByAppendingString:@"/"] ;
        
        if( [zip UnzipOpenFile:filePath] )
        {
            BOOL ret = [zip UnzipFileTo:unzipto overWrite:YES];
            if( NO==ret )
            {
            }
            [zip UnzipCloseFile];
        }
        
        [[NSUserDefaults standardUserDefaults] setValue:@(1) forKey:@"t"];
    }
    
    [IFlySetting setLogFile:LVL_ALL];
    
    //打开输出在console的log开关
    [IFlySetting showLogcat:YES];
    
    //设置sdk的工作路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachePath = [paths objectAtIndex:0];
    [IFlySetting setLogFilePath:cachePath];
    
    //创建语音配置,appid必须要传入，仅执行一次则可
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=5752c20c"];
    
    //所有服务启动前，需要确保执行createUtility
    [IFlySpeechUtility createUtility:initString];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
