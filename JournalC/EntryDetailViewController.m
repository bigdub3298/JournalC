//
//  EntryDetailViewController.m
//  JournalC
//
//  Created by Wesley Austin on 10/1/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

#import "EntryDetailViewController.h"
#import "Entry.h"

@interface EntryDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton; 

@end

@implementation EntryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateWithEntry:self.entry];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


// MARK: - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if (self.saveButton == sender) {
        NSString *title = self.titleTextField.text;
        NSString *body = self.bodyTextView.text;
        NSDate *timestamp = [NSDate date];
        
        self.entry = [[Entry alloc]initWithTitle:title body:body timestamp:timestamp];
    }
}

// MARK: - Actions

- (IBAction)cancelButtonTapped:(UIBarButtonItem *)sender {
    UINavigationController *isPresentingInAddEntryMode = (UINavigationController *) [self presentingViewController];
    
    if (isPresentingInAddEntryMode) {
        [self dismissViewControllerAnimated:true completion:nil];
    } else {
        [[self navigationController] popViewControllerAnimated:true];
    }
}


// MARK: - Helper Functions

- (void)updateWithEntry:(Entry *)entry
{
    self.titleTextField.text = entry.title;
    self.navigationItem.title = entry.title;
    self.bodyTextView.text = entry.body;
    
}

@end
