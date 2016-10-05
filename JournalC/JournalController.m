//
//  JournalController.m
//  JournalC
//
//  Created by Wesley Austin on 10/5/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

#import "JournalController.h"

@implementation JournalController

+ (JournalController *)sharedController
{
    static JournalController *sharedController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedController = [JournalController new];
    });
    
    return sharedController; 
}

- (void)addJournal:(Journal *)journal
{
    [self.journals addObject:journal];
}

-(void)deleteJournal:(Journal *)journal
{
    [self.journals removeObject:journal];
}


@end
