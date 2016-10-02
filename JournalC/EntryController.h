//
//  EntryController.h
//  JournalC
//
//  Created by Wesley Austin on 10/1/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Entry;

@interface EntryController : NSObject

+ (EntryController *)sharedController;



// Create

- (void)createEntry:(NSString *)title body:(NSString *)body;

// Read
@property (nonatomic) NSArray *posts;

// Update
    // Dot syntax

// Delete
- (void)deleteEntry:(Entry *)entry;



@end
