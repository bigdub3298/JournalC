//
//  JournalController.h
//  JournalC
//
//  Created by Wesley Austin on 10/5/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Journal;
@interface JournalController : NSObject


+ (JournalController *)sharedController;

// Create
- (void)addJournal:(Journal *)journal;

// Read
@property (nonatomic, strong) NSMutableArray *journals;

//Update
    // dot syntax

// Delete
- (void)deleteJournal:(Journal *)journal; 
@end
