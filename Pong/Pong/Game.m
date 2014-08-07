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
    while (YES) {
        usleep(10000);
        @synchronized(self.pongBoard){
            self.pongBoard.ball.centre = (CGPoint){self.pongBoard.ball.centre.x+self.pongBoard.ball.horizontalSpeed,
                self.pongBoard.ball.centre.y+self.pongBoard.ball.verticalSpeed};
            for(NSString *key in self.pongBoard.rackets){
                Racket* racket = [self.pongBoard.rackets objectForKey:key];
                racket.centre = (CGPoint){racket.centre.x+racket.speed,
                    racket.centre.y};
            }
            
            if (self.pongBoard.ball.centre.x <= self.pongBoard.ball.size.width/2 ||
                self.pongBoard.size.width - self.pongBoard.ball.centre.x <= self.pongBoard.ball.size.width/2) {
                self.pongBoard.ball.horizontalSpeed *= -1;
            }
            if (self.pongBoard.ball.centre.y <= self.pongBoard.ball.size.height/2 ||
                self.pongBoard.size.height - self.pongBoard.ball.centre.y <= self.pongBoard.ball.size.height/2) {
                self.pongBoard.ball.verticalSpeed *= -1;
            }

        }
    }
}

@end
