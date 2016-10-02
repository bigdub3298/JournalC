//
//  EntryDetailViewController.h
//  JournalC
//
//  Created by Wesley Austin on 10/1/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Entry; 

@interface EntryDetailViewController : UIViewController

@property (nonatomic, strong) Entry *entry;

- (void)updateWithEntry:(Entry *)entry; 

@end
