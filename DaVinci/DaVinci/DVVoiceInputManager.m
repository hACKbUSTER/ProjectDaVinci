//
//  DVVoiceInputManager.m
//  DaVinci
//
//  Created by 叔 陈 on 16/6/4.
//  Copyright © 2016年 hackbuster. All rights reserved.
//

#import "DVVoiceInputManager.h"

@interface DVVoiceInputManager()
{
    BOOL isRecording;
}

@end

@implementation DVVoiceInputManager 

+ (id)sharedManager {
    static DVVoiceInputManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
        isRecording = NO;
        [[IFlySpeechUnderstander sharedInstance] setDelegate:self];
        [[IFlySpeechUnderstander sharedInstance] setParameter: @"iat" forKey: @"domain"];
        [[IFlySpeechUnderstander sharedInstance] setParameter:@"2.0" forKey:@"nlp_version"];
        [[IFlySpeechUnderstander sharedInstance] setParameter:@"json" forKey:@"rst"];
        [[IFlySpeechUnderstander sharedInstance] setParameter: @"0" forKey: @"asr_ppt"];
        
        _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
        _iFlySpeechSynthesizer.delegate = self;
        //语速,取值范围 0~100
        
        [_iFlySpeechSynthesizer setParameter:@"60" forKey:[IFlySpeechConstant SPEED]];
        [_iFlySpeechSynthesizer setParameter:@"50" forKey: [IFlySpeechConstant VOLUME]];
        [_iFlySpeechSynthesizer setParameter:@"60" forKey: [IFlySpeechConstant PITCH]];
        [_iFlySpeechSynthesizer setParameter:@"cloud" forKey: [IFlySpeechConstant ENGINE_TYPE]];
        [_iFlySpeechSynthesizer setParameter:@"vixy" forKey: [IFlySpeechConstant VOICE_NAME]];
        [_iFlySpeechSynthesizer setParameter:@"10000" forKey: [IFlySpeechConstant VAD_BOS]];
        [_iFlySpeechSynthesizer setParameter:@"2000" forKey: [IFlySpeechConstant VAD_EOS]];
        [_iFlySpeechSynthesizer setParameter:@"read_sentence" forKey: [IFlySpeechConstant ISE_CATEGORY]];
    }
    return self;
}

- (BOOL)isRecording
{
    return isRecording;
}

- (void)beginRecording:(id)sender
{
    isRecording = YES;
    
    [[IFlySpeechUnderstander sharedInstance] startListening];
    
    NSLog(@"beginRecording");
}

- (void)endRecording:(id)sender
{
    isRecording = NO;

    [[IFlySpeechUnderstander sharedInstance] stopListening];
    
    NSLog(@"endRecording");
}

- (void)cancelRecording:(id)sender
{
    isRecording = NO;
    
    [[IFlySpeechUnderstander sharedInstance] cancel];
    
    NSLog(@"cancelRecording");
}

- (void)startSpeakText:(NSString *)text
{
    [_iFlySpeechSynthesizer startSpeaking:text];
}

- (void) onCompleted:(IFlySpeechError *) error
{
    if (error.errorCode == 0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dv_speaker_completed" object:nil];
    }
}

//合成开始
- (void) onSpeakBegin
{
}

//合成缓冲进度
- (void) onBufferProgress:(int) progress message:(NSString *)msg
{
}

//合成播放进度
- (void) onSpeakProgress:(int) progress
{
}

- (void) onError:(IFlySpeechError *) errorCode
{
    NSLog(@"onError : %@,%d",errorCode.errorDesc,errorCode.errorCode);
}

- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{
    if ([results count] > 0) {
        
        NSString *jsonStr = ((NSDictionary *)results[0]).allKeys[0];
        
        NSData* jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *iFlyDic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSUTF8StringEncoding error:nil];
        NSLog(@"onResults : %@||||",iFlyDic);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dv_understander_result" object:nil userInfo:@{@"result":iFlyDic}];
    } else {
        NSLog(@"onResults[others] : %@||||",results);
    }
}

// pass volume change to parent
- (void) onVolumeChanged: (int)volume
{
    if (self.onVolumnChange) {
        self.onVolumnChange(volume);
    }
}
@end
