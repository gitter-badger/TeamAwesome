//
//  KeyboardViewController.h
//  TeamAwesome
//
//  Created by Justin Baumgartner  on 11/20/14.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TADocument.h"
#import "MusicNote.h"

@protocol KeyboardViewControllerDelegate <NSObject>

@required
- (void)didSelectNote:(MusicNote *)note;

@end


@interface KeyboardViewController : UIViewController

@property (strong, nonatomic) TADocument *document;
@property (weak, nonatomic) id<KeyboardViewControllerDelegate> delegate;

@end
