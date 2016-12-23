//
//  Board.h
//  Pong
//
//  Created by Иван Букшев on 3/18/15.
//  Copyright (c) 2015 Ivan Bukshev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Ball.h"
#import "Paddle.h"

@interface Board : NSObject

@property (nonatomic) CGSize size;
@property (nonatomic, strong) Ball *ball;
@property (nonatomic, strong) Paddle *topPaddle;
@property (nonatomic, strong) Paddle *bottomPaddle;

- (instancetype)initWithSize:(CGSize)size;
- (instancetype)init NS_UNAVAILABLE;

@end
