//
//  GameViewController.m
//  Pong
//
//  Created by Admin on 07/08/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import "GameViewController.h"
#import "PongBoard.h"
#import "Ball.h"
#import "Racket.h"
#import "PongBot.h"
#import "Game.h"

@interface GameViewController ()

@property (nonatomic,strong) UIView* ball;
@property (nonatomic,strong) UIView* firstRacket;
@property (nonatomic,strong) UIView* secondRacket;
@property (nonatomic,strong) PongBoard* pongBoard;

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    
    
    self.pongBoard = [[PongBoard alloc]initWithSize:(CGSize){self.view.bounds.size.width, self.view.bounds.size.height}];
    
    self.ball = [[UIView alloc]init];
    self.firstRacket = [[UIView alloc]init];
    self.secondRacket = [[UIView alloc]init];
    self.ball.backgroundColor = [UIColor whiteColor];
    self.firstRacket.backgroundColor = [UIColor whiteColor];
    self.secondRacket.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.ball];
    [self.view addSubview:self.firstRacket];
    [self.view addSubview:self.secondRacket];
    
    Game* game = [[Game alloc]initWithPongBoard:self.pongBoard];
    PongBot* bot1 = [[PongBot alloc]initWithPongBoard:self.pongBoard racketIdentifier:FirstRacketIdentifier];
    PongBot* bot2 = [[PongBot alloc]initWithPongBoard:self.pongBoard racketIdentifier:SecondRacketIdentifier];
    
    [game start];
    [bot1 start];
    [bot2 start];
    
    CADisplayLink* displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateBoard)];
    [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    
}

-(void)updateBoard
{
    self.ball.frame = (CGRect){self.pongBoard.ball.centre.x - self.pongBoard.ball.size.width/2,
        self.pongBoard.ball.centre.y - self.pongBoard.ball.size.height/2,
        self.pongBoard.ball.size.width, self.pongBoard.ball.size.height};
    
    Racket* racket = [self.pongBoard.rackets objectForKey:FirstRacketIdentifier];
    self.firstRacket.frame = (CGRect){racket.centre.x - racket.size.width/2,
        racket.centre.y - racket.size.height/2,
        racket.size.width, racket.size.height};
    
    racket = [self.pongBoard.rackets objectForKey:SecondRacketIdentifier];
    self.secondRacket.frame = (CGRect){racket.centre.x - racket.size.width/2,
        racket.centre.y - racket.size.height/2,
        racket.size.width, racket.size.height};
}


@end
