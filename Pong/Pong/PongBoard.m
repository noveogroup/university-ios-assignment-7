//
//  PongBoard.m
//  Pong
//
//  Created by Admin on 07/08/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import "PongBoard.h"
#import "Ball.h"
#import "Racket.h"

@implementation PongBoard

-(instancetype)initWithSize:(CGSize)size
{
    if(self = [super init]){
        _size = size;
        _rackets = [[NSMutableDictionary alloc]init];
        [_rackets setObject:[[Racket alloc]initWithCentre:(CGPoint){size.width/2, 2} size:(CGSize){80,4}] forKey:FirstRacketIdentifier];
        [_rackets setObject:[[Racket alloc]initWithCentre:(CGPoint){size.width/2, size.height-2} size:(CGSize){80,4}] forKey:SecondRacketIdentifier];
        _ball = [[Ball alloc]initWithCentre:(CGPoint){size.width/2, size.height/2} size:(CGSize){10,10}];
    }
    return self;
}


@end
