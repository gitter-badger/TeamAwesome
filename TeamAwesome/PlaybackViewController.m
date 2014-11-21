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
#import "AKTools.h"
#import "Instrument.h"
#import "TADocumentStore.h"

@interface PlaybackViewController () <KeyboardViewControllerDelegate>

@property (assign, nonatomic) NSInteger notePosition;
@property (strong, nonatomic) NSMutableArray *notes;
@property (strong, nonatomic) KeyboardViewController *keyboardController;
@property (strong, nonatomic) Instrument *instrument;

@property (weak, nonatomic) IBOutlet UILabel *notePositionLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentNoteLabel;
@property (weak, nonatomic) IBOutlet UIView *keyboardView;
@property (strong, nonatomic) KeyboardViewController *keyboardVC;

@end

@implementation PlaybackViewController

@synthesize document;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.keyboardController = [[KeyboardViewController alloc] init];
    self.keyboardController.delegate = self;
    [self addChildViewController:self.keyboardController];
    [self.keyboardView addSubview:self.keyboardController.view];
    [self.keyboardController didMoveToParentViewController:self];
    
    AKOrchestra *orch = [[AKOrchestra alloc] init];
    self.instrument  = [[Instrument alloc] init];
    [orch addInstrument:self.instrument];
    [[AKManager sharedAKManager] runOrchestra:orch];
    
    // Initialize notes with all rests
    self.notes = [[NSMutableArray alloc] initWithCapacity:16];
    for (int i=0; i<16; i++) {
        [self.notes addObject:[[MusicNote alloc] initWithNoteType:NoteTypeRest]];
    }
    
//    TADocumentStore *store = [TADocumentStore sharedDocumentStorage];
//    if ([store.documentURLs firstObject]) {
//        TADocument *doc = [[TADocument alloc] initWithFileURL:[store.documentURLs firstObject]];
//        [self setDocument:doc];
//    }
}



-(void)viewWillDisappear:(BOOL)animated
{
    // belt and suspenders
    [self syncTextViewWithDocument];
    [self.document saveToURL:[self.document fileURL]
            forSaveOperation:UIDocumentSaveForOverwriting completionHandler:NULL];
    
    [super viewWillDisappear:animated];
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
    for (MusicNote *note in self.notes) {
        [self.instrument playNote:note.frequency];
        sleep(1);
    }
}

- (IBAction)saveSongTapped:(id)sender {
    [self syncTextViewWithDocument];
    [self.document saveToURL:[self.document fileURL]
            forSaveOperation:UIDocumentSaveForOverwriting completionHandler:NULL];
}

- (void)didSelectNote:(MusicNote *)note {
    self.notes[self.notePosition] = note;
    [self.instrument playNote:note.frequency];
    [self updateCurrentNoteAndPosition];
}

- (void)updateCurrentNoteAndPosition {
    self.notePositionLabel.text = [NSString stringWithFormat:@"Note Position: %ld/15", (long)self.notePosition];
    
    MusicNote *currentNote = self.notes[self.notePosition];
    self.currentNoteLabel.text = [NSString stringWithFormat:@"Current Note: %@", currentNote.noteName];
}

#pragma mark - Document handles

-(void)documentContentsDidUpdate;
{
    
}

-(void)documentUpdated:(NSNotification *)note
{
    [self documentContentsDidUpdate];
}

-(void)documentStateChanged:(NSNotification *)notification
{
    UIDocumentState documentState = document.documentState;
}

-(void)openDocument
{
    if (document)
    {
        NSURL *docURL = [document fileURL];
        self.title = [[docURL lastPathComponent] stringByDeletingPathExtension];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(documentStateChanged:)
                                                     name:UIDocumentStateChangedNotification
                                                   object:document];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(documentUpdated:)
                                                     name:kBNRDocumentContentsDidUpdateNotification
                                                   object:document];
        TADocument *docSnapshot = [self document];
        [document openWithCompletionHandler: ^(BOOL success)
         {
             if ([document isEqual:docSnapshot])
             {
                 [self documentContentsDidUpdate];
             }
         }];
    }
}


-(void)closeDocument;
{
    if (document)
    {
        [document setUndoManager:nil];
        [document closeWithCompletionHandler: ^(BOOL success) {
            NSLog (@"Closed");
        }];
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:UIDocumentStateChangedNotification
                                                      object:document];
        [[NSNotificationCenter defaultCenter] removeObserver:self
                                                        name:kBNRDocumentContentsDidUpdateNotification
                                                      object:document];
    }
}

#pragma mark - text sync with UI

-(void)syncTextViewWithDocument
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (MusicNote *note in self.notes) {
        [array addObject:note.noteName];
    }
    document.contents = array;
}

-(void)textViewDidChange:(UITextView *)textView
{
    [self syncTextViewWithDocument];
}


#pragma mark - Accessors and setters

- (void)setDocument:(TADocument *)myDocument
{
    if (document != myDocument)
    {
        [self closeDocument];
        document = myDocument;
        [self openDocument];
    }
}

@end
