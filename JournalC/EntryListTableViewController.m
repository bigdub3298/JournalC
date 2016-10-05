//
//  EntryListTableViewController.m
//  JournalC
//
//  Created by Wesley Austin on 10/1/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

#import "EntryListTableViewController.h"
#import "EntryDetailViewController.h"
#import "EntryController.h"
#import "Entry.h"

@interface EntryListTableViewController ()

@end

@implementation EntryListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

// MARK: - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
\
    return [[[EntryController sharedController] entries] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"entryCell" forIndexPath:indexPath];
    
    Entry *entry = [[EntryController sharedController] entries][indexPath.row];
    
    cell.textLabel.text = entry.title;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    cell.detailTextLabel.text = [dateFormatter stringFromDate:entry.timestamp];
    
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Entry *selectedEntry = [[EntryController sharedController] entries][indexPath.row];
        
        [[EntryController sharedController] deleteEntry:selectedEntry];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

// MARK: - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toEntryDetail"]) {
        EntryDetailViewController *entryDetailViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Entry *selectedEntry = [[EntryController sharedController] entries][indexPath.row];
        entryDetailViewController.entry = selectedEntry; 
    } else if ([segue.identifier isEqualToString:@"toAddEntry"]) {
        
    }
}

- (IBAction)unwindToEntryList:(UIStoryboardSegue *)sender
{
    EntryDetailViewController *sourceViewController = [sender sourceViewController];
    Entry *entry = sourceViewController.entry;
    
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    if (indexPath != nil && entry != nil) {
        NSMutableArray *entries = [[EntryController sharedController] entries];
        entries[indexPath.row] = entry;
        
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    } else {
        NSArray *entries = [[EntryController sharedController] entries];
        
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow: entries.count inSection:0];
        [[EntryController sharedController] addEntry:entry];
        [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation: UITableViewRowAnimationBottom];
    }
    
}


@end
