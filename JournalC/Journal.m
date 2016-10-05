//
//  Journal.m
//  JournalC
//
//  Created by Wesley Austin on 10/5/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

#import "Journal.h"

@interface Journal ()

@property (nonatomic, strong) NSMutableArray *internalEntries;

@end

@implementation Journal

- (instancetype)initWithTitle:(NSString *)title entries:(NSArray *)entries
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _internalEntries = [entries mutableCopy];
    }
    return self;
}

- (NSArray *)entries
{
    return self.internalEntries; 
}

@end
