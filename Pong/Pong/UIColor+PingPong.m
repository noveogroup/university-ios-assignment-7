//
//  UIColor+PingPong.m
//  Pong
//
//  Created by Иван Букшев on 3/17/15.
//  Copyright (c) 2015 Ivan Bukshev. All rights reserved.
//

#import "UIColor+PingPong.h"

@implementation UIColor (PingPong)

+ (UIColor *)fieldColor
{
    return [UIColor colorWithRed:51.0f/255.0f
                           green:102.0f/255.0f
                            blue:51.0f/255.0f
                           alpha:1.0f];
}

+ (UIColor *)ballColor
{
    return [UIColor whiteColor];
}

+ (UIColor *)paddleColor
{
    return [UIColor colorWithRed:51.0f/255.0f
                           green:153.0f/255.0f
                            blue:255.0f/255.0f
                           alpha:1.0f];
}

@end
