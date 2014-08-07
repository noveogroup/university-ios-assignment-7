//
//  PongBot.m
//  Pong
//
//  Created by Admin on 07/08/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import "PongBot.h"
#import "PongBoard.h"
#import "Racket.h"
#import "Ball.h"

@interface PongBot ()

@property (nonatomic,strong) PongBoard* pongBoard;
@property (nonatomic,copy) NSString* racketIdentifier;

@end

@implementation PongBot

-(instancetype)initWithPongBoard:(PongBoard*)pongBoard racketIdentifier:(NSString*)identifier
{
    if(self = [super init]){
        _pongBoard = pongBoard;
        _racketIdentifier = identifier;
    }
    return self;
}

-(void)main
{
    Racket* racket = [self.pongBoard.rackets objectForKey:self.racketIdentifier];
    while (YES) {
        usleep(200000);
        @synchronized(self.pongBoard){
            if(racket.centre.x < self.pongBoard.ball.centre.x){
                racket.speed = ABS(racket.speed);
            } else {
                racket.speed = -ABS(racket.speed);
            }
        }
    }
}

@end
