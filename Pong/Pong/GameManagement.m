//
//  GameManagement.m
//  Pong
//
//  Created by Иван Букшев on 3/18/15.
//  Copyright (c) 2015 Ivan Bukshev. All rights reserved.
//

#import "GameManagement.h"

#define TIME_TICK 20000

@implementation GameManagement

@synthesize board = _board;

- (instancetype)initWithBoard:(Board *)board
{
    self = [super init];
    
    if (self)
    {
        _board = board;
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
            // Ball moving.
            weakSelf.board.ball.center = (CGPoint){
                weakSelf.board.ball.center.x + weakSelf.board.ball.xSpeed,
                weakSelf.board.ball.center.y + weakSelf.board.ball.ySpeed
            };
            
            // Top paddle moving.
            weakSelf.board.topPaddle.center = (CGPoint){
                weakSelf.board.ball.center.x,
                weakSelf.board.topPaddle.center.y
            };

            // Bottom paddle moving.
            weakSelf.board.bottomPaddle.center = (CGPoint){
                weakSelf.board.ball.center.x,
                weakSelf.board.bottomPaddle.center.y
            };

            // If ball bounced to left/right side.
            if (weakSelf.board.ball.center.x <= weakSelf.board.ball.size.width/2 ||
                weakSelf.board.size.width - weakSelf.board.ball.center.x <= weakSelf.board.ball.size.width/2)
            {
                weakSelf.board.ball.xSpeed *= -1;
            }
            
            // If ball bounced to top/bottom side.
            if (weakSelf.board.ball.center.y <= weakSelf.board.ball.size.height/2 ||
                weakSelf.board.size.height - weakSelf.board.ball.center.y <= weakSelf.board.ball.size.height/2)
            {
                weakSelf.board.ball.ySpeed *= -1;
            }
        }
        
        usleep(TIME_TICK);
    }
}

@end
