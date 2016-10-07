//
//  JournalListTableViewController.m
//  JournalC
//
//  Created by Wesley Austin on 10/6/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

#import "JournalListTableViewController.h"
#import "JournalController.h"
#import "Journal.h"
#import "EntryListTableViewController.h"

@interface JournalListTableViewController ()

@end

@implementation JournalListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// MARK: - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [[[JournalController sharedController] journals] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"journalCell" forIndexPath:indexPath];
    
    Journal *journal = [[JournalController sharedController] journals][indexPath.row];
    
    cell.textLabel.text = journal.title;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterShortStyle;
    cell.detailTextLabel.text = [dateFormatter stringFromDate: journal.timestamp];
    
    return cell;
}

// MARK: - Table view delegate

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        JournalController *controller = [JournalController sharedController];
        
        Journal *selectedJournal = [controller journals][indexPath.row];
        [controller deleteJournal:selectedJournal]; 
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


// MARK: - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toEntryListView"]) {
        EntryListTableViewController *entryListTableViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        Journal *selectedJournal = [[JournalController sharedController] journals][indexPath.row];
        
        entryListTableViewController.journal = selectedJournal;
    }
}

// MARK: - Actions

- (IBAction)addButtonTapped:(UIBarButtonItem *)sender {
    UIAlertController *newJournalAlert = [UIAlertController alertControllerWithTitle:@"Add Journal" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [newJournalAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
      
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = [newJournalAlert textFields][0];
        
        NSString *journalTitle = textField.text;
        
        Journal *newJournal = [[Journal alloc] initWithTitle:journalTitle entries:@[] timestamp:[NSDate date]];
        
        [[JournalController sharedController] addJournal:newJournal];
        [self.tableView reloadData];
    }];
    
    [newJournalAlert addAction:cancelAction];
    [newJournalAlert addAction:saveAction];
    
    [self presentViewController:newJournalAlert animated:YES completion:nil]; 
}

@end
