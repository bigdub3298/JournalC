//
//  EntryController.m
//  JournalC
//
//  Created by Wesley Austin on 10/1/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

#import "EntryController.h"
#import "Entry.h"

@interface EntryController ()

@property (nonatomic) NSMutableArray *internalEntries;
@end

@implementation EntryController

+ (EntryController *)sharedController
{
    static EntryController *sharedController = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        sharedController = [[EntryController alloc]init];
    });
    return sharedController;
}

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _internalEntries = [NSMutableArray array];
    }
    
    return self;
}
- (void)addEntry:(Entry *)entry
{
    [self.internalEntries addObject:entry];
}

-(void)deleteEntry:(Entry *)entry
{
    [self.internalEntries removeObject:entry];
}

- (NSArray *)entries
{
    return self.internalEntries; 
}


@end
