//
//  Entry.h
//  JournalC
//
//  Created by Wesley Austin on 10/1/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Entry : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, strong) NSDate *timestamp;

- (instancetype)initWithTitle:(NSString *)title body:(NSString *) body timestamp:(NSDate *) timestamp;

@end
