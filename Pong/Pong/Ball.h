//
//  Ball.h
//  Pong
//
//  Created by Иван Букшев on 3/18/15.
//  Copyright (c) 2015 Ivan Bukshev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ball : NSObject

@property (nonatomic) CGSize size;
@property (nonatomic) CGPoint center;
@property (nonatomic) NSInteger xSpeed;
@property (nonatomic) NSInteger ySpeed;

- (instancetype)initWithSize:(CGSize)size center:(CGPoint)center;
- (instancetype)init NS_UNAVAILABLE;

+ (NSInteger)xDefaultSpeed;
+ (NSInteger)yDefaultSpeed;
+ (CGSize)defaultSize;

@end
