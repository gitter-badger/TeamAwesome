//
//  PlaybackViewController.m
//  TeamAwesome
//
//  Created by Justin Baumgartner  on 11/20/14.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import "PlaybackViewController.h"
#import "KeyboardViewController.h"
#import "MusicNote.h"

@interface PlaybackViewController () <KeyboardViewControllerDelegate>

@property (assign, nonatomic) NSInteger notePosition;
@property (strong, nonatomic) NSMutableArray *notes;
@property (strong, nonatomic) KeyboardViewController *keyboardController;

@property (weak, nonatomic) IBOutlet UILabel *notePositionLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentNoteLabel;
@property (weak, nonatomic) IBOutlet UIView *keyboardView;

@end

@implementation PlaybackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.keyboardController = [[KeyboardViewController alloc] init];
    self.keyboardController.delegate = self;
    [self addChildViewController:self.keyboardController];
    [self.keyboardView addSubview:self.keyboardController.view];
    [self.keyboardController didMoveToParentViewController:self];
    
    // Initialize notes with all rests
    self.notes = [[NSMutableArray alloc] initWithCapacity:16];
    for (int i=0; i<self.notes.count; i++) {
        [self.notes addObject:[[MusicNote alloc] initWithNoteType:NoteTypeRest]];
    }
}

- (IBAction)notePositionStepperTapped:(UIStepper *)stepper {
    self.notePosition = stepper.value;
    [self updateCurrentNoteAndPosition];
}

- (IBAction)deleteNoteTapped:(id)sender {
    self.notes[self.notePosition] = [[MusicNote alloc] initWithNoteType:NoteTypeRest];
    [self updateCurrentNoteAndPosition];
}

- (IBAction)playNoteTapped:(id)sender {
    
}

- (IBAction)saveSongTapped:(id)sender {
    
}

- (void)didSelectNote:(MusicNote *)note {
    self.notes[self.notePosition] = note;
}

- (void)updateCurrentNoteAndPosition {
    self.notePositionLabel.text = [NSString stringWithFormat:@"Note Position: %ld/16", (long)self.notePosition];
    
    MusicNote *currentNote = self.notes[self.notePosition];
    self.currentNoteLabel.text = [NSString stringWithFormat:@"Current Note: %@", currentNote.noteName];
}

@end
