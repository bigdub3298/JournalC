//
//  Journal.h
//  JournalC
//
//  Created by Wesley Austin on 10/5/16.
//  Copyright © 2016 Wesley Austin. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface Journal : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray *entries;

- (instancetype)initWithTitle:(NSString *)title entries:(NSArray *)entries;

@end
