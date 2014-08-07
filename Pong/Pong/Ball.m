//
//  Ball.m
//  Pong
//
//  Created by Admin on 07/08/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import "Ball.h"

static NSInteger BallVerticalSpeed = 2;
static NSInteger BallHorizontalSpeed = 2;

@implementation Ball

-(instancetype)initWithCentre:(CGPoint)centre size:(CGSize)size
{
    if (self = [super init]) {
        _centre = centre;
        _size = size;
        _verticalSpeed = BallVerticalSpeed;
        _horizontalSpeed = BallHorizontalSpeed;
    }
    return self;
}

@end
