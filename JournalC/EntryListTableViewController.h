//
//  EntryListTableViewController.h
//  JournalC
//
//  Created by Wesley Austin on 10/1/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Journal; 

@interface EntryListTableViewController : UITableViewController

@property (nonatomic, strong) Journal *journal;

- (void)unwindToEntryList:(UIStoryboardSegue *) sender; 
@end
