//
//  DVNetworkManager.m
//  DaVinci
//
//  Created by 叔 陈 on 16/6/5.
//  Copyright © 2016年 hackbuster. All rights reserved.
//

#import "DVNetworkManager.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "NSString+URL.h"

@implementation DVNetworkManager

+ (id)sharedManager {
    static DVNetworkManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
    }
    return self;
}

- (void)getMusicInfo:(NSString *)name
               success:(successWithObjectBlock)onSuccess
               failure:(failErrorBlock)onFailure
{
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSMutableURLRequest *req = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"http://music.163.com/api/search/pc?s=%@&offset=0&limit=10&type=1",[name URLEncodedString]] parameters:nil error:nil];
    
    [req setValue:@"appver=1.5.0.75771;" forHTTPHeaderField:@"Cookie"];
    [req setValue:@"http://music.163.com/" forHTTPHeaderField:@"Referer"];
    
    //NSString *responseString = [NSString string];
    [[manager dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error)
      {
          if (!error)
          {
//              NSString *fuck = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
//
//              NSLog(@"fuck %@",fuck);
              NSError * err;
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                  options:NSJSONReadingMutableContainers
                                                                    error:&err];
              NSLog(@"get music list %@",dic);
              
              onSuccess(dic);
          } else
          {
              onFailure(error);
          }
      }] resume];
    
}

@end
