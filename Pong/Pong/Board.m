//
//  Board.m
//  Pong
//
//  Created by Иван Букшев on 3/18/15.
//  Copyright (c) 2015 Ivan Bukshev. All rights reserved.
//

#import "Board.h"

@implementation Board

@synthesize size = _size;
@synthesize ball = _ball;
@synthesize topPaddle = _topPaddle;
@synthesize bottomPaddle = _bottomPaddle;

- (instancetype)initWithSize:(CGSize)size
{
    self = [super init];
    
    if (self)
    {
        _size = size;
        _ball = [[Ball alloc] initWithSize:[Ball defaultSize] center:(CGPoint){_size.width/2, _size.height/2}];
        _topPaddle = [[Paddle alloc] initWithSize:[Paddle defaultSize] center:(CGPoint){_size.width/2, _size.height}];
        _bottomPaddle = [[Paddle alloc] initWithSize:[Paddle defaultSize] center:(CGPoint){_size.width/2, 0}];
    }
    
    return self;
}

@end
