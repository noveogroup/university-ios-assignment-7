//
//  Paddle.h
//  Pong
//
//  Created by Иван Букшев on 3/18/15.
//  Copyright (c) 2015 Ivan Bukshev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Paddle : NSObject

@property (nonatomic) CGSize size;
@property (nonatomic) CGPoint center;
@property (nonatomic) NSInteger speed;

- (instancetype)initWithSize:(CGSize)size center:(CGPoint)center;
- (instancetype)init NS_UNAVAILABLE;

+ (NSInteger)defaultSpeed;
+ (CGSize)defaultSize;

@end
