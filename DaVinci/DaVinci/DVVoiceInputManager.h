//
//  DVVoiceInputManager.h
//  DaVinci
//
//  Created by 叔 陈 on 16/6/4.
//  Copyright © 2016年 hackbuster. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <iflyMSC/iflyMSC.h>

@interface DVVoiceInputManager : NSObject <IFlySpeechRecognizerDelegate,IFlySpeechSynthesizerDelegate>

@property (nonatomic, copy) void (^onVolumnChange)(int volume);
@property (strong,nonatomic) IFlySpeechSynthesizer * iFlySpeechSynthesizer;

+ (id) sharedManager;
- (void)beginRecording:(id)sender;
- (void)endRecording:(id)sender;
- (void)cancelRecording:(id)sender;
- (BOOL)isRecording;
- (void)startSpeakText:(NSString *)text;

@end
