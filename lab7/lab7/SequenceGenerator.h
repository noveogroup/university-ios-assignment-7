//
//  SequenceGenerator.h
//  lab7
//
//  Created by Admin on 11/08/14.
//  Copyright (c) 2014 Noveo Summer Internship. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SequenceGenerator : NSObject

@property (nonatomic, strong, readonly) NSNumber *value;
@property (nonatomic) unsigned int index;

- (void)next;

@end
