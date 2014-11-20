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
            return 0.f;
        case NoteTypeASharp:
            return 0.f;
        case NoteTypeB:
            return 0.f;
        case NoteTypeC:
            return 0.f;
        case NoteTypeCSharp:
            return 0.f;
        case NoteTypeD:
            return 0.f;
        case NoteTypeDSharp:
            return 0.f;
        case NoteTypeE:
            return 0.f;
        case NoteTypeF:
            return 0.f;
        case NoteTypeFSharp:
            return 0.f;
        case NoteTypeG:
            return 0.f;
        case NoteTypeGSharp:
            return 0.f;
        case NoteTypeRest:
            return 0.f;
    }
    return 0.f;
}

@end
