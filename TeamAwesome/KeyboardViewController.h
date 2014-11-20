//
//  KeyboardViewController.h
//  TeamAwesome
//
//  Created by Justin Baumgartner  on 11/20/14.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TADocument.h"

@interface KeyboardViewController : UIViewController

@property (strong, nonatomic) TADocument *document;
@property (nonatomic) int counter;

@end
