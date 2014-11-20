//
//  TADocument.m
//  TeamAwesome
//
//  Created by Florian Harr on 20/11/14.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import "TADocument.h"

NSString *kBNRDocumentContentsDidUpdateNotification = @"kBNRDocumentContentsDidUpdateNotification";

@interface TADocument ()

@property (nonatomic, assign) BOOL iveBeenClosedOnceAlready;

@end


@implementation TADocument
@synthesize iveBeenClosedOnceAlready, contents;

-(id)initWithFileURL:(NSURL *)url
{
    self = [super initWithFileURL:url];
    if (self)
    {
        [self setContents:[[NSMutableArray alloc] initWithCapacity:32]];
    }
    return self;
}

// Disk -> Data Model
-(BOOL)loadFromContents:(id)myContents
                 ofType:(NSString *)typeName
                  error:(NSError **)outError
{
    NSArray *myTempContents = [[NSArray alloc] init];
    
    if ([(NSArray *)myContents count] > 0)
    {
        myTempContents = [[NSArray alloc] initWithArray:contents copyItems:YES];
    }
    [self setContents:myTempContents];
    [[NSNotificationCenter defaultCenter] postNotificationName:kBNRDocumentContentsDidUpdateNotification object:self];
    
    return YES;
}

// Data Model -> Disk
-(id)contentsForType:(NSString *)typeName error:(NSError **)outError
{
    return [NSKeyedArchiver archivedDataWithRootObject:contents];
}


-(void)openWithCompletionHandler:(void ( ^)(BOOL))completionHandler
{
    NSAssert(![self iveBeenClosedOnceAlready], @"Document objects are really one-offs");
    [super openWithCompletionHandler:completionHandler];
}

-(void)closeWithCompletionHandler:(void ( ^)(BOOL))completionHandler
{
    NSAssert(![self iveBeenClosedOnceAlready], @"Document objects are really one-offs");
    [self setIveBeenClosedOnceAlready:YES];
    [super closeWithCompletionHandler:completionHandler];
}

# pragma mark - Accessors
-(void)setContents:(NSArray *)myContents
{
    if (![contents isEqualToArray:myContents])
    {
        contents = [myContents copy];
    }
}

@end
