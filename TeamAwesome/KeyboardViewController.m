//
//  KeyboardViewController.m
//  TeamAwesome
//
//  Created by Justin Baumgartner  on 11/20/14.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()

@property (nonatomic) NSMutableArray *tempSounds;

// copies the text from the view into the document
-(void)syncTextViewWithDocument;
-(void)openDocument;
-(void)closeDocument;

@end

@implementation KeyboardViewController
@synthesize document, counter;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    for (int i = 0; i < 32; i++) {
        [self.tempSounds addObject:@""];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    // belt and suspenders
    [self syncTextViewWithDocument];
    [self.document saveToURL:[self.document fileURL]
            forSaveOperation:UIDocumentSaveForOverwriting completionHandler:NULL];
    
    [super viewWillDisappear:animated];
}

- (IBAction)cKeyTapped {
    [self.tempSounds replaceObjectAtIndex:self.counter withObject:@"c"];
}

- (IBAction)cSharpKeyTapped {
    [self.tempSounds replaceObjectAtIndex:self.counter withObject:@"c#"];
}

- (IBAction)dKeyTapped {
    [self.tempSounds replaceObjectAtIndex:self.counter withObject:@"d"];
}

- (IBAction)dSharpKeyTapped {
    [self.tempSounds replaceObjectAtIndex:self.counter withObject:@"c#"];
}

- (IBAction)eKeyTapped {
    [self.tempSounds replaceObjectAtIndex:self.counter withObject:@"e"];
}

- (IBAction)fKeyTapped {
    [self.tempSounds replaceObjectAtIndex:self.counter withObject:@"f"];
}

- (IBAction)fSharpKeyTapped {
    [self.tempSounds replaceObjectAtIndex:self.counter withObject:@"f#"];
}

- (IBAction)gKeyTapped {
    [self.tempSounds replaceObjectAtIndex:self.counter withObject:@"g"];
}

- (IBAction)gSharpKeyTapped {
    [self.tempSounds replaceObjectAtIndex:self.counter withObject:@"g#"];
}

- (IBAction)aKeyTapped {
    [self.tempSounds replaceObjectAtIndex:self.counter withObject:@"a"];
}

- (IBAction)aSharpKeyTapped {
    [self.tempSounds replaceObjectAtIndex:self.counter withObject:@"a#"];
}

- (IBAction)bKeyTapped {
    [self.tempSounds replaceObjectAtIndex:self.counter withObject:@"b"];
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
    document.contents = self.tempSounds;
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
