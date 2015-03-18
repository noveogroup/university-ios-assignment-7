//
//  AIBot.h
//  Pong
//
//  Created by Иван Букшев on 3/18/15.
//  Copyright (c) 2015 Ivan Bukshev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"
#import "Paddle.h"

@interface AIBot : NSThread

@property (nonatomic, strong) Board *board;
@property (nonatomic, strong) Paddle *paddle;

- (instancetype)initWithBoard:(Board *)board paddle:(Paddle *)paddle;
- (instancetype)init NS_UNAVAILABLE;

@end
