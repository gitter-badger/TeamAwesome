//
//  KeyboardViewController.m
//  TeamAwesome
//
//  Created by Justin Baumgartner  on 11/20/14.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import "KeyboardViewController.h"
#import "AKFoundation.h"
#import "Instrument.h"
#import "AKTools.h"

@implementation KeyboardViewController

- (IBAction)cKeyTapped {
    [self.delegate didSelectNote:[[MusicNote alloc] initWithNoteType:NoteTypeC]];
}

- (IBAction)cSharpKeyTapped {
    [self.delegate didSelectNote:[[MusicNote alloc] initWithNoteType:NoteTypeCSharp]];
}

- (IBAction)dKeyTapped {
    [self.delegate didSelectNote:[[MusicNote alloc] initWithNoteType:NoteTypeD]];
}

- (IBAction)dSharpKeyTapped {
    [self.delegate didSelectNote:[[MusicNote alloc] initWithNoteType:NoteTypeDSharp]];
}

- (IBAction)eKeyTapped {
    [self.delegate didSelectNote:[[MusicNote alloc] initWithNoteType:NoteTypeE]];
}

- (IBAction)fKeyTapped {
    [self.delegate didSelectNote:[[MusicNote alloc] initWithNoteType:NoteTypeF]];
}

- (IBAction)fSharpKeyTapped {
    [self.delegate didSelectNote:[[MusicNote alloc] initWithNoteType:NoteTypeFSharp]];
}

- (IBAction)gKeyTapped {
    [self.delegate didSelectNote:[[MusicNote alloc] initWithNoteType:NoteTypeG]];
}

- (IBAction)gSharpKeyTapped {
    [self.delegate didSelectNote:[[MusicNote alloc] initWithNoteType:NoteTypeGSharp]];
}

- (IBAction)aKeyTapped {
    [self.delegate didSelectNote:[[MusicNote alloc] initWithNoteType:NoteTypeA]];
}

- (IBAction)aSharpKeyTapped {
    [self.delegate didSelectNote:[[MusicNote alloc] initWithNoteType:NoteTypeASharp]];
}

- (IBAction)bKeyTapped {
    [self.delegate didSelectNote:[[MusicNote alloc] initWithNoteType:NoteTypeB]];
}

@end
