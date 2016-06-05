//
//  DVNetworkManager.h
//  DaVinci
//
//  Created by 叔 陈 on 16/6/5.
//  Copyright © 2016年 hackbuster. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^successBlock)(void);
typedef void (^failErrorBlock)(NSError *error);

typedef void (^successWithObjectBlock)(id object);

@interface DVNetworkManager : NSObject

+ (id)sharedManager;

- (void)getMusicInfo:(NSString *)name
             success:(successWithObjectBlock)onSuccess
             failure:(failErrorBlock)onFailure;
@end
