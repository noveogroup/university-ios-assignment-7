//
//  GameManagement.h
//  Pong
//
//  Created by Иван Букшев on 3/18/15.
//  Copyright (c) 2015 Ivan Bukshev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Board.h"

@interface GameManagement : NSThread

@property (nonatomic, strong) Board *board;

- (instancetype)initWithBoard:(Board *)board;
- (instancetype)init NS_UNAVAILABLE;

@end
