//
//  Racket.h
//  Pong
//
//  Created by Admin on 07/08/14.
//  Copyright (c) 2014 MyCompanyName. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Racket : NSObject
@property (nonatomic) CGPoint centre;
@property (nonatomic) CGSize size;
@property (nonatomic) NSInteger speed;

-(instancetype)initWithCentre:(CGPoint)point size:(CGSize)size;

@end
