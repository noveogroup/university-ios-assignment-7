//
//  Paddle.m
//  Pong
//
//  Created by Иван Букшев on 3/18/15.
//  Copyright (c) 2015 Ivan Bukshev. All rights reserved.
//

#import "Paddle.h"

@implementation Paddle

@synthesize size = _size;
@synthesize center = _center;
@synthesize speed = _speed;

- (instancetype)initWithSize:(CGSize)size center:(CGPoint)center
{
    self = [super init];
    
    if (self)
    {
        _size = size;
        _center = center;
        _speed = [Paddle defaultSpeed];
    }
    
    return self;
}

+ (NSInteger)defaultSpeed
{
    return 1;
}

+ (CGSize)defaultSize
{
    return (CGSize){80, 4};
}

@end
