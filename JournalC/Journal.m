//
//  Journal.m
//  JournalC
//
//  Created by Wesley Austin on 10/5/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

#import "Journal.h"

@interface Journal ()

@end

@implementation Journal

- (instancetype)initWithTitle:(NSString *)title entries:(NSArray *)entries timestamp:(NSDate *) timestamp
{
    self = [super init];
    if (self) {
        _title = [title copy];
        _entries = [entries mutableCopy];
        _timestamp = timestamp;
    }
    return self;
}


@end
