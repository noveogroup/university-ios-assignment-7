//
//  AIBot.m
//  Pong
//
//  Created by Иван Букшев on 3/18/15.
//  Copyright (c) 2015 Ivan Bukshev. All rights reserved.
//

#import "AIBot.h"

#define TIME_TICK 100000

@implementation AIBot

@synthesize board = _board;
@synthesize paddle = _paddle;

- (instancetype)initWithBoard:(Board *)board paddle:(Paddle *)paddle
{
    self = [super init];
    
    if (self)
    {
        _board = board;
        _paddle = paddle;
    }

    return self;
}

- (void)main
{
    __typeof(self) __weak weakSelf = self;
    
    while (YES)
    {
        @synchronized(weakSelf.board)
        {
            if (weakSelf.paddle.center.x < weakSelf.board.ball.center.x)
            {
                weakSelf.paddle.speed = ABS(weakSelf.paddle.speed);
            }
            else
            {
                weakSelf.paddle.speed = -ABS(weakSelf.paddle.speed);
            }
        }
        
        usleep(TIME_TICK);
    };
}

@end
