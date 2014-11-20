//
//  TADocument.h
//  TeamAwesome
//
//  Created by Florian Harr on 20/11/14.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *kBNRDocumentContentsDidUpdateNotification;

@interface TADocument : UIDocument

@property (copy, nonatomic) NSArray *contents;

@end
