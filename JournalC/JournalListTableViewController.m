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
@property (nonatomic, strong) NSString *previousTitle;
@property (nonatomic, strong) UIAlertAction *addSaveAction;
@property (nonatomic, strong) UIAlertAction *editSaveAction;
@end

@implementation JournalListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    self.tableView.allowsSelectionDuringEditing = YES;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableView.editing) {
        
        Journal *selectedJournal = [[JournalController sharedController] journals][indexPath.row];
        self.previousTitle = selectedJournal.title;
        
        UIAlertController *editJournalAlert = [UIAlertController alertControllerWithTitle:@"Edit Journal Title" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        [editJournalAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.text = selectedJournal.title;
            textField.delegate = self;
        }];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITextField *textField = [editJournalAlert textFields][0];
            
            if (textField.text != selectedJournal.title) {
            
                selectedJournal.title = textField.text;
                
                [[JournalController sharedController] journals][indexPath.row] = selectedJournal;
                [self.tableView reloadData];
            }
        }];
        
        [editJournalAlert addAction:cancelAction];
        [editJournalAlert addAction:saveAction];
        
        self.editSaveAction = editJournalAlert.actions[1];
        
        [self presentViewController:editJournalAlert animated:YES completion:nil];
    }
}


// MARK: - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"toEntryListView"]) {
        EntryListTableViewController *entryListTableViewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        Journal *selectedJournal = [[JournalController sharedController] journals][indexPath.row];
        
        entryListTableViewController.journal = selectedJournal;
    }
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    if ([identifier isEqualToString:@"toEntryListView"] && self.tableView.editing) {
        return NO;
    } else {
        return YES;
    }
}

// MARK: - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.editSaveAction.enabled = NO;
    self.addSaveAction.enabled = NO;
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.text != self.previousTitle) {
        self.editSaveAction.enabled = YES;
    }
    self.addSaveAction.enabled = YES; 
}

// MARK: - Actions

- (IBAction)addButtonTapped:(UIBarButtonItem *)sender {
    UIAlertController *newJournalAlert = [UIAlertController alertControllerWithTitle:@"Add Journal" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [newJournalAlert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.delegate = self;
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
    
    self.addSaveAction = newJournalAlert.actions[1];
    
    [self presentViewController:newJournalAlert animated:YES completion:nil]; 
}

@end
