//
//  Instrument.m
//  TeamAwesome
//
//  Created by Tom Wilk on 11/20/14.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import "Instrument.h"

@implementation Instrument

{
    AKFMOscillator *osc;
    AKLinearADSRAudioEnvelope *env;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // INPUTS AND CONTROLS =================================================
        _frequencyValue = [[AKInstrumentProperty alloc] initWithValue:440
                                                              minimum:220
                                                              maximum:880];
        
        _carrierMultValue   = [[AKInstrumentProperty alloc] initWithValue:0.5
                                                                  minimum:0
                                                                  maximum:1];
        
        _modIndexValue   = [[AKInstrumentProperty alloc] initWithValue:0.5
                                                               minimum:0
                                                               maximum:1];
        
        _amplitudeValue   = [[AKInstrumentProperty alloc] initWithValue:0.5
                                                                minimum:0
                                                                maximum:0.5];
        
        [self addProperty:_frequencyValue];
        [self addProperty:_carrierMultValue];
        [self addProperty:_modIndexValue];
        [self addProperty:_amplitudeValue];
        _attackValue = 0.1;
        _decayValue = 0.5;
        _sustainValue  = 0.1;
        _releaseValue = 0.5;
        
    
        
        AKSineTable *sineTable = [[AKSineTable alloc] init];
        [self addFTable:sineTable];
        
        AKLinearADSRAudioEnvelope *envelope = [[AKLinearADSRAudioEnvelope alloc]
                                               initWithAttackDuration:akp(_attackValue)
                                               decayDuration:akp(_decayValue)
                                               sustainLevel:akp(_sustainValue)
                                               releaseDuration:akp(_releaseValue)];
        
       
        [self connect:envelope];
        
        AKFMOscillator *fmOscillatorlator;
        fmOscillatorlator = [[AKFMOscillator alloc] initWithFTable:sineTable
                                                     baseFrequency:_frequencyValue
                                                 carrierMultiplier:_carrierMultValue
                                              modulatingMultiplier:akp(0.5)
                                                   modulationIndex:_modIndexValue
                                                         amplitude:envelope];
        [self connect:fmOscillatorlator];
        
        
        env = envelope;
        osc = fmOscillatorlator;
        
        // AUDIO OUTPUT ========================================================
        
        AKAudioOutput *audioOutput = [[AKAudioOutput alloc] initWithAudioSource:fmOscillatorlator];
        [self connect:audioOutput];
        
        
    }
    return self;
}

-(void)loadInstrument:(NSDictionary *)instrumentDef
{
   
    
}

-(void)saveInstrument:(NSDictionary *)instrumentDef
{
    
}
-(void)playNote:(AKInstrumentProperty*)freq
{
    AKInstrumentProperty *p = (AKInstrumentProperty *)_frequencyValue;
    p = freq;
    [self play];
}
-(void)silence
{
    [self stop];
}



@end
