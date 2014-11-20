//
//  PlaybackViewController.m
//  TeamAwesome
//
//  Created by Justin Baumgartner  on 11/20/14.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import "PlaybackViewController.h"
#import "KeyboardViewController.h"

@interface PlaybackViewController ()

@property (assign, nonatomic) NSInteger notePosition;

@property (weak, nonatomic) IBOutlet UILabel *notePositionLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentNoteLabel;
@property (weak, nonatomic) IBOutlet UIView *keyboardView;

@end

@implementation PlaybackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    KeyboardViewController *keyboardVC = [[KeyboardViewController alloc] init];
    [self addChildViewController:keyboardVC];
    [self.keyboardView addSubview:keyboardVC.view];
    [keyboardVC didMoveToParentViewController:self];
}

- (IBAction)notePositionStepperTapped:(UIStepper *)stepper {
    self.notePosition = stepper.value;
    self.notePositionLabel.text = [NSString stringWithFormat:@"Note Position: %ld/16", (long)self.notePosition];
}

- (IBAction)deleteNoteTapped:(id)sender {
    
}

- (IBAction)playNoteTapped:(id)sender {
    
}

- (IBAction)saveSongTapped:(id)sender {
    
}

@end
