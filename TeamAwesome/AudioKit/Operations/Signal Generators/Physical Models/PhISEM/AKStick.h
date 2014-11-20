//
//  AKStick.h
//  AudioKit
//
//  Auto-generated from scripts by Aurelius Prochazka on 11/4/12.
//  Copyright (c) 2012 Hear For Yourself. All rights reserved.
//

#import "AKAudio.h"
#import "AKParameter+Operation.h"

/** Semi-physical model of a stick sound.
 
 This one of the PhISEM percussion opcodes. PhISEM (Physically Informed Stochastic Event Modeling) is an algorithmic approach for simulating collisions of multiple independent sound producing objects.
 */

@interface AKStick : AKAudio

/// Instantiates the stick
/// @param maximumDuration Period of time over which all sound is stopped.
/// @param amplitude Amplitude of output. As these instruments are stochastic this is only a approximation.
- (instancetype)initWithMaximumDuration:(AKConstant *)maximumDuration
                              amplitude:(AKConstant *)amplitude;


/// Set an optional count
/// @param count The number of beads, teeth, bells, timbrels, etc. The default value is 30.
- (void)setOptionalCount:(AKConstant *)count;

/// Set an optional damping factor
/// @param dampingFactor The damping factor as part of this equation damping = 0.998 + (dampingFactor * 0.002). The default damping is 0.998 which means that the default value of dampingFactor is 0. The maximum damping is 1.0 (no damping). This means the maximum value for dampingFactor is 1.0.]
- (void)setOptionalDampingFactor:(AKConstant *)dampingFactor;

/// Set an optional energy return
/// @param energyReturn Amount of energy to add back into the system. The value should be in range 0 to 1.
- (void)setOptionalEnergyReturn:(AKConstant *)energyReturn;


@end