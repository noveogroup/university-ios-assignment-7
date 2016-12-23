//
//  Game.m
//  Pong
//
//  Created by Admin on 07/08/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import "Game.h"
#import "PongBoard.h"
#import "Ball.h"
#import "Racket.h"

@interface Game ()

@property (nonatomic,strong)PongBoard* pongBoard;

@end


@implementation Game

-(instancetype)initWithPongBoard:(PongBoard *)pongBoard
{
    if(self = [super init]){
        _pongBoard = pongBoard;
    }
    return self;
}

-(void)main
{
    __weak typeof(self) wself = self;
    while (YES) {
        usleep(10000);
        @synchronized(wself.pongBoard){
            wself.pongBoard.ball.centre = (CGPoint){wself.pongBoard.ball.centre.x+wself.pongBoard.ball.horizontalSpeed,
                wself.pongBoard.ball.centre.y+wself.pongBoard.ball.verticalSpeed};
            for(NSString *key in wself.pongBoard.rackets){
                Racket* racket = [wself.pongBoard.rackets objectForKey:key];
                racket.centre = (CGPoint){racket.centre.x+racket.speed,
                    racket.centre.y};
            }
            
            if (wself.pongBoard.ball.centre.x <= wself.pongBoard.ball.size.width/2 ||
                wself.pongBoard.size.width - wself.pongBoard.ball.centre.x <= wself.pongBoard.ball.size.width/2) {
                wself.pongBoard.ball.horizontalSpeed *= -1;
            }
            if (wself.pongBoard.ball.centre.y <= wself.pongBoard.ball.size.height/2 ||
                wself.pongBoard.size.height - wself.pongBoard.ball.centre.y <= wself.pongBoard.ball.size.height/2) {
                wself.pongBoard.ball.verticalSpeed *= -1;
            }

        }
    }
}

@end
