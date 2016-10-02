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

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *bodyTextView;
@end

@implementation EntryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self updateWithEntry:self.entry];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// MARK: - Helper Functions

- (void)updateWithEntry:(Entry *)entry
{
    self.titleLabel.text = entry.title;
    self.navigationItem.title = entry.title;
    self.bodyTextView.text = entry.body;
    
}

@end
