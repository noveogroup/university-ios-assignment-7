//
//  PongBoard.h
//  Pong
//
//  Created by Admin on 07/08/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Racket;
@class Ball;

static NSString *const FirstRacketIdentifier = @"first";
static NSString *const SecondRacketIdentifier = @"second";

@interface PongBoard : NSObject

@property (nonatomic,strong) NSMutableDictionary* rackets;
@property (nonatomic, strong) Ball* ball;
@property (nonatomic) CGSize size;

-(instancetype)initWithSize:(CGSize)size;


@end
