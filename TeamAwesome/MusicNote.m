//
//  MusicNote.m
//  TeamAwesome
//
//  Created by Justin Baumgartner  on 11/20/14.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import "MusicNote.h"

@implementation MusicNote

- (instancetype)initWithNoteType:(NoteType)noteType {
    self = [super init];
    if (self) {
        self.noteType = noteType;
        self.noteName = [self nameForNoteType:noteType];
        self.frequency = [self frequencyForNoteType:noteType];
    }
    return self;
}

- (NSString *)nameForNoteType:(NoteType)noteType {
    switch (noteType) {
        case NoteTypeA:
            return @"A";
        case NoteTypeASharp:
            return @"A#";
        case NoteTypeB:
            return @"B";
        case NoteTypeC:
            return @"C";
        case NoteTypeCSharp:
            return @"C#";
        case NoteTypeD:
            return @"D";
        case NoteTypeDSharp:
            return @"D#";
        case NoteTypeE:
            return @"E";
        case NoteTypeF:
            return @"F";
        case NoteTypeFSharp:
            return @"F#";
        case NoteTypeG:
            return @"G";
        case NoteTypeGSharp:
            return @"G#";
        case NoteTypeRest:
            return @"Rest";
    }
    return nil;
}

- (float)frequencyForNoteType:(NoteType)noteType {
    switch (noteType) {
        case NoteTypeA:
            return 440.00;
        case NoteTypeASharp:
            return 466.16;
        case NoteTypeB:
            return 493.88;
        case NoteTypeC:
            return 261.83;
        case NoteTypeCSharp:
            return 277.18;
        case NoteTypeD:
            return 293.66;
        case NoteTypeDSharp:
            return 311.13;
        case NoteTypeE:
            return 329.63;
        case NoteTypeF:
            return 349.23;
        case NoteTypeFSharp:
            return 369.99;
        case NoteTypeG:
            return 392.00;
        case NoteTypeGSharp:
            return 415.30;
        case NoteTypeRest:
            return 0.f;
    }
    return 0.f;
}

@end
