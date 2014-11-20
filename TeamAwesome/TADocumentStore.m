//
//  TADocumentStore.m
//  TeamAwesome
//
//  Created by Florian Harr on 20/11/14.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import "TADocumentStore.h"
#import "TADocument.h"

NSString *kDocumentExtension = @"awesomeDoc";
NSString *kDocumentListChangedAdditionNotification = @"kDocumentListChangedAdditionNotification";
NSString *kDocumentListChangedRemovalNotification = @"kDocumentListChangedRemovalNotification";
NSString *kDocumentListChangedExternallyNotification = @"kDocumentListChangedExternallyNotification";
NSString *kDocumentListRemovedIndexPathKey = @"kDocumentListRemovedIndexPathKey";
NSString *kDocumentListAddedIndexPathKey = @"kDocumentListAddedIndexPathKey";

@interface TADocumentStore ()
{
    NSMutableArray *_documentURLs;
}

@end

@implementation TADocumentStore

+(TADocumentStore *)sharedDocumentStorage
{
    static dispatch_once_t pred;
    static TADocumentStore *docStore = nil;
    
    dispatch_once(&pred, ^{ docStore = [[self alloc] init]; });
    return docStore;
}


-(id)init
{
    if (self = [super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(documentStateChanged:)
                                                     name:UIDocumentStateChangedNotification
                                                   object:nil];
    }
    return self;
}

-(void)documentStateChanged:(NSNotification *)notification
{
    UIDocument *document = [notification object];
    UIDocumentState documentState = document.documentState;
    
    if (documentState & UIDocumentStateInConflict)
    {
        // This application uses a basic newest version wins conflict resolution strategy
        NSURL *documentURL = document.fileURL;
        NSArray *conflictVersions =
        [NSFileVersion unresolvedConflictVersionsOfItemAtURL:documentURL];
        for (NSFileVersion *fileVersion in conflictVersions)
        {
            fileVersion.resolved = YES;
        }
        [NSFileVersion removeOtherVersionsOfItemAtURL:documentURL error:nil];
    }
}

#pragma mark - Documents

-(NSURL *)localDocumentsURL
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

-(NSArray *)documentURLs
{
    if (!_documentURLs)
    {
        _documentURLs = [[NSMutableArray alloc] init];
        
        NSMutableArray *dirContents = [[[NSFileManager defaultManager]
                                        contentsOfDirectoryAtURL:[self localDocumentsURL]
                                        includingPropertiesForKeys:nil options:0
                                        error:NULL] mutableCopy];
        NSPredicate *filenameFilter = [NSPredicate predicateWithFormat:
                                       @"%K ENDSWITH[c] %@", @"path", kDocumentExtension];
        [dirContents filterUsingPredicate:filenameFilter];
        [_documentURLs addObjectsFromArray:dirContents];
        [_documentURLs sortUsingComparator: ^NSComparisonResult (NSURL * url1, NSURL * url2)
         {
             return [[url1 lastPathComponent] localizedStandardCompare:[url2 lastPathComponent]];
         }];
    }
    return [NSArray arrayWithArray:_documentURLs];
}


-(void)addDocumentURL:(NSURL *)url
{
    [_documentURLs addObject:url];
    [_documentURLs sortUsingComparator: ^NSComparisonResult (NSURL * url1, NSURL * url2)
     {
         return [[url1 lastPathComponent] localizedStandardCompare:[url2 lastPathComponent]];
     }];
    
    NSUInteger row = [self.documentURLs indexOfObject:url];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    NSDictionary *uInfo = [NSDictionary dictionaryWithObject:indexPath
                                                      forKey:kDocumentListAddedIndexPathKey];
    [[NSNotificationCenter defaultCenter] postNotificationName:
     kDocumentListChangedAdditionNotification
                                                        object:self
                                                      userInfo:uInfo];
}

-(void)removeDocumentURL:(NSURL *)url
{
    NSUInteger row = [self.documentURLs indexOfObject:url];
    
    [_documentURLs removeObject:url];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSFileCoordinator *coordinator = [[NSFileCoordinator alloc] initWithFilePresenter:nil];
        [coordinator coordinateWritingItemAtURL:url
                                        options:NSFileCoordinatorWritingForDeleting
                                          error:NULL
                                     byAccessor: ^(NSURL * newURL)
         {
             [[NSFileManager defaultManager] removeItemAtURL:newURL error:NULL];
         }];
    });
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    NSDictionary *uInfo = [NSDictionary dictionaryWithObject:indexPath
                                                      forKey:kDocumentListRemovedIndexPathKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:
     kDocumentListChangedRemovalNotification
                                                        object:self
                                                      userInfo:uInfo];
}


-(NSURL *)addDocumentWithName:(NSString *)name
{
    NSString *extension = kDocumentExtension;
    NSURL *baseURL = [self localDocumentsURL];
    NSURL *url = [[baseURL URLByAppendingPathComponent:name]
                  URLByAppendingPathExtension:extension];
    if ([self.documentURLs containsObject:url])
    {
        NSUInteger n = 2;
        do
        {
            url = [[baseURL URLByAppendingPathComponent:[name
                                                         stringByAppendingFormat:@" %ld", n]]
                   URLByAppendingPathExtension:extension];
            n++;
        } while ([self.documentURLs containsObject:url]);
    }
    TADocument *document = [[TADocument alloc] initWithFileURL:url];
    [document saveToURL:url forSaveOperation:UIDocumentSaveForCreating
      completionHandler: ^(BOOL success)
     {
         if (!success)
         {
             [self removeDocumentURL:url];
         }
     }];
    [self addDocumentURL:url];
    return url;
}

@end
