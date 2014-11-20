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

@end
