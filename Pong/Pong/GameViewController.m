//
//  GameViewController.m
//  Pong
//
//  Created by Иван Букшев on 3/17/15.
//  Copyright (c) 2015 Ivan Bukshev. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set field color.
    self.view.backgroundColor = [UIColor pongFieldColor];
    
    // Init our views.
    self.ball =[[UIView alloc] init];
    self.topPaddle =[[UIView alloc] init];
    self.bottomPaddle =[[UIView alloc] init];
    
    // Set bg to each element.
    self.ball.backgroundColor = [UIColor ballColor];
    self.topPaddle.backgroundColor = [UIColor paddleColor];
    self.bottomPaddle.backgroundColor = [UIColor paddleColor];
    
    // Add them to game field.
    [self.view addSubview:self.ball];
    [self.view addSubview:self.topPaddle];
    [self.view addSubview:self.bottomPaddle];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
