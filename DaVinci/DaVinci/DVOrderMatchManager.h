//
//  DVOrderMatchManager.h
//  DaVinci
//
//  Created by Fincher Justin on 16/6/5.
//  Copyright © 2016年 hackbuster. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVOrderMatchManager : NSObject

@property (nonatomic,strong) NSMutableArray *matchArray;
@property (nonatomic) int currentIndex;

- (NSMutableArray *)getActionResultFromiFlyResult:(NSString *)text;

+ (id)sharedManager;

@end
