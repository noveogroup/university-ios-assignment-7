//
//  GameViewController.m
//  Pong
//
//  Created by Иван Букшев on 3/18/15.
//  Copyright (c) 2015 Ivan Bukshev. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

@synthesize board = _board;
@synthesize ball = _ball;
@synthesize topPaddle = _topPaddle;
@synthesize bottomPaddle = _bottomPaddle;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set field color.
    self.view.backgroundColor = [UIColor fieldColor];
    
    _board = [[Board alloc] initWithSize:(CGSize){
                self.view.bounds.size.width,
                self.view.bounds.size.height
            }];
    
    // Init our views.
    _ball =[[UIView alloc] init];
    _topPaddle =[[UIView alloc] init];
    _bottomPaddle =[[UIView alloc] init];
    
    // Set bg to each element.
    _ball.backgroundColor = [UIColor ballColor];
    _topPaddle.backgroundColor = [UIColor paddleColor];
    _bottomPaddle.backgroundColor = [UIColor paddleColor];
    
    // Add them to game field.
    [self.view addSubview:_ball];
    [self.view addSubview:_topPaddle];
    [self.view addSubview:_bottomPaddle];
    
    GameManagement *game = [[GameManagement alloc] initWithBoard:_board];
    
    [game start];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:1.0f/60.0f
                                             target:self
                                           selector:@selector(updateBoard)
                                           userInfo:nil
                                            repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)updateBoard
{
    self.ball.frame = (CGRect){
        self.board.ball.center.x - self.board.ball.size.width/2,
        self.board.ball.center.y - self.board.ball.size.height/2,
        self.board.ball.size.width,
        self.board.ball.size.height
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
