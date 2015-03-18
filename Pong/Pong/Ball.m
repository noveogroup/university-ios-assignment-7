//
//  Ball.m
//  Pong
//
//  Created by Иван Букшев on 3/18/15.
//  Copyright (c) 2015 Ivan Bukshev. All rights reserved.
//

#import "Ball.h"

@implementation Ball

@synthesize size = _size;
@synthesize center = _center;
@synthesize xSpeed = _xSpeed;
@synthesize ySpeed = _ySpeed;

- (instancetype)initWithSize:(CGSize)size center:(CGPoint)center
{
    self = [super init];
    
    if (self)
    {
        _size = size;
        _center = center;
        _xSpeed = [Ball xDefaultSpeed];
        _ySpeed = [Ball yDefaultSpeed];
    }
    
    return self;
}

+ (NSInteger)xDefaultSpeed
{
    return 1;
}

+ (NSInteger)yDefaultSpeed
{
    return 1;
}

+ (CGSize)defaultSize
{
    return (CGSize){3, 3};
}

@end
