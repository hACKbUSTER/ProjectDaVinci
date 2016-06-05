//
//  NSString+URL.m
//  DaVinci
//
//  Created by 叔 陈 on 16/6/5.
//  Copyright © 2016年 hackbuster. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString(URL)

- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                                                    (CFStringRef)self,
                                                                                                    (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                                                                    NULL,
                                                                                                    kCFStringEncodingUTF8));
    return encodedString;
}

@end
