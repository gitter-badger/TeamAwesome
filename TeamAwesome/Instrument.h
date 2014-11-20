//
//  Instrument.h
//  TeamAwesome
//
//  Created by Tom Wilk on 11/20/14.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AKFoundation.h"



@interface Instrument : AKInstrument


@property (nonatomic, strong) AKInstrumentProperty *frequencyValue;
@property (nonatomic, strong) AKInstrumentProperty *carrierMultValue;
@property (nonatomic, strong) AKInstrumentProperty *modIndexValue;
@property (nonatomic, strong) AKInstrumentProperty *amplitudeValue;
@property (nonatomic, assign) float attackValue;
@property (nonatomic, assign) float decayValue;
@property (nonatomic, assign) float sustainValue;
@property (nonatomic, assign) float releaseValue;


-(void)loadInstrument:(NSDictionary *)instrumentDef;
-(void)saveInstrument:(NSDictionary *)instrumentDef;
-(void)playNote:(float)freq;
-(void)silence;

@end
