//
//  SequenceGenerator.m
//  lab7
//
//  Created by Admin on 11/08/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import "SequenceGenerator.h"

@implementation SequenceGenerator

@synthesize value;

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _index = 0;
    }
    
    return self;
}

- (NSNumber *)value {
    return [NSNumber numberWithInt:(self.index * (3 * self.index - 1) / 2)];
}

- (void)next {
    self.index++;
}


@end
