//
//  Game.h
//  Pong
//
//  Created by Admin on 07/08/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PongBoard;

@interface Game : NSThread

-(instancetype)initWithPongBoard:(PongBoard*)pongBoard;

@end
