//
//  DVOrderMatchManager.m
//  DaVinci
//
//  Created by Fincher Justin on 16/6/5.
//  Copyright © 2016年 hackbuster. All rights reserved.
//

#import "DVOrderMatchManager.h"

@implementation DVOrderMatchManager
@synthesize matchArray;

- (NSMutableArray *)getActionResultFromiFlyResult:(NSString *)text
{
    NSMutableDictionary *matchDict = [matchArray objectAtIndex:_currentIndex];
    for (NSString *matchWord in [matchDict allKeys])
    {
        if ([text containsString:matchWord])
        {
            return [matchDict valueForKey:matchWord];
        }
    }

    return nil;
}

#pragma mark Singleton Methods
+ (id)sharedManager {
    static DVOrderMatchManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
        _currentIndex = 0;
        matchArray = [NSMutableArray array];
        
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"DVOrderMatchJSON" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        
        NSError *error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        matchArray = [json objectForKey:@"orderSteps"];
    }
    return self;
}

@end
