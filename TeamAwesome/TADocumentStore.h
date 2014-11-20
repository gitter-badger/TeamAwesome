//
//  TADocumentStore.h
//  TeamAwesome
//
//  Created by Florian Harr on 20/11/14.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import <Foundation/Foundation.h>


extern NSString *kDocumentExtension;
extern NSString *kDocumentListChangedRemovalNotification;
extern NSString *kDocumentListRemovedIndexPathKey;
extern NSString *kDocumentListChangedAdditionNotification;
extern NSString *kDocumentListAddedIndexPathKey;
extern NSString *kDocumentListChangedExternallyNotification;

@interface TADocumentStore : NSObject

+(TADocumentStore *)sharedDocumentStorage;

@property (nonatomic, readonly) NSArray *documentURLs;

-(void)addDocumentURL:(NSURL *)url;
-(void)removeDocumentURL:(NSURL *)url;
-(NSURL *)addDocumentWithName:(NSString *)name;

@end