//
//  Entry.m
//  JournalC
//
//  Created by Wesley Austin on 10/1/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

#import "Entry.h"

@implementation Entry


- (instancetype)initWithTitle:(NSString *)title body:(NSString *)body
{
    self = [super init];
    if(self) {
        _title = title;
        _body = body;
        _timestamp = [NSDate date];
    }
    return self;
}

@end
