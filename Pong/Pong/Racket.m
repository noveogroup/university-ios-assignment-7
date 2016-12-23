//
//  Racket.m
//  Pong
//
//  Created by Admin on 07/08/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import "Racket.h"

static NSInteger RacketSpeed = 1;

@implementation Racket

-(instancetype)initWithCentre:(CGPoint)centre size:(CGSize)size
{
    if (self = [super init]) {
        _centre = centre;
        _size = size;
        _speed = RacketSpeed;
    }
    return self;
}

@end
