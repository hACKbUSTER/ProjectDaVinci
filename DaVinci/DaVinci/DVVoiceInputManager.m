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
}

@property (weak, nonatomic) IFlySpeechSynthesizer * iFlySpeechSynthesizer;
@property (weak, nonatomic) IFlySpeechRecognizer * iFlySpeechUnderstander;

@end

@implementation DVVoiceInputManager 

- (id)init {
    if (self = [super init])
    {
        [self initSpeechUnderstander];
        [self initSpeaker];
    }
    return self;
}

- (void)initSpeechUnderstander
{
    _iFlySpeechUnderstander = [IFlySpeechRecognizer sharedInstance];
    [_iFlySpeechUnderstander setDelegate:self];
    
    [_iFlySpeechUnderstander setParameter: @"iat" forKey: @"domain"];
     [_iFlySpeechUnderstander setParameter: @"plain" forKey: @"result_type"];
    [_iFlySpeechUnderstander setParameter: [IFlySpeechConstant ASR_PTT_NODOT] forKey: [IFlySpeechConstant ASR_PTT]];
    [_iFlySpeechUnderstander setParameter:@"10000" forKey: [IFlySpeechConstant VAD_BOS]];
    [_iFlySpeechUnderstander setParameter:@"5000" forKey: [IFlySpeechConstant VAD_EOS]];
}

- (void)initSpeaker
{
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    _iFlySpeechSynthesizer.delegate = self;
    //语速,取值范围 0~100
    
    [_iFlySpeechSynthesizer setParameter:@"60" forKey:[IFlySpeechConstant SPEED]];
    [_iFlySpeechSynthesizer setParameter:@"50" forKey: [IFlySpeechConstant VOLUME]];
    [_iFlySpeechSynthesizer setParameter:@"60" forKey: [IFlySpeechConstant PITCH]];
    [_iFlySpeechSynthesizer setParameter:@"cloud" forKey: [IFlySpeechConstant ENGINE_TYPE]];
    [_iFlySpeechSynthesizer setParameter:@"vixy" forKey: [IFlySpeechConstant VOICE_NAME]];
    [_iFlySpeechSynthesizer setParameter:@"read_sentence" forKey: [IFlySpeechConstant ISE_CATEGORY]];
}

- (void)beginRecording:(id)sender
{
    if(_iFlySpeechUnderstander == nil)
    {
        [self initSpeechUnderstander];
    }
    
    [_iFlySpeechUnderstander cancel];

    [_iFlySpeechUnderstander startListening];
    
    NSLog(@"beginRecording");
}

- (void)endRecording:(id)sender
{
    if (!_iFlySpeechUnderstander.isListening) {
        return;
    }
    
    [_iFlySpeechUnderstander stopListening];
    
    NSLog(@"endRecording");
}

- (void)cancelRecording:(id)sender
{
    if (!_iFlySpeechUnderstander.isListening) {
        return;
    }
    
    [_iFlySpeechUnderstander cancel];
    
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
    if (progress >= 1) {
//        [self beginRecording:self];
    }
}

- (void) onError:(IFlySpeechError *) errorCode
{
    NSLog(@"onError : %@,%d",errorCode.errorDesc,errorCode.errorCode);
    if (errorCode.errorCode == 0) {
        [self beginRecording:nil];
//        [_iFlySpeechUnderstander destroy];
    } else if (errorCode.errorCode == 20002 || errorCode.errorCode == 10114) {
        [self initSpeechUnderstander];
        [self initSpeaker];
        [self beginRecording:nil];
    }
}

- (void) onResults:(NSArray *) results isLast:(BOOL)isLast
{

    if (!isLast && [results count] > 0) {
        NSString *jsonStr = ((NSDictionary *)results[0]).allKeys[0];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dv_understander_result" object:nil userInfo:@{@"result":jsonStr}];
    } else {
        NSLog(@"onResults[others] : %@||||",results);
    }
}

// pass volume change to parent
- (void) onVolumeChanged: (int)volume
{
}
@end
