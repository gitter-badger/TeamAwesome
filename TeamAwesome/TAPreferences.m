//
//  TAPreferences.m
//  TeamAwesome
//
//  Created by Florian Harr on 20/11/14.
//  Copyright (c) 2014 Team Awesome. All rights reserved.
//

#import "TAPreferences.h"

@interface TAPreferences ()

@property (nonatomic, strong) NSUserDefaults *userDefaults;

@end

@implementation TAPreferences

- (id)init {
    return [self initWithUserDefaults:[NSUserDefaults standardUserDefaults]];
}

- (instancetype)initWithUserDefaults:(NSUserDefaults *)userDefaults {
    self = [super init];
    if (self) {
        self.userDefaults = userDefaults;
    }
    return self;
}

@end
