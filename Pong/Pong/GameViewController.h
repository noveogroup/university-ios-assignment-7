//
//  GameViewController.h
//  Pong
//
//  Created by Иван Букшев on 3/17/15.
//  Copyright (c) 2015 Ivan Bukshev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+PingPong.h"

@interface GameViewController : UIViewController

@property (nonatomic, strong) UIView *ball;
@property (nonatomic, strong) UIView *topPaddle;
@property (nonatomic, strong) UIView *bottomPaddle;

@end
