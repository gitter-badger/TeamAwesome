//
//  MusicNote.h
//  TeamAwesome
//
//  Created by Justin Baumgartner  on 11/20/14.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NoteType) {
    NoteTypeA,
    NoteTypeASharp,
    NoteTypeB,
    NoteTypeC,
    NoteTypeCSharp,
    NoteTypeD,
    NoteTypeDSharp,
    NoteTypeE,
    NoteTypeF,
    NoteTypeFSharp,
    NoteTypeG,
    NoteTypeGSharp
};

@interface MusicNote : NSObject

@property (assign, nonatomic) NoteType noteType;
@property (strong, nonatomic) NSString *noteName;
@property (assign, nonatomic) float frequency;

@end