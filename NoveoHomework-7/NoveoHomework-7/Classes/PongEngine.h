//
//  PongEngine.h
//  NoveoHomework-7
//
//  Created by Wadim on 8/6/14.
//  Copyright (c) 2014 Smirnov Electronics. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PongEngine;
@class PongData;


#pragma mark - PongEngineDelegate Protocol

@protocol PongEngineDelegate <NSObject>

- (void)engine:(PongEngine *)engine didCalculateNewData:(PongData *)data;

@end


#pragma mark - PongData Interface

@interface PongData : NSObject <NSCopying>

@property (nonatomic, strong, readonly) NSValue /*with CGRect*/ *ballLayout;
@property (nonatomic, strong, readonly) NSValue /*with CGRect*/ *topBotLayout;
@property (nonatomic, strong, readonly) NSValue /*with CGRect*/ *bottomBotLayout;

@end


#pragma mark - PongEngine Interface

@interface PongEngine : NSThread

@property (nonatomic, readwrite) CGSize gameAreaSize;
@property (nonatomic, readwrite) NSInteger frameRate;
@property (nonatomic, strong) id<PongEngineDelegate> delegate;

@end
